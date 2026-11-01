import 'dart:math' as math;

import '../entities/food.dart';

/// Result of a fuzzy search.
class FoodSearchResult {
  const FoodSearchResult({required this.food, required this.score});
  final Food food;
  final int score;
}

/// Offline fuzzy search over Food items. Pure Dart.
class FoodSearcher {
  const FoodSearcher();

  /// Unicode-aware regex that keeps letters, digits and combining marks.
  static final _tokenRe = RegExp(r'[\p{L}\p{M}\p{N}]+', unicode: true);

  /// Minimum score to be included in results.
  static const int threshold = 50;

  /// Maximum results to return.
  static const int maxResults = 50;

  /// Search [foods] by [query]. Returns scored matches above [threshold],
  /// sorted by descending score then ascending English name length.
  List<FoodSearchResult> search(List<Food> foods, String query) {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return const [];

    final queryTokens = _tokenise(trimmedQuery);
    if (queryTokens.isEmpty) return const [];

    final queryLower = trimmedQuery.toLowerCase();
    final results = <FoodSearchResult>[];

    for (final food in foods) {
      var bestScore = 0;
      for (final text in food.searchableTexts) {
        final score = _scoreText(text, queryTokens, queryLower);
        if (score > bestScore) bestScore = score;
      }
      if (bestScore >= threshold) {
        results.add(FoodSearchResult(food: food, score: bestScore));
      }
    }

    results.sort((a, b) {
      final cmp = b.score.compareTo(a.score);
      if (cmp != 0) return cmp;
      // Prefer the English name and shorter names on ties.
      return a.food.nameEn.length.compareTo(b.food.nameEn.length);
    });

    return results.length > maxResults ? results.sublist(0, maxResults) : results;
  }

  int _scoreText(String text, List<String> queryTokens, String queryLower) {
    final textLower = text.toLowerCase().trim();
    if (textLower.isEmpty) return 0;

    // 1. Exact full-string match (100)
    if (textLower == queryLower) return 100;

    // 2. Full-string prefix (90)
    if (textLower.startsWith(queryLower)) return 90;

    final textTokens = _tokenise(text);
    if (textTokens.isEmpty) return 0;

    var totalScore = 0;
    for (final qt in queryTokens) {
      var bestTokenScore = 0;

      // 3. Word-prefix (80)
      if (textTokens.any((tt) => tt.startsWith(qt))) {
        bestTokenScore = 80;
      } else if (textLower.contains(qt)) {
        // 4. Substring (70)
        bestTokenScore = 70;
      } else {
        // 5. Per-token Levenshtein: 62 - 5*distance (allowed: 0 for <=3, 1 for <=5, 2 above)
        final allowed = _allowedEdits(qt.length);
        var minDistance = 999;
        for (final tt in textTokens) {
          final dist = _levenshtein(tt, qt);
          if (dist < minDistance) {
            minDistance = dist;
          }
        }
        if (minDistance <= allowed) {
          bestTokenScore = 62 - 5 * minDistance;
        }
      }
      totalScore += bestTokenScore;
    }

    return totalScore ~/ queryTokens.length;
  }

  static int _allowedEdits(int length) {
    if (length <= 3) return 0;
    if (length <= 5) return 1;
    return 2;
  }

  static List<String> _tokenise(String text) =>
      _tokenRe
          .allMatches(text.toLowerCase())
          .map((m) => m.group(0)!)
          .toList();

  /// Standard Levenshtein distance.
  static int _levenshtein(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    final la = a.length;
    final lb = b.length;

    if ((la - lb).abs() > math.max(la, lb)) return math.max(la, lb);

    var prev = List<int>.generate(lb + 1, (i) => i);
    var curr = List<int>.filled(lb + 1, 0);

    for (var i = 1; i <= la; i++) {
      curr[0] = i;
      for (var j = 1; j <= lb; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        curr[j] = math.min(
          math.min(curr[j - 1] + 1, prev[j] + 1),
          prev[j - 1] + cost,
        );
      }
      final tmp = prev;
      prev = curr;
      curr = tmp;
    }
    return prev[lb];
  }
}

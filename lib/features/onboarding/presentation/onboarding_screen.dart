import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../profile/application/profile_providers.dart';
import '../application/onboarding_draft.dart';
import 'steps/about_you_step.dart';
import 'steps/food_step.dart';
import 'steps/lifestyle_step.dart';
import 'steps/summary_step.dart';
import 'steps/welcome_step.dart';

/// Steps: 0 welcome, 1 about you, 2 lifestyle & goal, 3 food preferences, 4 summary.
/// With [isEditing] the welcome step is skipped and saving pops back to the profile.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key, this.isEditing = false});

  final bool isEditing;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  static const _lastStep = 4;

  late final OnboardingDraft _draft;
  late int _step;
  bool _forward = true;
  bool _saving = false;

  int get _firstStep => widget.isEditing ? 1 : 0;

  @override
  void initState() {
    super.initState();
    final existing = ref.read(profileControllerProvider).value;
    _draft = existing != null ? OnboardingDraft.fromProfile(existing) : OnboardingDraft();
    _step = _firstStep;
  }

  void _refresh() => setState(() {});

  bool get _canContinue => switch (_step) {
        1 => _draft.isAboutValid,
        2 => _draft.isLifestyleValid,
        3 => _draft.isFoodValid,
        4 => _draft.isComplete && !_saving,
        _ => true,
      };

  String get _buttonLabel => switch (_step) {
        0 => 'Get started',
        4 => widget.isEditing ? 'Save changes' : 'Start my plan',
        _ => 'Continue',
      };

  void _back() {
    FocusScope.of(context).unfocus();
    if (_step > _firstStep) {
      setState(() {
        _forward = false;
        _step--;
      });
    } else if (widget.isEditing) {
      context.pop();
    }
  }

  Future<void> _next() async {
    FocusScope.of(context).unfocus();
    if (_step < _lastStep) {
      setState(() {
        _forward = true;
        _step++;
      });
      return;
    }
    await _save();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref.read(profileControllerProvider.notifier).save(_draft.toProfile());
      if (!mounted) return;
      // First-run: the router redirects to /home once the profile exists.
      if (widget.isEditing) context.pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Couldn't save your profile. Please try again.")),
      );
    }
  }

  Widget _buildStep() => switch (_step) {
        0 => const WelcomeStep(),
        1 => AboutYouStep(draft: _draft, onChanged: _refresh),
        2 => LifestyleStep(draft: _draft, onChanged: _refresh),
        3 => FoodStep(draft: _draft, onChanged: _refresh),
        _ => SummaryStep(draft: _draft),
      };

  @override
  Widget build(BuildContext context) {
    final showBack = _step > _firstStep || widget.isEditing;
    return PopScope(
      canPop: _step == _firstStep,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: showBack
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  tooltip: 'Back',
                  onPressed: _back,
                )
              : null,
          title: widget.isEditing ? const Text('Edit profile') : null,
        ),
        body: Column(
          children: [
            if (_step > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
                child: Semantics(
                  label: 'Step $_step of $_lastStep',
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(end: _step / _lastStep),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) => LinearProgressIndicator(
                      value: value,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                transitionBuilder: (child, animation) {
                  final slide = Tween<Offset>(
                    begin: Offset(_forward ? 0.06 : -0.06, 0),
                    end: Offset.zero,
                  ).animate(animation);
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(position: slide, child: child),
                  );
                },
                child: SingleChildScrollView(
                  key: ValueKey(_step),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.l, AppSpacing.m, AppSpacing.l, AppSpacing.l,
                  ),
                  child: _buildStep(),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.l, AppSpacing.s, AppSpacing.l, AppSpacing.m,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _canContinue ? _next : null,
                    child: _saving
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          )
                        : Text(_buttonLabel),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

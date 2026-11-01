import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Bottom navigation: Home, Plan, [Scan FAB], Recipes, Profile.
class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _scanIndex = 2;

  void _go(int index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );

  @override
  Widget build(BuildContext context) {
    final current = navigationShell.currentIndex;
    return Scaffold(
      body: navigationShell,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Semantics(
        button: true,
        selected: current == _scanIndex,
        label: 'Scan food',
        excludeSemantics: true,
        child: FloatingActionButton(
          tooltip: 'Scan',
          onPressed: () => _go(_scanIndex),
          child: const Icon(Icons.qr_code_scanner_rounded, size: 28),
        ),
      ),
      bottomNavigationBar: MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1.3, // keep tab labels from overflowing at large font sizes
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          height: 72,
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                selected: current == 0,
                onTap: () => _go(0),
              ),
              _NavItem(
                icon: Icons.restaurant_menu_rounded,
                label: 'Plan',
                selected: current == 1,
                onTap: () => _go(1),
              ),
              const SizedBox(width: 72), // room for the docked FAB
              _NavItem(
                icon: Icons.menu_book_rounded,
                label: 'Recipes',
                selected: current == 3,
                onTap: () => _go(3),
              ),
              _NavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                selected: current == 4,
                onTap: () => _go(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? scheme.primary : scheme.onSurfaceVariant;
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        excludeSemantics: true,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 64,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color),
                const SizedBox(height: 2),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: color,
                        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../domain/entities/food.dart';

/// Standard Indian dietary classification mark (Veg, Vegan, Egg, Non-Veg).
class DietBadge extends StatelessWidget {
  const DietBadge({super.key, required this.diet, this.size = 18});

  final FoodDiet diet;
  final double size;

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Widget symbol;

    switch (diet) {
      case FoodDiet.vegan:
        borderColor = const Color(0xFF2E9E6B);
        symbol = Icon(Icons.eco_rounded, size: size * 0.7, color: borderColor);
      case FoodDiet.veg:
        borderColor = const Color(0xFF2E9E6B);
        symbol = Container(
          width: size * 0.5,
          height: size * 0.5,
          decoration: BoxDecoration(color: borderColor, shape: BoxShape.circle),
        );
      case FoodDiet.egg:
        borderColor = const Color(0xFFE69500);
        symbol = Container(
          width: size * 0.5,
          height: size * 0.5,
          decoration: BoxDecoration(color: borderColor, shape: BoxShape.circle),
        );
      case FoodDiet.nonveg:
        borderColor = const Color(0xFFC62F35);
        symbol = CustomPaint(
          size: Size(size * 0.5, size * 0.5),
          painter: _TrianglePainter(borderColor),
        );
    }

    return Semantics(
      label: '${diet.name} food mark',
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(4),
          color: Colors.transparent,
        ),
        child: symbol,
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

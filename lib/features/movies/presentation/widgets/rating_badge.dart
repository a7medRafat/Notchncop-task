import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingBadge extends StatelessWidget {
  final double? rating;
  final double size;

  const RatingBadge({super.key, required this.rating, this.size = 32});

  @override
  Widget build(BuildContext context) {
    final value = rating ?? 0;
    final percent = (value / 10).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: percent,
            strokeWidth: 3,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation(_colorForRating(value)),
          ),
          Text(
            '${(value * 10).round()}%',
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Color _colorForRating(double value) {
    if (value >= 7) return Colors.greenAccent;
    if (value >= 5) return Colors.yellowAccent;
    return Colors.redAccent;
  }
}

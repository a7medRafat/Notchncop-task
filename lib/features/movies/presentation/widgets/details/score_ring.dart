import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreRing extends StatelessWidget {
  final double? score;

  const ScoreRing({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final v = (score ?? 0).clamp(0, 10);
    final pct = (v / 10).clamp(0.0, 1.0);
    final label = score == null ? '—' : '${(v * 10).round()}%';

    return SizedBox(
      width: 50.w,
      height: 50.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: pct,
            strokeWidth: 4.w,
            backgroundColor: Colors.white.withOpacity(0.25),
            valueColor: AlwaysStoppedAnimation(_colorFor(v.toDouble())),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 9.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Color _colorFor(double v) {
    if (v >= 7) return Colors.greenAccent;
    if (v >= 5) return Colors.yellowAccent;
    return Colors.redAccent;
  }
}

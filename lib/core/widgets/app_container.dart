import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final Gradient? gradient;
  final Function()? onTap;
  final List<BoxShadow>? shadow;
  final Clip? clipBehavior;

  const AppContainer({
    super.key,
    this.color,
    this.onTap,
    this.height,
    this.width,
    this.child,
    this.borderRadius,
    this.padding,
    this.margin,
    this.border,
    this.shadow,
    this.clipBehavior,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        clipBehavior: clipBehavior ?? Clip.none,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          gradient: gradient,
          boxShadow: shadow,
          borderRadius: borderRadius,
          border: border,
          color: color,
        ),
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          clipBehavior: clipBehavior ?? Clip.none,
          child: child,
        ),
      ),
    );
  }
}

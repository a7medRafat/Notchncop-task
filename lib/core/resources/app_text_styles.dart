import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/core/resources/AppColors.dart';
import 'package:tmdb_app/core/resources/app_fonts.dart';

class AppTextStyles {
  static TextStyle _getTextStyle({
    required FontWeight fontWeight,
    required Color fontColor,
    required double fontSize,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: FontFamily.fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: fontColor,
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
    );
  }

  static TextStyle w700({
    Color? fontColor,
    double? fontSize,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
  }) {
    double size = fontSize ?? 12;
    return _getTextStyle(
      fontWeight: FontWeightManager.w700,
      fontColor: fontColor ?? AppColors.primary,
      fontSize: size.sp,
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
    );
  }

  static TextStyle w600({
    Color? fontColor,
    double? fontSize,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
  }) {
    double size = fontSize ?? 12;
    return _getTextStyle(
      fontWeight: FontWeightManager.w600,
      fontColor: fontColor ?? AppColors.primary,
      fontSize: size.sp,
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
    );
  }

  static TextStyle w500({
    Color? fontColor,
    TextDecoration? decoration,
    double? fontSize,
    double? letterSpacing,
    double? height,
  }) {
    double size = fontSize ?? 12;
    return _getTextStyle(
      fontWeight: FontWeightManager.w500,
      fontColor: fontColor ?? AppColors.primary,
      fontSize: size.sp,
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
    );
  }

  static TextStyle w400({
    Color? fontColor,
    double? fontSize,
    double? letterSpacing,
    double? height,
  }) {
    double size = fontSize ?? 12;
    return _getTextStyle(
      fontWeight: FontWeightManager.w400,
      fontColor: fontColor ?? AppColors.primary,
      fontSize: size.sp,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle w300({
    required Color fontColor,
    double? fontSize,
    double? letterSpacing,
    double? height,
  }) {
    double size = fontSize ?? 12;
    return _getTextStyle(
      fontWeight: FontWeightManager.w300,
      fontColor: fontColor,
      fontSize: size.sp,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle w200({
    required Color fontColor,
    double? fontSize,
    double? letterSpacing,
    double? height,
  }) {
    double size = fontSize ?? 12;
    return _getTextStyle(
      fontWeight: FontWeightManager.w200,
      fontColor: fontColor,
      fontSize: size.sp,
      letterSpacing: letterSpacing,
    );
  }
}

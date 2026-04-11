// import 'package:flutter/material.dart';
//
// class AppColors {
//   static const Color primaryDark = Color(0xFF0A1F61);   // Dark blue
//   static const Color primary = Color(0xFF2752E7);        // Medium blue
//   static const Color topBgColour = Color(0xFFBCD2FA);        // Medium blue
//   static const Color primaryLight = Color(0xFF4F7BFF);   // Light blue
//
//   static const Color textDark = Color(0xFF000000);
//   static const Color grey = Color(0xFF9E9E9E);
//   static const Color white = Colors.white;
//
//
//   static const Color kPrimaryBlue = Color(0xff1E3A8A); // radio + text
//   static const Color kBorder = Color(0xffE2E8F0);
//   static const Color kHint = Color(0xff94A3B8);
//   static const Color kCardBg = Colors.white;
//
//   static const bg = Color(0xffEEF3FF);
//   // static const primary = Color(0xff4A67F6);
//   // static const textDark = Color(0xff1C1C1E);
//   static const textGrey = Color(0xff8E8E93);
//   static const border = Color(0xffE5E7EB);
//   static const success = Color(0xff4CAF50);
//
//   static const Color primaryBlue = Color(0xFF4865F6);
//   static const Color bgColor = Color(0xFFF6F8FF);
//   static const Color cardColor = Color(0xFFFFFFFF);
//   static const Color greyText = Color(0xFF8E8E93);
//   static const Color lightGrey = Color(0xFFE5E7EF);
//   static const Color starColor = Color(0xFFFFC107);
//   static const borderGrey = Color(0xFFEAEAEA);
//
//
//   static const LinearGradient bgGradient = LinearGradient(
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//     colors: [
//       // primaryDark,
//       primary,
//       primaryLight,
//     ],
//   );
//   static const LinearGradient bgTopGradient = LinearGradient(
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//     colors: [
//       // primaryDark,
//       topBgColour,
//       white,
//     ],
//   );
//
//   static final BoxShadow cardShadow = BoxShadow(
//     color: Colors.black.withOpacity(0.06),
//     blurRadius: 18,
//     offset: const Offset(0, 8),
//   );
//
// }
//

import 'package:flutter/material.dart';

class AppColors {
  // ✅ Icon-like Blues (from your icon palette)
  static const Color primaryDark = Color(0xFF03060F);   // Deep navy (background)
  static const Color primary     = Color(0xFF0E1D3A);   // Dark royal blue
  static const Color topBgColour = Color(0xFF182F58);   // Mid dark blue (top bg)
  static const Color primaryLight= Color(0xFF2B9BE6);   // Cyan glow blue

  // ✅ Keep neutrals same (no impact)
  static const Color textDark = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color white = Colors.white;

  // ✅ Replace only blue family to match icon
  static const Color kPrimaryBlue = Color(0xFF182F58); // radio + text (icon mid blue)
  static const Color kBorder = Color(0xffE2E8F0);
  static const Color kHint = Color(0xff94A3B8);
  static const Color kCardBg = Colors.white;

  // Backgrounds (kept light as before)
  static const bg = Color(0xffEEF3FF);
  static const textGrey = Color(0xff8E8E93);
  static const border = Color(0xffE5E7EB);
  static const success = Color(0xff4CAF50);

  // ✅ primaryBlue aligned to icon
  static const Color primaryBlue = Color(0xFF27528D); // deep blue accent from icon
  static const Color bgColor = Color(0xFFF6F8FF);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color greyText = Color(0xFF8E8E93);
  static const Color lightGrey = Color(0xFFE5E7EF);

  // ✅ Icon gold highlight (optional but matches shield/shine)
  static const Color starColor = Color(0xFFF0CB57);

  static const borderGrey = Color(0xFFEAEAEA);

  // ✅ Gradient updated to icon-like depth
  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryDark,
      primary,
      primaryLight,
    ],
  );

  static const LinearGradient bgTopGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      topBgColour,
      white,
    ],
  );

  static final BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.06),
    blurRadius: 18,
    offset: const Offset(0, 8),
  );
}
import 'package:flutter/material.dart';

/// Shared constants for the Battle Card app

// Card dimensions
const double kCardWidth = 300;
const double kCardHeight = 420;

// Illustration area aspect ratio (width/height)
// This ratio is used both in the card widget and the home screen preview
// to ensure they match exactly
const double kIllustrationAspectRatio = 284 / 206;

// Design system colors - bright and child-friendly
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFFFF6B6B);  // Coral red
  static const Color secondary = Color(0xFF4ECDC4);  // Teal
  static const Color accent = Color(0xFFFFE66D);  // Yellow
  
  // Background colors
  static const Color backgroundDark = Color(0xFF2D1B69);  // Deep purple
  static const Color backgroundLight = Color(0xFF667EEA);  // Light purple
  
  // Fun gradient colors
  static const Color gradientStart = Color(0xFF667EEA);  // Purple
  static const Color gradientMiddle = Color(0xFF764BA2);  // Magenta
  static const Color gradientEnd = Color(0xFFF093FB);  // Pink
  
  // Card colors
  static const Color cardBackground = Color(0xFF3D2785);  // Purple
  static const Color cardBorder = Color(0xFFFFD93D);  // Gold
  
  // Text colors
  static const Color textLight = Colors.white;
  static const Color textDark = Color(0xFF2D1B69);
  
  // Attribute colors (brighter versions)
  static const Color fire = Color(0xFFFF6B6B);
  static const Color water = Color(0xFF4ECDC4);
  static const Color earth = Color(0xFF95E1A3);
  static const Color wind = Color(0xFF87CEEB);
  static const Color light = Color(0xFFFFE66D);
  static const Color dark = Color(0xFF9B59B6);
}

// Design system values
class AppDesign {
  // Corner radii
  static const double radiusSmall = 8;
  static const double radiusMedium = 16;
  static const double radiusLarge = 24;
  static const double radiusXLarge = 32;
  
  // Padding
  static const double paddingSmall = 8;
  static const double paddingMedium = 16;
  static const double paddingLarge = 24;
  
  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 400);
  static const Duration animationSlow = Duration(milliseconds: 800);
}

// Text styles
class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [
      Shadow(
        color: Colors.black26,
        blurRadius: 4,
        offset: Offset(2, 2),
      ),
    ],
  );
  
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: Colors.white,
  );
  
  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

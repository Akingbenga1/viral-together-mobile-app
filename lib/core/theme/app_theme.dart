import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Enhanced Color Palette - Modern & Sophisticated
  
  // Primary Colors - Rich Indigo/Purple gradient system
  static const Color primaryColor = Color(0xFF6366F1);        // Indigo-500
  static const Color primaryVariant = Color(0xFF4F46E5);      // Indigo-600
  static const Color primaryLight = Color(0xFF818CF8);        // Indigo-400
  static const Color primaryDark = Color(0xFF3730A3);         // Indigo-700
  static const Color primaryAccent = Color(0xFF8B5CF6);       // Violet-500
  
  // Secondary Colors - Emerald green system
  static const Color secondaryColor = Color(0xFF10B981);      // Emerald-500
  static const Color secondaryVariant = Color(0xFF059669);    // Emerald-600
  static const Color secondaryLight = Color(0xFF34D399);      // Emerald-400
  static const Color secondaryDark = Color(0xFF047857);       // Emerald-700
  
  // Accent Colors for visual interest
  static const Color accentOrange = Color(0xFFF59E0B);        // Amber-500
  static const Color accentPink = Color(0xFFEC4899);          // Pink-500
  static const Color accentTeal = Color(0xFF14B8A6);          // Teal-500
  static const Color accentRose = Color(0xFFF43F5E);          // Rose-500
  
  // Neutral Grays - More sophisticated palette
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF4F4F5);
  static const Color gray200 = Color(0xFFE4E4E7);
  static const Color gray300 = Color(0xFFD4D4D8);
  static const Color gray400 = Color(0xFFA1A1AA);
  static const Color gray500 = Color(0xFF71717A);
  static const Color gray600 = Color(0xFF52525B);
  static const Color gray700 = Color(0xFF3F3F46);
  static const Color gray800 = Color(0xFF27272A);
  static const Color gray900 = Color(0xFF18181B);
  
  // Background Colors
  static const Color backgroundColor = Color(0xFFFAFAFA);     // gray50
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF4F4F5);     // gray100
  
  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF0F0F0F);      // Near black
  static const Color darkSurface = Color(0xFF18181B);        // gray900
  static const Color darkSurfaceVariant = Color(0xFF27272A); // gray800
  
  // Status Colors
  static const Color errorColor = Color(0xFFEF4444);         // Red-500
  static const Color warningColor = Color(0xFFF59E0B);       // Amber-500
  static const Color successColor = Color(0xFF22C55E);       // Green-500
  static const Color infoColor = Color(0xFF3B82F6);          // Blue-500
  
  // Text Colors
  static const Color textPrimary = Color(0xFF18181B);        // gray900
  static const Color textSecondary = Color(0xFF52525B);      // gray600
  static const Color textTertiary = Color(0xFF71717A);       // gray500
  static const Color textDisabled = Color(0xFFA1A1AA);       // gray400
  
  // Dark Text Colors
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFD4D4D8);  // gray300
  static const Color darkTextTertiary = Color(0xFFA1A1AA);   // gray400
  
  // Border and Divider Colors
  static const Color borderColor = Color(0xFFE4E4E7);        // gray200
  static const Color borderLight = Color(0xFFF4F4F5);        // gray100
  static const Color dividerColor = Color(0xFFE4E4E7);       // gray200
  
  // Shadow Colors
  static const Color shadowLight = Color(0x0A000000);        // 4% black
  static const Color shadowMedium = Color(0x14000000);       // 8% black
  static const Color shadowHeavy = Color(0x1F000000);        // 12% black
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, primaryAccent],
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryColor, accentTeal],
  );
  
  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFFAFAFA)],
  );
  
  // Spacing System
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;
  
  // Border Radius System
  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 20.0;
  static const double radius2XL = 24.0;
  static const double radiusFull = 9999.0;

  // Light Theme - Enhanced and Modern
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        primaryContainer: primaryLight,
        onPrimaryContainer: primaryDark,
        secondary: secondaryColor,
        onSecondary: Colors.white,
        secondaryContainer: secondaryLight,
        onSecondaryContainer: secondaryDark,
        tertiary: primaryAccent,
        onTertiary: Colors.white,
        error: errorColor,
        onError: Colors.white,
        errorContainer: Color(0xFFFFEDEA),
        onErrorContainer: Color(0xFF410E0B),
        surface: surfaceColor,
        onSurface: textPrimary,
        surfaceVariant: surfaceVariant,
        onSurfaceVariant: textSecondary,
        background: backgroundColor,
        onBackground: textPrimary,
        outline: borderColor,
        outlineVariant: borderLight,
        shadow: shadowMedium,
        scrim: Color(0x80000000),
        inverseSurface: gray800,
        onInverseSurface: Colors.white,
        inversePrimary: primaryLight,
      ),
      fontFamily: 'Poppins', // Enabled for better typography
      // Enhanced Typography with better hierarchy and spacing
      textTheme: const TextTheme(
        // Display styles - For large headings
        displayLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: -0.5,
          height: 1.1,
        ),
        displayMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.25,
          height: 1.15,
        ),
        displaySmall: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: 0,
          height: 1.2,
        ),
        
        // Headline styles - For section headers
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0,
          height: 1.3,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.15,
          height: 1.3,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.15,
          height: 1.4,
        ),
        
        // Title styles - For component titles
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.1,
          height: 1.4,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textSecondary,
          letterSpacing: 0.5,
          height: 1.3,
        ),
        
        // Body styles - For main content
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textPrimary,
          letterSpacing: 0.5,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textPrimary,
          letterSpacing: 0.25,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          letterSpacing: 0.4,
          height: 1.4,
        ),
        
        // Label styles - For UI elements
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          letterSpacing: 0.1,
          height: 1.4,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textSecondary,
          letterSpacing: 0.5,
          height: 1.3,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: textTertiary,
          letterSpacing: 1.5,
          height: 1.2,
        ),
      ),
      // Enhanced AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleSpacing: spacing24,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.15,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      
      // Enhanced Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: shadowMedium,
          padding: const EdgeInsets.symmetric(horizontal: spacing24, vertical: spacing16),
          minimumSize: const Size(120, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.white.withOpacity(0.1);
              }
              if (states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(0.2);
              }
              return null;
            },
          ),
        ),
      ),
      
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: spacing24, vertical: spacing16),
          minimumSize: const Size(120, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: spacing24, vertical: spacing16),
          minimumSize: const Size(120, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return primaryColor.withOpacity(0.04);
              }
              if (states.contains(MaterialState.pressed)) {
                return primaryColor.withOpacity(0.08);
              }
              return null;
            },
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: spacing16, vertical: spacing12),
          minimumSize: const Size(64, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSM),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return primaryColor.withOpacity(0.04);
              }
              if (states.contains(MaterialState.pressed)) {
                return primaryColor.withOpacity(0.08);
              }
              return null;
            },
          ),
        ),
      ),
      
      // Enhanced Input Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: spacing16, vertical: spacing16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: borderLight, width: 1),
        ),
        hintStyle: const TextStyle(
          color: textTertiary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: const TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: const TextStyle(
          color: primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: const TextStyle(
          color: errorColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      
      // Enhanced Card Theme
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shadowColor: shadowLight,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLG),
          side: const BorderSide(color: borderLight, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      
      // Enhanced List Tile Theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: spacing20, vertical: spacing8),
        minLeadingWidth: 24,
        iconColor: textSecondary,
        textColor: textPrimary,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
      ),
      
      // Enhanced Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: gray100,
        deleteIconColor: textSecondary,
        disabledColor: gray200,
        selectedColor: primaryColor.withOpacity(0.1),
        secondarySelectedColor: secondaryColor.withOpacity(0.1),
        shadowColor: shadowLight,
        labelPadding: const EdgeInsets.symmetric(horizontal: spacing12, vertical: spacing4),
        padding: const EdgeInsets.symmetric(horizontal: spacing16, vertical: spacing8),
        side: const BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
        ),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        secondaryLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
      ),
      
      // Enhanced Divider Theme
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
        space: 1,
      ),
      
      // Enhanced Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return gray300;
            }
            if (states.contains(MaterialState.selected)) {
              return primaryColor;
            }
            return gray400;
          },
        ),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return gray200;
            }
            if (states.contains(MaterialState.selected)) {
              return primaryColor.withOpacity(0.3);
            }
            return gray300;
          },
        ),
      ),
    );
  }

  // Enhanced Dark Theme - Premium Dark Mode
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryLight,
        onPrimary: darkBackground,
        primaryContainer: primaryDark,
        onPrimaryContainer: primaryLight,
        secondary: secondaryLight,
        onSecondary: darkBackground,
        secondaryContainer: secondaryDark,
        onSecondaryContainer: secondaryLight,
        tertiary: primaryAccent,
        onTertiary: darkBackground,
        error: errorColor,
        onError: Colors.white,
        errorContainer: Color(0xFF2D1B1B),
        onErrorContainer: Color(0xFFFFB4AB),
        surface: darkSurface,
        onSurface: darkTextPrimary,
        surfaceVariant: darkSurfaceVariant,
        onSurfaceVariant: darkTextSecondary,
        background: darkBackground,
        onBackground: darkTextPrimary,
        outline: gray600,
        outlineVariant: gray700,
        shadow: Color(0x80000000),
        scrim: Color(0xCC000000),
        inverseSurface: gray100,
        onInverseSurface: gray900,
        inversePrimary: primaryDark,
      ),
      fontFamily: 'Poppins', // Enhanced typography for dark mode
      // Enhanced Dark Mode Typography
      textTheme: const TextTheme(
        // Display styles - For large headings
        displayLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w800,
          color: darkTextPrimary,
          letterSpacing: -0.5,
          height: 1.1,
        ),
        displayMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: darkTextPrimary,
          letterSpacing: -0.25,
          height: 1.15,
        ),
        displaySmall: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: darkTextPrimary,
          letterSpacing: 0,
          height: 1.2,
        ),
        
        // Headline styles - For section headers
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
          letterSpacing: 0,
          height: 1.3,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
          letterSpacing: 0.15,
          height: 1.3,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
          letterSpacing: 0.15,
          height: 1.4,
        ),
        
        // Title styles - For component titles
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
          letterSpacing: 0.1,
          height: 1.4,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: darkTextSecondary,
          letterSpacing: 0.5,
          height: 1.3,
        ),
        
        // Body styles - For main content
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: darkTextPrimary,
          letterSpacing: 0.5,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: darkTextPrimary,
          letterSpacing: 0.25,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: darkTextSecondary,
          letterSpacing: 0.4,
          height: 1.4,
        ),
        
        // Label styles - For UI elements
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: darkTextPrimary,
          letterSpacing: 0.1,
          height: 1.4,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: darkTextSecondary,
          letterSpacing: 0.5,
          height: 1.3,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: darkTextTertiary,
          letterSpacing: 1.5,
          height: 1.2,
        ),
      ),
      // Enhanced Dark Mode AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: darkTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleSpacing: spacing24,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
          letterSpacing: 0.15,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      
      // Enhanced Dark Mode Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLight,
          foregroundColor: darkBackground,
          elevation: 0,
          shadowColor: Color(0x40000000),
          padding: const EdgeInsets.symmetric(horizontal: spacing24, vertical: spacing16),
          minimumSize: const Size(120, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.black.withOpacity(0.08);
              }
              if (states.contains(MaterialState.pressed)) {
                return Colors.black.withOpacity(0.12);
              }
              return null;
            },
          ),
        ),
      ),
      
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryLight,
          foregroundColor: darkBackground,
          padding: const EdgeInsets.symmetric(horizontal: spacing24, vertical: spacing16),
          minimumSize: const Size(120, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLight,
          side: const BorderSide(color: primaryLight, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: spacing24, vertical: spacing16),
          minimumSize: const Size(120, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return primaryLight.withOpacity(0.04);
              }
              if (states.contains(MaterialState.pressed)) {
                return primaryLight.withOpacity(0.08);
              }
              return null;
            },
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryLight,
          padding: const EdgeInsets.symmetric(horizontal: spacing16, vertical: spacing12),
          minimumSize: const Size(64, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSM),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return primaryLight.withOpacity(0.04);
              }
              if (states.contains(MaterialState.pressed)) {
                return primaryLight.withOpacity(0.08);
              }
              return null;
            },
          ),
        ),
      ),
      
      // Enhanced Dark Mode Input Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceVariant,
        contentPadding: const EdgeInsets.symmetric(horizontal: spacing16, vertical: spacing16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: gray600, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: gray600, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMD),
          borderSide: const BorderSide(color: gray700, width: 1),
        ),
        hintStyle: const TextStyle(
          color: darkTextTertiary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: const TextStyle(
          color: darkTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: const TextStyle(
          color: primaryLight,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: const TextStyle(
          color: errorColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      
      // Enhanced Dark Mode Card Theme
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shadowColor: Color(0x40000000),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLG),
          side: const BorderSide(color: gray700, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      
      // Enhanced Dark Mode List Tile Theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: spacing20, vertical: spacing8),
        minLeadingWidth: 24,
        iconColor: darkTextSecondary,
        textColor: darkTextPrimary,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: darkTextPrimary,
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: darkTextSecondary,
        ),
      ),
      
      // Enhanced Dark Mode Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: gray800,
        deleteIconColor: darkTextSecondary,
        disabledColor: gray700,
        selectedColor: primaryLight.withOpacity(0.2),
        secondarySelectedColor: secondaryLight.withOpacity(0.2),
        shadowColor: Color(0x40000000),
        labelPadding: const EdgeInsets.symmetric(horizontal: spacing12, vertical: spacing4),
        padding: const EdgeInsets.symmetric(horizontal: spacing16, vertical: spacing8),
        side: const BorderSide(color: gray600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
        ),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: darkTextPrimary,
        ),
        secondaryLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: darkTextPrimary,
        ),
      ),
      
      // Enhanced Dark Mode Divider Theme
      dividerTheme: const DividerThemeData(
        color: gray700,
        thickness: 1,
        space: 1,
      ),
      
      // Enhanced Dark Mode Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return gray600;
            }
            if (states.contains(MaterialState.selected)) {
              return primaryLight;
            }
            return gray400;
          },
        ),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return gray700;
            }
            if (states.contains(MaterialState.selected)) {
              return primaryLight.withOpacity(0.3);
            }
            return gray600;
          },
        ),
      ),
    );
  }
} 
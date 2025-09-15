import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum ButtonVariant { primary, secondary, tertiary, outline, ghost, gradient }
enum ButtonSize { small, medium, large, extraLarge }

class EnhancedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final IconData? icon;
  final bool iconAtEnd;
  final bool isLoading;
  final bool isFullWidth;
  final Color? customColor;
  final Gradient? customGradient;
  final double? borderRadius;

  const EnhancedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.iconAtEnd = false,
    this.isLoading = false,
    this.isFullWidth = false,
    this.customColor,
    this.customGradient,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Size configurations
    late double fontSize;
    late EdgeInsets padding;
    late double minHeight;
    late double iconSize;

    switch (size) {
      case ButtonSize.small:
        fontSize = 14;
        padding = const EdgeInsets.symmetric(horizontal: AppTheme.spacing16, vertical: AppTheme.spacing8);
        minHeight = 32;
        iconSize = 16;
        break;
      case ButtonSize.medium:
        fontSize = 16;
        padding = const EdgeInsets.symmetric(horizontal: AppTheme.spacing24, vertical: AppTheme.spacing12);
        minHeight = 44;
        iconSize = 18;
        break;
      case ButtonSize.large:
        fontSize = 18;
        padding = const EdgeInsets.symmetric(horizontal: AppTheme.spacing32, vertical: AppTheme.spacing16);
        minHeight = 52;
        iconSize = 20;
        break;
      case ButtonSize.extraLarge:
        fontSize = 20;
        padding = const EdgeInsets.symmetric(horizontal: AppTheme.spacing40, vertical: AppTheme.spacing20);
        minHeight = 60;
        iconSize = 24;
        break;
    }

    final buttonRadius = borderRadius ?? AppTheme.radiusMD;

    // Loading indicator
    Widget? loadingIndicator = isLoading
        ? SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getTextColor(isDark),
              ),
            ),
          )
        : null;

    // Button content with icon
    List<Widget> buttonContent = [];
    
    if (isLoading) {
      buttonContent.add(loadingIndicator!);
    } else {
      if (icon != null && !iconAtEnd) {
        buttonContent.add(Icon(icon, size: iconSize));
        buttonContent.add(SizedBox(width: AppTheme.spacing8));
      }
      
      buttonContent.add(
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      );
      
      if (icon != null && iconAtEnd) {
        buttonContent.add(SizedBox(width: AppTheme.spacing8));
        buttonContent.add(Icon(icon, size: iconSize));
      }
    }

    Widget child = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttonContent,
    );

    // Apply variant styling
    switch (variant) {
      case ButtonVariant.primary:
        return _buildPrimaryButton(context, child, padding, minHeight, buttonRadius, isDark);
      
      case ButtonVariant.secondary:
        return _buildSecondaryButton(context, child, padding, minHeight, buttonRadius, isDark);
      
      case ButtonVariant.tertiary:
        return _buildTertiaryButton(context, child, padding, minHeight, buttonRadius, isDark);
      
      case ButtonVariant.outline:
        return _buildOutlineButton(context, child, padding, minHeight, buttonRadius, isDark);
      
      case ButtonVariant.ghost:
        return _buildGhostButton(context, child, padding, minHeight, buttonRadius, isDark);
      
      case ButtonVariant.gradient:
        return _buildGradientButton(context, child, padding, minHeight, buttonRadius, isDark);
    }
  }

  Widget _buildPrimaryButton(BuildContext context, Widget child, EdgeInsets padding, 
                           double minHeight, double borderRadius, bool isDark) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      height: minHeight,
      decoration: BoxDecoration(
        color: customColor ?? AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: onPressed != null ? [
          BoxShadow(
            color: (customColor ?? AppTheme.primaryColor).withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ] : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context, Widget child, EdgeInsets padding,
                             double minHeight, double borderRadius, bool isDark) {
    final bgColor = customColor ?? AppTheme.secondaryColor;
    return Container(
      width: isFullWidth ? double.infinity : null,
      height: minHeight,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: onPressed != null ? [
          BoxShadow(
            color: bgColor.withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ] : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTertiaryButton(BuildContext context, Widget child, EdgeInsets padding,
                            double minHeight, double borderRadius, bool isDark) {
    final bgColor = isDark ? AppTheme.gray800 : AppTheme.gray100;
    return Container(
      width: isFullWidth ? double.infinity : null,
      height: minHeight,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton(BuildContext context, Widget child, EdgeInsets padding,
                           double minHeight, double borderRadius, bool isDark) {
    final borderColor = customColor ?? AppTheme.primaryColor;
    return Container(
      width: isFullWidth ? double.infinity : null,
      height: minHeight,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: DefaultTextStyle(
              style: TextStyle(color: borderColor),
              child: IconTheme(
                data: IconThemeData(color: borderColor),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGhostButton(BuildContext context, Widget child, EdgeInsets padding,
                         double minHeight, double borderRadius, bool isDark) {
    final textColor = customColor ?? AppTheme.primaryColor;
    return Container(
      width: isFullWidth ? double.infinity : null,
      height: minHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: DefaultTextStyle(
              style: TextStyle(color: textColor),
              child: IconTheme(
                data: IconThemeData(color: textColor),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton(BuildContext context, Widget child, EdgeInsets padding,
                            double minHeight, double borderRadius, bool isDark) {
    final gradient = customGradient ?? AppTheme.primaryGradient;
    return Container(
      width: isFullWidth ? double.infinity : null,
      height: minHeight,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: onPressed != null ? [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.4),
            offset: const Offset(0, 6),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ] : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: IconTheme(
                data: IconThemeData(color: Colors.white),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getTextColor(bool isDark) {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
      case ButtonVariant.gradient:
        return Colors.white;
      case ButtonVariant.tertiary:
        return isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary;
      case ButtonVariant.outline:
      case ButtonVariant.ghost:
        return customColor ?? AppTheme.primaryColor;
    }
  }
}
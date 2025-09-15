import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum CardVariant { elevated, outlined, filled, gradient }

class EnhancedCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final CardVariant variant;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double borderRadius;
  final bool showShadow;
  final double elevation;
  final Border? border;

  const EnhancedCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.variant = CardVariant.elevated,
    this.backgroundColor,
    this.gradient,
    this.borderRadius = AppTheme.radiusLG,
    this.showShadow = false,
    this.elevation = 0,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    Color bgColor = backgroundColor ?? 
                   (isDark ? AppTheme.darkSurface : AppTheme.surfaceColor);
    
    BoxDecoration decoration;
    
    switch (variant) {
      case CardVariant.elevated:
        decoration = BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: showShadow ? [
            BoxShadow(
              color: isDark ? AppTheme.shadowHeavy : AppTheme.shadowLight,
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ] : [],
        );
        break;
        
      case CardVariant.outlined:
        decoration = BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border ?? Border.all(
            color: isDark ? AppTheme.gray700 : AppTheme.borderColor,
            width: 1,
          ),
        );
        break;
        
      case CardVariant.filled:
        decoration = BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
        );
        break;
        
      case CardVariant.gradient:
        decoration = BoxDecoration(
          gradient: gradient ?? AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: showShadow ? [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ] : [],
        );
        break;
    }

    Widget cardWidget = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: decoration,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppTheme.spacing20),
        child: child,
      ),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: cardWidget,
        ),
      );
    }

    return cardWidget;
  }
}
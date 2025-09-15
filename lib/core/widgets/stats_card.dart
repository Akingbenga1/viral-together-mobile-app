import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final double? percentage;
  final bool isIncreasing;
  final String? changeLabel;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final double borderRadius;
  final bool showBorder;
  final bool showShadow;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.backgroundGradient,
    this.percentage,
    this.isIncreasing = true,
    this.changeLabel,
    this.onTap,
    this.padding,
    this.borderRadius = AppTheme.radiusLG,
    this.showBorder = true,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Colors
    final cardBgColor = backgroundColor ?? 
                       (isDark ? AppTheme.darkSurface : AppTheme.surfaceColor);
    final titleColor = isDark ? AppTheme.darkTextSecondary : AppTheme.textSecondary;
    final valueColor = isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary;
    final cardIconColor = iconColor ?? AppTheme.primaryColor;

    // Change indicator colors
    final changeColor = isIncreasing 
        ? AppTheme.successColor 
        : AppTheme.errorColor;

    Widget cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row with title and icon
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: titleColor,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: AppTheme.spacing8),
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: cardIconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: cardIconColor,
                ),
              ),
            ],
          ],
        ),
        
        const SizedBox(height: AppTheme.spacing12),
        
        // Main value
        Text(
          value,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        
        // Subtitle or change indicator
        if (subtitle != null || percentage != null || changeLabel != null) ...[
          const SizedBox(height: AppTheme.spacing8),
          Row(
            children: [
              // Subtitle
              if (subtitle != null)
                Expanded(
                  child: Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: titleColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              
              // Change indicator
              if (percentage != null || changeLabel != null) ...[
                if (subtitle != null) const SizedBox(width: AppTheme.spacing8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing8,
                    vertical: AppTheme.spacing4,
                  ),
                  decoration: BoxDecoration(
                    color: changeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusXS),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isIncreasing 
                            ? Icons.trending_up 
                            : Icons.trending_down,
                        size: 12,
                        color: changeColor,
                      ),
                      const SizedBox(width: AppTheme.spacing4),
                      Text(
                        changeLabel ?? '${percentage!.toStringAsFixed(1)}%',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: changeColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ],
    );

    // Card container
    Widget card = Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        color: backgroundGradient == null ? cardBgColor : null,
        gradient: backgroundGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: showBorder ? Border.all(
          color: isDark ? AppTheme.gray700 : AppTheme.borderColor,
          width: 1,
        ) : null,
        boxShadow: showShadow ? [
          BoxShadow(
            color: isDark ? AppTheme.shadowMedium : AppTheme.shadowLight,
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ] : null,
      ),
      child: cardContent,
    );

    // Wrap with tap gesture if onTap is provided
    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: card,
        ),
      );
    }

    return card;
  }
}

// Specialized variant for gradient stats cards
class GradientStatsCard extends StatsCard {
  const GradientStatsCard({
    super.key,
    required super.title,
    required super.value,
    super.subtitle,
    super.icon,
    super.iconColor = Colors.white,
    super.percentage,
    super.isIncreasing = true,
    super.changeLabel,
    super.onTap,
    super.padding,
    super.borderRadius = AppTheme.radiusLG,
    super.showBorder = false,
    super.showShadow = true,
    Gradient? gradient,
  }) : super(
    backgroundGradient: gradient ?? AppTheme.primaryGradient,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        gradient: backgroundGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: showShadow ? [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ] : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with title and icon
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: AppTheme.spacing8),
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ],
          ),
          
          const SizedBox(height: AppTheme.spacing12),
          
          // Main value
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          
          // Subtitle or change indicator
          if (subtitle != null || percentage != null || changeLabel != null) ...[
            const SizedBox(height: AppTheme.spacing8),
            Row(
              children: [
                // Subtitle
                if (subtitle != null)
                  Expanded(
                    child: Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                
                // Change indicator
                if (percentage != null || changeLabel != null) ...[
                  if (subtitle != null) const SizedBox(width: AppTheme.spacing8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing8,
                      vertical: AppTheme.spacing4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppTheme.radiusXS),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isIncreasing 
                              ? Icons.trending_up 
                              : Icons.trending_down,
                          size: 12,
                          color: Colors.white,
                        ),
                        const SizedBox(width: AppTheme.spacing4),
                        Text(
                          changeLabel ?? '${percentage!.toStringAsFixed(1)}%',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final IconData? actionIcon;
  final Widget? customAction;
  final EdgeInsetsGeometry? padding;
  final bool showDivider;
  final CrossAxisAlignment alignment;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onActionPressed,
    this.actionIcon,
    this.customAction,
    this.padding,
    this.showDivider = false,
    this.alignment = CrossAxisAlignment.start,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget headerContent = Column(
      crossAxisAlignment: alignment,
      children: [
        // Main header row
        Row(
          children: [
            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: titleStyle ?? theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      subtitle!,
                      style: subtitleStyle ?? theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? AppTheme.darkTextSecondary : AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Action button or custom action
            if (customAction != null) ...[
              const SizedBox(width: AppTheme.spacing16),
              customAction!,
            ] else if (actionText != null || actionIcon != null) ...[
              const SizedBox(width: AppTheme.spacing16),
              _buildActionButton(context, isDark),
            ],
          ],
        ),

        // Divider
        if (showDivider) ...[
          const SizedBox(height: AppTheme.spacing16),
          Divider(
            color: isDark ? AppTheme.gray700 : AppTheme.dividerColor,
            height: 1,
          ),
        ],
      ],
    );

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing24,
        vertical: AppTheme.spacing16,
      ),
      child: headerContent,
    );
  }

  Widget _buildActionButton(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    
    if (actionIcon != null && actionText != null) {
      // Icon + Text button
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusSM),
        child: InkWell(
          onTap: onActionPressed,
          borderRadius: BorderRadius.circular(AppTheme.radiusSM),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing12,
              vertical: AppTheme.spacing8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionText!,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing4),
                Icon(
                  actionIcon,
                  size: 16,
                  color: AppTheme.primaryColor,
                ),
              ],
            ),
          ),
        ),
      );
    } else if (actionIcon != null) {
      // Icon only button
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        child: InkWell(
          onTap: onActionPressed,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing8),
            child: Icon(
              actionIcon,
              size: 20,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      );
    } else if (actionText != null) {
      // Text only button
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusSM),
        child: InkWell(
          onTap: onActionPressed,
          borderRadius: BorderRadius.circular(AppTheme.radiusSM),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing12,
              vertical: AppTheme.spacing8,
            ),
            child: Text(
              actionText!,
              style: theme.textTheme.labelLarge?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

// Specialized section header variants
class PageHeader extends SectionHeader {
  const PageHeader({
    super.key,
    required super.title,
    super.subtitle,
    super.actionText,
    super.onActionPressed,
    super.actionIcon,
    super.customAction,
  }) : super(
    padding: const EdgeInsets.fromLTRB(
      AppTheme.spacing24,
      AppTheme.spacing32,
      AppTheme.spacing24,
      AppTheme.spacing24,
    ),
    showDivider: true,
    titleStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
  );
}

class CompactSectionHeader extends SectionHeader {
  const CompactSectionHeader({
    super.key,
    required super.title,
    super.subtitle,
    super.actionText,
    super.onActionPressed,
    super.actionIcon,
    super.customAction,
  }) : super(
    padding: const EdgeInsets.symmetric(
      horizontal: AppTheme.spacing20,
      vertical: AppTheme.spacing12,
    ),
    titleStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}

class CardSectionHeader extends SectionHeader {
  const CardSectionHeader({
    super.key,
    required super.title,
    super.subtitle,
    super.actionText,
    super.onActionPressed,
    super.actionIcon,
    super.customAction,
  }) : super(
    padding: const EdgeInsets.all(AppTheme.spacing16),
    showDivider: true,
    titleStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  );
}
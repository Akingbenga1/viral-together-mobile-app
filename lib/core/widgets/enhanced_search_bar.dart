import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class EnhancedSearchBar extends StatefulWidget {
  final String? hintText;
  final String? initialValue;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClearPressed;
  final IconData? prefixIcon;
  final List<Widget>? suffixActions;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool showBorder;
  final bool showShadow;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const EnhancedSearchBar({
    super.key,
    this.hintText = 'Search...',
    this.initialValue,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onClearPressed,
    this.prefixIcon = Icons.search,
    this.suffixActions,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.showBorder = true,
    this.showShadow = false,
    this.focusNode,
    this.controller,
  });

  @override
  State<EnhancedSearchBar> createState() => _EnhancedSearchBarState();
}

class _EnhancedSearchBarState extends State<EnhancedSearchBar> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    
    _hasText = _controller.text.isNotEmpty;
    
    _controller.addListener(_handleTextChange);
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _focusNode.removeListener(_handleFocusChange);
    
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    
    super.dispose();
  }

  void _handleTextChange() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
    widget.onChanged?.call(_controller.text);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleClear() {
    _controller.clear();
    widget.onClearPressed?.call();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Colors based on state and theme
    final bgColor = widget.backgroundColor ?? 
                   (isDark ? AppTheme.darkSurfaceVariant : AppTheme.surfaceColor);
    
    final borderColor = _isFocused 
        ? AppTheme.primaryColor
        : (widget.borderColor ?? 
           (isDark ? AppTheme.gray600 : AppTheme.borderColor));

    final iconColor = _isFocused 
        ? AppTheme.primaryColor 
        : (isDark ? AppTheme.darkTextTertiary : AppTheme.textTertiary);

    final radius = widget.borderRadius ?? AppTheme.radiusMD;

    // Build suffix actions
    List<Widget> suffixWidgets = [];
    
    // Clear button
    if (_hasText && widget.enabled) {
      suffixWidgets.add(
        Padding(
          padding: const EdgeInsets.only(right: AppTheme.spacing4),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            child: InkWell(
              onTap: _handleClear,
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacing4),
                child: Icon(
                  Icons.clear,
                  size: 18,
                  color: isDark ? AppTheme.darkTextSecondary : AppTheme.textSecondary,
                ),
              ),
            ),
          ),
        ),
      );
    }
    
    // Custom suffix actions
    if (widget.suffixActions != null) {
      if (suffixWidgets.isNotEmpty) {
        suffixWidgets.add(const SizedBox(width: AppTheme.spacing4));
      }
      suffixWidgets.addAll(widget.suffixActions!);
    }

    // Main search bar
    Widget searchField = Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
        border: widget.showBorder ? Border.all(
          color: borderColor,
          width: _isFocused ? 2 : 1,
        ) : null,
        boxShadow: widget.showShadow ? [
          BoxShadow(
            color: isDark ? AppTheme.shadowMedium : AppTheme.shadowLight,
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ] : null,
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        onTap: widget.onTap,
        onSubmitted: widget.onSubmitted,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? AppTheme.darkTextTertiary : AppTheme.textTertiary,
          ),
          prefixIcon: widget.prefixIcon != null ? Icon(
            widget.prefixIcon,
            color: iconColor,
            size: 20,
          ) : null,
          suffixIcon: suffixWidgets.isNotEmpty ? Row(
            mainAxisSize: MainAxisSize.min,
            children: suffixWidgets,
          ) : null,
          contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing16,
            vertical: AppTheme.spacing14,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );

    return searchField;
  }
}

// Specialized search bar variants
class CompactSearchBar extends EnhancedSearchBar {
  const CompactSearchBar({
    super.key,
    super.hintText,
    super.onTap,
    super.onChanged,
    super.onSubmitted,
    super.enabled = true,
    super.readOnly = false,
    super.prefixIcon = Icons.search,
    super.controller,
  }) : super(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppTheme.spacing12,
      vertical: AppTheme.spacing8,
    ),
    borderRadius: AppTheme.radiusSM,
  );
}

class HeroSearchBar extends EnhancedSearchBar {
  const HeroSearchBar({
    super.key,
    super.hintText = 'What are you looking for?',
    super.onTap,
    super.onChanged,
    super.onSubmitted,
    super.enabled = true,
    super.readOnly = false,
    super.prefixIcon = Icons.search,
    super.suffixActions,
    super.controller,
  }) : super(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppTheme.spacing20,
      vertical: AppTheme.spacing16,
    ),
    borderRadius: AppTheme.radiusLG,
    showShadow: true,
  );
}
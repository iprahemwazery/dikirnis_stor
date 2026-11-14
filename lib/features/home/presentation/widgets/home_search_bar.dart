import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_shadows.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({
    super.key,
    required this.onSubmitted,
    this.onChanged,
    this.hintText,
    this.autofocus = false,
  });

  final ValueChanged<String> onSubmitted;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final bool autofocus;

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_handleTextChanged)
      ..dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    widget.onChanged?.call(_controller.text);
    setState(() {});
  }

  void _submit() {
    final query = _controller.text.trim();
    if (query.isEmpty) {
      return;
    }
    _focusNode.unfocus();
    widget.onSubmitted(query);
  }

  void _clear() {
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? AppColors.darkBorder
              : AppColors.homeBorder,
        ),
        boxShadow: AppShadows.card,
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: widget.autofocus,
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => _submit(),
        style: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText ?? context.l10n.homeSearchHint,
          hintStyle: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: colorScheme.primary,
            size: 24,
          ),
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  tooltip: MaterialLocalizations.of(
                    context,
                  ).deleteButtonTooltip,
                  onPressed: _clear,
                  icon: const Icon(Icons.close_rounded, size: 19),
                ),
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
        ),
      ),
    );
  }
}

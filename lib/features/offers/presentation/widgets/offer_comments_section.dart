import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/offer_comment.dart';

class OfferCommentsSection extends StatefulWidget {
  const OfferCommentsSection({
    super.key,
    required this.comments,
    required this.headingColor,
  });

  final List<OfferComment> comments;
  final Color headingColor;

  @override
  State<OfferCommentsSection> createState() => _OfferCommentsSectionState();
}

class _OfferCommentsSectionState extends State<OfferCommentsSection> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    FocusScope.of(context).unfocus();
    _showMessage(context.l10n.offerCommentUnavailable);
  }

  void _showMessage(String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final comments = [...widget.comments]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.offerCommentsTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: widget.headingColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (comments.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                ),
                child: Text(
                  '${comments.length}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        if (comments.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.35,
              ),
              borderRadius: BorderRadius.circular(AppRadii.lg),
            ),
            child: Text(
              context.l10n.offerCommentsEmpty,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          )
        else
          for (var index = 0; index < comments.length; index++) ...[
            _CommentTile(comment: comments[index]),
            if (index < comments.length - 1)
              const SizedBox(height: AppSpacing.xs),
          ],
        const SizedBox(height: AppSpacing.sm),
        Form(
          key: _formKey,
          child: TextFormField(
            key: const ValueKey('offer_comment_field'),
            controller: _controller,
            minLines: 1,
            maxLines: 3,
            maxLength: 280,
            textInputAction: TextInputAction.newline,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return context.l10n.offerCommentEmptyError;
              }
              return null;
            },
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: context.l10n.offerCommentHint,
              counterText: '',
              filled: true,
              fillColor: colorScheme.surface,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.xs,
                AppSpacing.sm,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.lg),
                borderSide: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.lg),
                borderSide: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(end: 5),
                child: IconButton.filled(
                  key: const ValueKey('offer_comment_send'),
                  tooltip: context.l10n.offerCommentSend,
                  onPressed: _submit,
                  icon: const Icon(Icons.send_rounded, size: 18),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          context.l10n.offerCommentUnavailable,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment});

  final OfferComment comment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final initial = comment.authorName.trim().isEmpty
        ? '?'
        : comment.authorName.trim().substring(0, 1);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
            child: Text(
              initial,
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        comment.authorName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      MaterialLocalizations.of(
                        context,
                      ).formatMediumDate(comment.createdAt),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                if (comment.rating != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < comment.rating!
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        size: 13,
                        color: AppColors.rating,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  comment.body,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

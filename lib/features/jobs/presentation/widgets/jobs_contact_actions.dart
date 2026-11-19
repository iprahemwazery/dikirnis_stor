import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_spacing.dart';

class JobsContactActions extends StatelessWidget {
  const JobsContactActions({super.key, this.phone, this.whatsApp, this.email});

  final String? phone;
  final String? whatsApp;
  final String? email;

  bool get _hasPhone => phone != null && phone!.trim().isNotEmpty;

  bool get _hasWhatsApp => whatsApp != null && whatsApp!.trim().isNotEmpty;

  bool get _hasEmail => email != null && email!.trim().isNotEmpty;

  bool get hasContact => _hasPhone || _hasWhatsApp || _hasEmail;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (!hasContact) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              size: 18,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                l10n.jobsContactUnavailable,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            if (_hasPhone)
              FilledButton.icon(
                key: const ValueKey('job_contact_call'),
                onPressed: () => _copy(context, phone!),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 44),
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                ),
                icon: const Icon(Icons.call_outlined, size: 18),
                label: Text(l10n.jobsContactCall),
              ),
            if (_hasWhatsApp)
              OutlinedButton.icon(
                key: const ValueKey('job_contact_whatsapp'),
                onPressed: () => _copy(context, whatsApp!),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 44),
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                ),
                icon: const Icon(Icons.chat_outlined, size: 18),
                label: Text(l10n.jobsContactWhatsapp),
              ),
            if (_hasEmail)
              OutlinedButton.icon(
                key: const ValueKey('job_contact_email'),
                onPressed: () => _copy(context, email!),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 44),
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                ),
                icon: const Icon(Icons.email_outlined, size: 18),
                label: Text(l10n.jobsContactEmail),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.jobsContactCopyNote,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Future<void> _copy(BuildContext context, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) {
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(context.l10n.jobsContactCopied)));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/category_visuals.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/cubit/home_state.dart';
import '../widgets/business_category_chip.dart';

class BusinessCreatePage extends StatefulWidget {
  const BusinessCreatePage({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<BusinessCreatePage> createState() => _BusinessCreatePageState();
}

class _BusinessCreatePageState extends State<BusinessCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();

  late String _categoryId = widget.categoryId;
  bool _allowPop = false;
  bool _dialogVisible = false;

  bool get _hasChanges => [
    _nameController,
    _locationController,
    _descriptionController,
    _phoneController,
  ].any((controller) => controller.text.trim().isNotEmpty);

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PopScope(
      canPop: _allowPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handlePop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            l10n.businessesAddTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        body: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  previous.categories != current.categories,
              builder: (context, state) {
                final categories = state.categories
                    .where((category) => !category.isMore)
                    .where((category) => category.id != 'jobs')
                    .toList(growable: false);

                return SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.xxl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _InfoBanner(message: l10n.businessesFormIntro),
                      const SizedBox(height: AppSpacing.lg),
                      AppTextField(
                        key: const ValueKey('businesses_form_name'),
                        controller: _nameController,
                        labelText: l10n.businessesFormName,
                        textInputAction: TextInputAction.next,
                        validator: (value) => _required(value, l10n),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        l10n.businessesFormCategory,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      if (categories.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSpacing.sm,
                          ),
                          child: LinearProgressIndicator(),
                        )
                      else
                        Wrap(
                          key: const ValueKey('businesses_form_category'),
                          spacing: AppSpacing.xs,
                          runSpacing: AppSpacing.xs,
                          children: [
                            for (final category in categories)
                              Builder(
                                builder: (context) {
                                  final visual = categoryVisualFor(
                                    category.iconKey,
                                  );
                                  return BusinessCategoryChip(
                                    label: category.name,
                                    icon: visual.icon,
                                    accentColor: visual.foreground,
                                    selected: _categoryId == category.id,
                                    onTap: () => setState(
                                      () => _categoryId = category.id,
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      const SizedBox(height: AppSpacing.sm),
                      AppTextField(
                        key: const ValueKey('businesses_form_location'),
                        controller: _locationController,
                        labelText: l10n.businessesFormLocation,
                        textInputAction: TextInputAction.next,
                        validator: (value) => _required(value, l10n),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      AppTextField(
                        key: const ValueKey('businesses_form_phone'),
                        controller: _phoneController,
                        labelText: l10n.businessesFormPhone,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      AppTextField(
                        key: const ValueKey('businesses_form_description'),
                        controller: _descriptionController,
                        labelText: l10n.businessesFormDescription,
                        maxLines: 5,
                        validator: (value) => _required(value, l10n),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppButton(
                        key: const ValueKey('businesses_form_submit'),
                        label: l10n.businessesFormSubmit,
                        icon: Icons.send_rounded,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String? _required(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.businessesFormRequired;
    }
    return null;
  }

  Future<void> _submit() async {
    if (_dialogVisible || !_formKey.currentState!.validate()) {
      return;
    }

    _dialogVisible = true;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(dialogContext.l10n.businessesCreateUnavailableTitle),
          content: Text(dialogContext.l10n.businessesCreateUnavailableMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(dialogContext.l10n.ok),
            ),
          ],
        );
      },
    );
    _dialogVisible = false;
  }

  Future<void> _handlePop() async {
    if (!_hasChanges) {
      _popNow();
      return;
    }

    final l10n = context.l10n;
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.businessesFormDiscardTitle),
          content: Text(l10n.businessesFormDiscardMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.businessesFormContinue),
            ),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.businessesFormDiscardConfirm),
            ),
          ],
        );
      },
    );

    if (shouldLeave == true && mounted) {
      _popNow();
    }
  }

  void _popNow() {
    setState(() => _allowPop = true);
    Navigator.of(context).pop();
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: isDark ? AppColors.adBlueDark : AppColors.adBlue,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.adBlueBorderDark : AppColors.adBlueBorder,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 20,
            color: colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../categories/domain/entities/service_category.dart';
import '../../domain/entities/job_enums.dart';
import '../cubit/jobs_cubit.dart';
import '../cubit/jobs_state.dart';
import '../jobs_localizations.dart';

class JobCreatePage extends StatefulWidget {
  const JobCreatePage({super.key, required this.tab});

  final JobsTab tab;

  @override
  State<JobCreatePage> createState() => _JobCreatePageState();
}

class _JobCreatePageState extends State<JobCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _responsibilitiesController = TextEditingController();
  final _requirementsController = TextEditingController();
  final _salaryMinController = TextEditingController();
  final _salaryMaxController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _applicationController = TextEditingController();

  final _nameController = TextEditingController();
  final _professionalTitleController = TextEditingController();
  final _summaryController = TextEditingController();
  final _skillsController = TextEditingController();
  final _experienceYearsController = TextEditingController();
  final _preferredLocationController = TextEditingController();
  final _educationController = TextEditingController();

  String? _categoryId;
  EmploymentType _employmentType = EmploymentType.fullTime;
  EmploymentType _desiredEmploymentType = EmploymentType.fullTime;
  bool _allowPop = false;
  bool _dialogVisible = false;

  bool get _isVacancy => widget.tab == JobsTab.vacancies;

  List<TextEditingController> get _controllers => [
    _titleController,
    _companyController,
    _descriptionController,
    _responsibilitiesController,
    _requirementsController,
    _salaryMinController,
    _salaryMaxController,
    _locationController,
    _phoneController,
    _emailController,
    _applicationController,
    _nameController,
    _professionalTitleController,
    _summaryController,
    _skillsController,
    _experienceYearsController,
    _preferredLocationController,
    _educationController,
  ];

  bool get _hasChanges {
    return _controllers.any(
          (controller) => controller.text.trim().isNotEmpty,
        ) ||
        _categoryId != null ||
        _employmentType != EmploymentType.fullTime ||
        _desiredEmploymentType != EmploymentType.fullTime;
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
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
            _isVacancy
                ? l10n.jobsCreateVacancyTitle
                : l10n.jobsCreateCandidateTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        body: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: BlocBuilder<JobsCubit, JobsState>(
              builder: (context, state) {
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
                      _InfoBanner(
                        message: _isVacancy
                            ? l10n.jobsCreateVacancySubtitle
                            : l10n.jobsCreateCandidateSubtitle,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      if (_isVacancy)
                        ..._vacancyFields(context, state)
                      else
                        ..._candidateFields(context, state),
                      const SizedBox(height: AppSpacing.md),
                      AppButton(
                        key: const ValueKey('jobs_form_submit'),
                        label: l10n.jobsFormSubmit,
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

  List<Widget> _vacancyFields(BuildContext context, JobsState state) {
    final l10n = context.l10n;

    return [
      AppTextField(
        key: const ValueKey('jobs_form_title'),
        controller: _titleController,
        labelText: l10n.jobsFormTitleLabel,
        textInputAction: TextInputAction.next,
        validator: (value) => _required(value, l10n),
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        key: const ValueKey('jobs_form_company'),
        controller: _companyController,
        labelText: l10n.jobsFormCompanyLabel,
        textInputAction: TextInputAction.next,
        validator: (value) => _required(value, l10n),
      ),
      const SizedBox(height: AppSpacing.sm),
      _CategoryDropdown(
        categories: state.categories,
        selectedCategoryId: _categoryId,
        onChanged: (value) => setState(() => _categoryId = value),
      ),
      const SizedBox(height: AppSpacing.sm),
      _EmploymentTypeDropdown(
        label: l10n.jobsFormEmploymentTypeLabel,
        value: _employmentType,
        onChanged: (value) => setState(() => _employmentType = value),
      ),
      const SizedBox(height: AppSpacing.sm),
      Row(
        children: [
          Expanded(
            child: AppTextField(
              controller: _salaryMinController,
              labelText: l10n.jobsFormSalaryMinLabel,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) => _optionalNumber(value, l10n),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: AppTextField(
              controller: _salaryMaxController,
              labelText: l10n.jobsFormSalaryMaxLabel,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) => _optionalNumber(value, l10n),
            ),
          ),
        ],
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        key: const ValueKey('jobs_form_location'),
        controller: _locationController,
        labelText: l10n.jobsFormLocationLabel,
        textInputAction: TextInputAction.next,
        validator: (value) => _required(value, l10n),
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        key: const ValueKey('jobs_form_description'),
        controller: _descriptionController,
        labelText: l10n.jobsFormDescriptionLabel,
        maxLines: 5,
        validator: (value) => _required(value, l10n),
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        controller: _responsibilitiesController,
        labelText: l10n.jobsFormResponsibilitiesLabel,
        maxLines: 4,
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        controller: _requirementsController,
        labelText: l10n.jobsFormRequirementsLabel,
        maxLines: 4,
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        controller: _phoneController,
        labelText: l10n.jobsFormPhoneLabel,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        controller: _emailController,
        labelText: l10n.jobsFormEmailLabel,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (value) => _optionalEmail(value, l10n),
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        controller: _applicationController,
        labelText: l10n.jobsFormApplicationLabel,
        maxLines: 3,
      ),
    ];
  }

  List<Widget> _candidateFields(BuildContext context, JobsState state) {
    final l10n = context.l10n;

    return [
      AppTextField(
        key: const ValueKey('jobs_form_name'),
        controller: _nameController,
        labelText: l10n.jobsFormNameLabel,
        textInputAction: TextInputAction.next,
        validator: (value) => _required(value, l10n),
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        key: const ValueKey('jobs_form_professional_title'),
        controller: _professionalTitleController,
        labelText: l10n.jobsFormProfessionalTitleLabel,
        textInputAction: TextInputAction.next,
        validator: (value) => _required(value, l10n),
      ),
      const SizedBox(height: AppSpacing.sm),
      _CategoryDropdown(
        categories: state.categories,
        selectedCategoryId: _categoryId,
        onChanged: (value) => setState(() => _categoryId = value),
      ),
      const SizedBox(height: AppSpacing.sm),
      _EmploymentTypeDropdown(
        label: l10n.jobsFormDesiredTypeLabel,
        value: _desiredEmploymentType,
        onChanged: (value) => setState(() => _desiredEmploymentType = value),
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        key: const ValueKey('jobs_form_experience_years'),
        controller: _experienceYearsController,
        labelText: l10n.jobsFormExperienceYearsLabel,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        validator: (value) => _requiredNumber(value, l10n),
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        key: const ValueKey('jobs_form_preferred_location'),
        controller: _preferredLocationController,
        labelText: l10n.jobsFormPreferredLocationLabel,
        textInputAction: TextInputAction.next,
        validator: (value) => _required(value, l10n),
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        key: const ValueKey('jobs_form_summary'),
        controller: _summaryController,
        labelText: l10n.jobsFormSummaryLabel,
        maxLines: 4,
        validator: (value) => _required(value, l10n),
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        key: const ValueKey('jobs_form_skills'),
        controller: _skillsController,
        labelText: l10n.jobsFormSkillsLabel,
        validator: (value) => _required(value, l10n),
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        controller: _educationController,
        labelText: l10n.jobsFormEducationLabel,
        maxLines: 3,
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        controller: _phoneController,
        labelText: l10n.jobsFormPhoneLabel,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
      ),
      const SizedBox(height: AppSpacing.sm),
      AppTextField(
        controller: _emailController,
        labelText: l10n.jobsFormEmailLabel,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (value) => _optionalEmail(value, l10n),
      ),
      const SizedBox(height: AppSpacing.sm),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.attach_file_rounded,
              size: 18,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                l10n.jobsFormCvUnavailable,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  String? _required(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.jobsFormRequired;
    }
    return null;
  }

  String? _optionalNumber(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return double.tryParse(value.trim()) == null
        ? l10n.jobsFormNumberInvalid
        : null;
  }

  String? _requiredNumber(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.jobsFormRequired;
    }
    final parsed = int.tryParse(value.trim());
    if (parsed == null || parsed < 0) {
      return l10n.jobsFormNumberInvalid;
    }
    return null;
  }

  String? _optionalEmail(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(value.trim()) ? null : l10n.jobsFormEmailInvalid;
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
          title: Text(dialogContext.l10n.jobsCreateUnavailableTitle),
          content: Text(dialogContext.l10n.jobsCreateUnavailableMessage),
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
          title: Text(l10n.jobsFormDiscardTitle),
          content: Text(l10n.jobsFormDiscardMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.jobsFormContinue),
            ),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.jobsFormDiscardConfirm),
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

class _CategoryDropdown extends StatelessWidget {
  const _CategoryDropdown({
    required this.categories,
    required this.selectedCategoryId,
    required this.onChanged,
  });

  final List<ServiceCategory> categories;
  final String? selectedCategoryId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;

    return DropdownButtonFormField<String>(
      key: const ValueKey('jobs_form_category'),
      initialValue: selectedCategoryId,
      isExpanded: true,
      decoration: InputDecoration(labelText: l10n.jobsFormCategoryLabel),
      items: [
        for (final category in categories)
          DropdownMenuItem<String>(
            value: category.id,
            child: Text(category.localizedName(languageCode)),
          ),
      ],
      onChanged: onChanged,
      validator: (value) => value == null ? l10n.jobsFormRequired : null,
    );
  }
}

class _EmploymentTypeDropdown extends StatelessWidget {
  const _EmploymentTypeDropdown({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EmploymentType value;
  final ValueChanged<EmploymentType> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return DropdownButtonFormField<EmploymentType>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        for (final type in EmploymentType.values)
          DropdownMenuItem<EmploymentType>(
            value: type,
            child: Text(type.label(l10n)),
          ),
      ],
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

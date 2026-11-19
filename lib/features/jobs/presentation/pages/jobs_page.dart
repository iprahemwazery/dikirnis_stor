import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../router/app_routes.dart';
import '../../../../theme/app_spacing.dart';
import '../../../home/presentation/widgets/home_search_bar.dart';
import '../../domain/entities/job_candidate.dart';
import '../../domain/entities/job_vacancy.dart';
import '../cubit/jobs_cubit.dart';
import '../cubit/jobs_state.dart';
import '../widgets/job_candidate_card.dart';
import '../widgets/job_vacancy_card.dart';
import '../widgets/jobs_category_chips.dart';
import '../widgets/jobs_filter_sheet.dart';
import '../widgets/jobs_loading_view.dart';
import '../widgets/jobs_tab_selector.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.jobsTitle,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const ValueKey('jobs_fab'),
        onPressed: () {
          final tab = context.read<JobsCubit>().state.tab;
          context.push(AppRoutes.jobCreatePath(tab.name));
        },
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.jobsAddListing),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: BlocBuilder<JobsCubit, JobsState>(
          buildWhen: (previous, current) =>
              previous.tab != current.tab ||
              previous.query != current.query ||
              previous.categories != current.categories ||
              previous.selectedCategoryId != current.selectedCategoryId ||
              previous.selectedEmploymentType !=
                  current.selectedEmploymentType ||
              previous.selectedAvailability != current.selectedAvailability ||
              previous.sort != current.sort ||
              previous.status != current.status ||
              previous.vacancies != current.vacancies ||
              previous.candidates != current.candidates,
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.sm,
                  ),
                  child: JobsTabSelector(
                    selectedTab: state.tab,
                    onSelected: context.read<JobsCubit>().selectTab,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: HomeSearchBar(
                    hintText: state.tab == JobsTab.vacancies
                        ? l10n.jobsSearchVacanciesHint
                        : l10n.jobsSearchCandidatesHint,
                    onChanged: context.read<JobsCubit>().search,
                    onSubmitted: context.read<JobsCubit>().search,
                  ),
                ),
                if (state.categories.isNotEmpty)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: AppSpacing.sm,
                    ),
                    child: JobsCategoryChips(
                      categories: state.categories,
                      selectedCategoryId: state.selectedCategoryId,
                      onSelected: context.read<JobsCubit>().selectCategory,
                    ),
                  ),
                _JobsToolbar(state: state),
                Expanded(
                  child: switch (state.status) {
                    JobsStatus.initial ||
                    JobsStatus.loading => const JobsLoadingView(),
                    JobsStatus.failure => AppErrorState(
                      message: l10n.jobsErrorMessage,
                      retryLabel: l10n.retry,
                      onRetry: () =>
                          context.read<JobsCubit>().load(force: true),
                    ),
                    JobsStatus.empty => AppEmptyState(
                      message: state.tab == JobsTab.vacancies
                          ? l10n.jobsVacanciesEmpty
                          : l10n.jobsCandidatesEmpty,
                      icon: Icons.work_off_outlined,
                    ),
                    JobsStatus.success => _JobsList(state: state),
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _JobsToolbar extends StatelessWidget {
  const _JobsToolbar({required this.state});

  final JobsState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final colorScheme = theme.colorScheme;
    final hasFilters = state.hasActiveFilters || state.sort != JobsSort.newest;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        children: [
          OutlinedButton.icon(
            key: const ValueKey('jobs_filter_button'),
            onPressed: () => _openFilters(context),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(0, 44),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.sm,
              ),
            ),
            icon: Icon(
              hasFilters ? Icons.filter_alt_rounded : Icons.filter_alt_outlined,
              size: 18,
            ),
            label: Text(l10n.jobsFilters),
          ),
          if (hasFilters)
            TextButton(
              key: const ValueKey('jobs_clear_filters'),
              onPressed: context.read<JobsCubit>().clearFilters,
              child: Text(l10n.jobsClearFilters),
            ),
          const Spacer(),
          Text(
            l10n.jobsResultsCount(state.resultCount),
            key: const ValueKey('jobs_results_count'),
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openFilters(BuildContext context) async {
    final cubit = context.read<JobsCubit>();
    final selection = await showJobsFilterSheet(
      context: context,
      tab: state.tab,
      employmentType: state.selectedEmploymentType,
      availability: state.selectedAvailability,
      sort: state.sort,
    );
    if (selection == null) {
      return;
    }
    cubit
      ..selectEmploymentType(selection.employmentType)
      ..selectAvailability(selection.availability)
      ..selectSort(selection.sort);
  }
}

class _JobsList extends StatelessWidget {
  const _JobsList({required this.state});

  final JobsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final isVacancies = state.tab == JobsTab.vacancies;
    final isEmpty = state.isTabEmpty;
    final noMatches = state.isSearching || state.hasActiveFilters;

    return RefreshIndicator(
      onRefresh: context.read<JobsCubit>().refresh,
      color: Theme.of(context).colorScheme.primary,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: AppEmptyState(
                message: noMatches
                    ? l10n.jobsNoSearchResults
                    : (isVacancies
                          ? l10n.jobsVacanciesEmpty
                          : l10n.jobsCandidatesEmpty),
                icon: noMatches
                    ? Icons.search_off_rounded
                    : Icons.work_off_outlined,
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.xs,
                AppSpacing.lg,
                100,
              ),
              sliver: SliverList.builder(
                itemCount: isVacancies
                    ? state.vacancies.length
                    : state.candidates.length,
                itemBuilder: (context, index) {
                  if (isVacancies) {
                    final vacancy = state.vacancies[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: JobVacancyCard(
                        vacancy: vacancy,
                        categoryName: state.categoryName(
                          vacancy.categoryId,
                          languageCode,
                        ),
                        onTap: () => _openVacancy(context, vacancy),
                      ),
                    );
                  }

                  final candidate = state.candidates[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: JobCandidateCard(
                      candidate: candidate,
                      categoryName: state.categoryName(
                        candidate.categoryId,
                        languageCode,
                      ),
                      onTap: () => _openCandidate(context, candidate),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  void _openVacancy(BuildContext context, JobVacancy vacancy) {
    context.push(AppRoutes.jobVacancyDetailsPath(vacancy.id));
  }

  void _openCandidate(BuildContext context, JobCandidate candidate) {
    context.push(AppRoutes.jobCandidateDetailsPath(candidate.id));
  }
}

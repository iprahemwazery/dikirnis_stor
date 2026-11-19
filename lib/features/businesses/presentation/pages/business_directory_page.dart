import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_asset_image.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../router/app_routes.dart';
import '../../../../theme/app_shadows.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/category_visuals.dart';
import '../../../home/domain/entities/business.dart';
import '../../../home/domain/entities/home_content.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/cubit/home_state.dart';
import '../../../home/presentation/widgets/business_badge.dart';
import '../../../home/presentation/widgets/rating_badge.dart';
import '../widgets/business_category_chip.dart';

class BusinessDirectoryPage extends StatefulWidget {
  const BusinessDirectoryPage({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<BusinessDirectoryPage> createState() => _BusinessDirectoryPageState();
}

class _BusinessDirectoryPageState extends State<BusinessDirectoryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String? _categoryId;

  @override
  void initState() {
    super.initState();
    _categoryId = widget.categoryId;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _titleFor(HomeState state, AppLocalizations l10n) {
    final categoryId = _categoryId;
    if (categoryId == null) {
      return l10n.businessesTitle;
    }
    for (final category in state.content?.categories ?? const []) {
      if (category.id == categoryId) {
        return category.name;
      }
    }
    return l10n.businessesTitle;
  }

  void _openCreatePage() {
    context.push(
      AppRoutes.businessCreatePath(_categoryId ?? widget.categoryId),
    );
  }

  List<Business> _businessesFor(HomeContent content) {
    final categoryId = _categoryId;
    if (categoryId != null) {
      return content.businessesOf(categoryId);
    }

    final seenIds = <String>{};
    final businesses = <Business>[];
    for (final category in content.categories) {
      for (final business in content.businessesOf(category.id)) {
        if (seenIds.add(business.id)) {
          businesses.add(business);
        }
      }
    }
    return businesses;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.content != current.content,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              _titleFor(state, l10n),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            actions: [
              IconButton(
                key: const ValueKey('businesses_add_button'),
                tooltip: l10n.businessesAddCta,
                onPressed: _openCreatePage,
                icon: const Icon(Icons.add_business_outlined),
              ),
            ],
          ),
          body: SafeArea(top: false, child: _buildBody(context, state, l10n)),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    HomeState state,
    AppLocalizations l10n,
  ) {
    final content = state.content;
    if (content == null) {
      if (state.status == HomeStatus.failure) {
        return AppErrorState(
          message: l10n.businessesErrorMessage,
          retryLabel: l10n.retry,
          onRetry: () => context.read<HomeCubit>().load(force: true),
        );
      }
      return const Center(child: CircularProgressIndicator());
    }

    final allBusinesses = _businessesFor(content);
    final visibleCategories = content.categories
        .where((category) => !category.isMore && category.id != 'jobs')
        .toList(growable: false);
    final normalizedQuery = _query.trim().toLowerCase();
    final businesses = normalizedQuery.isEmpty
        ? allBusinesses
        : allBusinesses
              .where((business) {
                final haystack = [
                  business.name,
                  business.location,
                  business.description ?? '',
                ].join(' ').toLowerCase();
                return haystack.contains(normalizedQuery);
              })
              .toList(growable: false);

    return RefreshIndicator(
      onRefresh: context.read<HomeCubit>().refresh,
      color: Theme.of(context).colorScheme.primary,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: TextField(
                key: const ValueKey('businesses_search'),
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: l10n.businessesSearchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          tooltip: l10n.cancel,
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  BusinessCategoryChip(
                    key: const ValueKey('businesses_category_all'),
                    label: l10n.businessesAllLabel,
                    icon: Icons.apps_rounded,
                    accentColor: Theme.of(context).colorScheme.primary,
                    selected: _categoryId == null,
                    onTap: () => setState(() => _categoryId = null),
                  ),
                  for (final category in visibleCategories)
                    Builder(
                      builder: (context) {
                        final visual = categoryVisualFor(category.iconKey);
                        return BusinessCategoryChip(
                          key: ValueKey('businesses_category_${category.id}'),
                          label: category.name,
                          icon: visual.icon,
                          accentColor: visual.foreground,
                          selected: _categoryId == category.id,
                          onTap: () =>
                              setState(() => _categoryId = category.id),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          if (allBusinesses.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: AppEmptyState(
                message: l10n.businessesEmpty,
                icon: Icons.storefront_outlined,
              ),
            )
          else if (businesses.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: AppEmptyState(
                message: l10n.businessesNoSearchResults,
                icon: Icons.search_off_rounded,
              ),
            )
          else ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.lg,
                  AppSpacing.xs,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: Text(
                  '${businesses.length} ${l10n.businessesCountLabel}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                96,
              ),
              sliver: SliverList.separated(
                itemCount: businesses.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final business = businesses[index];
                  return _BusinessTile(
                    business: business,
                    onTap: () => context.push(
                      AppRoutes.businessDetailsPath(business.id),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BusinessTile extends StatelessWidget {
  const _BusinessTile({required this.business, required this.onTap});

  final Business business;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final l10n = context.l10n;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: isDark ? const [] : AppShadows.soft,
      ),
      child: Material(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox.square(
                    dimension: 104,
                    child: AppAssetImage(
                      assetPath: business.image,
                      fit: BoxFit.cover,
                      fallbackIcon: Icons.storefront_outlined,
                      semanticLabel: business.name,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        business.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              business.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (business.description != null &&
                          business.description!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          business.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                      ],
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          RatingBadge(rating: business.rating),
                          if (business.views > 0)
                            Text(
                              '${business.views} ${l10n.viewsLabel}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          if (business.isVerified) const VerifiedBadge(),
                          if (business.isSponsored) const SponsoredBadge(),
                          if (business.isNew) const NewBusinessBadge(),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Directionality.of(context) == TextDirection.rtl
                      ? Icons.chevron_left_rounded
                      : Icons.chevron_right_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

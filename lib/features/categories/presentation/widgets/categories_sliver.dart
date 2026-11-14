import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../l10n/l10n.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/service_category.dart';
import '../cubit/categories_cubit.dart';
import '../cubit/categories_state.dart';
import 'category_card.dart';

class CategoriesSliver extends StatelessWidget {
  const CategoriesSliver({super.key, required this.onCategoryTap});

  final ValueChanged<ServiceCategory> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        return switch (state.status) {
          CategoriesStatus.initial ||
          CategoriesStatus.loading => const SliverFillRemaining(
            hasScrollBody: false,
            child: AppLoading(),
          ),
          CategoriesStatus.failure => SliverFillRemaining(
            hasScrollBody: false,
            child: AppErrorState(
              message: context.l10n.categoriesErrorMessage,
              retryLabel: context.l10n.retry,
              onRetry: context.read<CategoriesCubit>().load,
            ),
          ),
          CategoriesStatus.empty => SliverFillRemaining(
            hasScrollBody: false,
            child: AppEmptyState(
              message: context.l10n.emptyCategoriesMessage,
              icon: Icons.category_outlined,
            ),
          ),
          CategoriesStatus.success =>
            state.categories.isEmpty
                ? SliverFillRemaining(
                    hasScrollBody: false,
                    child: AppEmptyState(
                      message: context.l10n.noSearchResults,
                      icon: Icons.search_off_rounded,
                    ),
                  )
                : SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.crossAxisExtent >= 720
                          ? 3
                          : 2;
                      final textScale = MediaQuery.textScalerOf(
                        context,
                      ).scale(1);
                      final itemExtent = (112 + (textScale - 1) * 30).clamp(
                        112.0,
                        180.0,
                      );

                      return SliverPadding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          AppSpacing.lg,
                          0,
                          AppSpacing.lg,
                          0,
                        ),
                        sliver: SliverGrid.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: AppSpacing.sm,
                                crossAxisSpacing: AppSpacing.sm,
                                mainAxisExtent: itemExtent,
                              ),
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            final category = state.categories[index];
                            return CategoryCard(
                              key: ValueKey(category.id),
                              category: category,
                              onTap: () => onCategoryTap(category),
                            );
                          },
                        ),
                      );
                    },
                  ),
        };
      },
    );
  }
}

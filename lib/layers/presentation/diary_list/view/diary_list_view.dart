import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import '../../../domain/diary/diary.dart';
import '../../diary_details/view/diary_details_page.dart';
import '../../shared/main_button.dart';
import '../controller/diary_list_controller.dart';
import '../view_model/tag.dart';
import '../../../application/common/app_color.dart';
import '../../../application/common/app_text.dart';
import '../../shared/loading_indicator.dart';
import '../../shared/segmented_control.dart';
import 'diary_list_cell.dart';
import 'empty_view.dart';
import 'period_button.dart';

class DiaryListView extends StatefulWidget with GetItStatefulWidgetMixin {
  DiaryListView({super.key});

  @override
  State<DiaryListView> createState() => _DiaryListViewState();
}

class _DiaryListViewState extends State<DiaryListView> with GetItStateMixin {
  final _scrollController = ScrollController();

  // MARK: - Properties

  late Tag _currentTag;
  late DateTime _endDate;
  late DateTime _startDate;

  // MARK: - Life Cycle Methods

  @override
  void initState() {
    super.initState();
    _currentTag = Tag.concert;
    _endDate = DateTime.now();
    _startDate = DateTime(_endDate.year, _endDate.month, 1);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      get<DiaryListController>().fetchList();
    });
    _scrollController.addListener(_onScrolled);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScrolled)
      ..dispose();
    super.dispose();
  }

  // MARK: - Handler Methods

  void _onPeriodChanged(DateTime startDate, DateTime endDate) {
    setState(() {
      _startDate = startDate;
      _endDate = endDate;
    });
  }

  void _onScrolled() {
    if (_isBottom) {
      get<DiaryListController>().fetchList();
    }
  }

  void _onTagChanged(Tag tag) {
    setState(() {
      _currentTag = tag;
    });
  }

  // MARK: - Nav Flow Methods

  void _onPressed() {
    final route = DiaryDetailsPage.route();
    Navigator.of(context).push(route);
  }

  void _onListItemTapped(Diary item) {
    final route = DiaryDetailsPage.route(diary: item);
    Navigator.of(context).push(route);
  }

  // MARK: - Support Methods

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  bool hasTag(List<String>? tags) =>
      tags?.contains(_currentTag.toCustomString()) ?? false;

  bool isDateInRange(DateTime? date) =>
      date != null &&
      date.isAfter(_startDate) &&
      date.isBefore(_endDate.add(const Duration(days: 1)));

  // MARK: - Widget Build Method

  @override
  Widget build(BuildContext context) {
    const addButtonBottomOffset = 20.0;

    final status = watchX((DiaryListController state) => state.status);
    final list = watchX((DiaryListController s) => s.diaries)
        .where((e) => hasTag(e.tags) && isDateInRange(e.createdAt))
        .toList();
    final hasEnded = watchX((DiaryListController s) => s.isLastPage);
    print('status: $status, list: $list, hasEnded: $hasEnded');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Gap.expand(24),
          PeriodButton(periodChanged: _onPeriodChanged),
          const Gap.expand(24),
          SegmentedControl(
            values: Tag.values,
            onValueChanged: _onTagChanged,
            selectedColor: AppColor.selectedColor,
            unSelectedColor: AppColor.unSelectedColor,
            selectedBackgroundColor: AppColor.selectedBackgroundColor,
            unSelectedBackgroundColor: AppColor.unSelectedBackgroundColor,
          ),
          const Gap.expand(24),
          Expanded(
            child: (status == ListPageStatus.initial)
                ? const LoadingIndicator()
                : ((list.isEmpty)
                    ? const EmptyView()
                    : ListView.builder(
                        key: const ValueKey('diary_page_list_key'),
                        controller: _scrollController,
                        itemCount: hasEnded ? list.length : list.length + 1,
                        itemBuilder: (context, index) {
                          print(
                              '-- index: $index, list.length: ${list.length}');

                          if (index >= list.length) {
                            return !hasEnded
                                ? const LoadingIndicator()
                                : const SizedBox();
                          }
                          return DiaryListCell(
                            item: list[index],
                            onListItemTap: _onListItemTapped,
                          );
                        },
                      )),
          ),
          const Gap.expand(24),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: addButtonBottomOffset),
              child: MainButton(
                title: DiaryListText.addNew,
                onPressed: _onPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

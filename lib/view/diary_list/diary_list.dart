import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../application/common/app_color.dart';
import '../../application/common/app_text.dart';
import '../../controller/diary_list_controller.dart';
import '../../model/tag.dart';
import '../shared/empty_view.dart';
import '../shared/loading_indicator.dart';
import '../shared/main_button.dart';
import '../shared/period_button.dart';
import '../shared/segmented_control.dart';
import 'diary_list_cell.dart';

class DiaryList extends GetView<DiaryListController> {
  const DiaryList({super.key});

  @override
  Widget build(BuildContext context) {
    const addButtonBottomOffset = 20.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          DiaryListText.navTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Gap(24),
              PeriodButton(periodChanged: controller.updatePeriod),
              const Gap(24),
              SegmentedControl(
                values: Tag.values,
                onValueChanged: controller.updateTags,
                selectedColor: AppColor.selectedColor,
                unSelectedColor: AppColor.unSelectedColor,
                selectedBackgroundColor: AppColor.selectedBackgroundColor,
                unSelectedBackgroundColor: AppColor.unSelectedBackgroundColor,
              ),
              const Gap(24),
              Expanded(
                child: Obx(
                  () => (controller.status.value == ListPageStatus.initial)
                      ? const LoadingIndicator()
                      : ((controller.diaries.isEmpty)
                          ? const EmptyView()
                          : ListView.builder(
                              itemCount: controller.diaries.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: DiaryListCell(
                                    item: controller.diaries[index],
                                    onListItemTap: controller.updateDiary,
                                  ),
                                );
                              },
                            )),
                ),
              ),
              const Gap(24),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: addButtonBottomOffset,
                ),
                child: MainButton(
                  title: DiaryListText.addNew,
                  onPressed: controller.addNewDiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

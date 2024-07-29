import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../application/common/app_color.dart';
import '../../application/common/app_text.dart';
import '../../controller/diary_details_controller.dart';
import '../../model/weather.dart';
import '../shared/section_label.dart';
import '../shared/date_label.dart';
import '../shared/main_button.dart';
import '../shared/segmented_control.dart';
import '../shared/sparkle_text_field.dart';

final class DiaryDetails extends GetView<DiaryDetailsController> {
  const DiaryDetails({super.key});

  static route() => MaterialPageRoute(
        builder: (context) {
          return const DiaryDetails();
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppText.diaryDetails,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: DateLabel(date: controller.diary.createdAt),
              ),
              const Gap(8.0),
              SparkleTextField(
                initialValue: controller.diary.title,
                labelText: AppText.title,
                placeholder: AppText.titleHint,
                onTextChanged: controller.updateTitle,
                autovalidateMode: AutovalidateMode.always,
                validator: (String? value) {
                  return controller.validateText(
                    value: value,
                    message: '제목을 채워주세요',
                  );
                },
              ),
              const Gap(16),
              SparkleTextField(
                initialValue: controller.diary.content,
                labelText: AppText.content,
                placeholder: AppText.contentHint,
                minLines: 10,
                maxLines: 10,
                onTextChanged: controller.updateContent,
              ),
              const Gap(16),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: SectionLabel(title: AppText.weather),
              ),
              SegmentedControl(
                values: Weather.values,
                onValueChanged: controller.updateWeather,
                selectedColor: AppColor.selectedColor,
                unSelectedColor: AppColor.unSelectedColor,
                selectedBackgroundColor: AppColor.selectedBackgroundColor,
                unSelectedBackgroundColor: AppColor.unSelectedBackgroundColor,
              ),
              const Gap(8.0),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: SectionLabel(title: AppText.tag),
              ),
              const Gap(8.0),
              SparkleTextField(
                placeholder: AppText.tagHint,
                autoTag: true,
                tags: (controller.kind == DetailsPageKind.add)
                    ? [AppText.tagExample]
                    : controller.diary.tags,
                onTagsChanged: controller.updateTags,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: MainButton(
                  title: AppText.saveDiary,
                  onPressed: () {
                    controller.saveDiary(context: context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

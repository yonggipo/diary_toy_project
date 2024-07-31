import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../application/common/app_color.dart';
import '../../application/common/app_text.dart';
import '../../controller/diary_details_controller.dart';
import '../../model/weather.dart';
import '../shared/section_label.dart';
import '../shared/date_label.dart';
import '../shared/main_button.dart';
import '../shared/segmented_control.dart';
import '../shared/sparkle_text_field.dart';
import 'location_list_view.dart';

final class DiaryDetails extends GetView<DiaryDetailsController> {
  const DiaryDetails({super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                const SectionLabel(title: AppText.weather),
                SegmentedControl(
                  values: Weather.values,
                  onValueChanged: controller.updateWeather,
                  selectedColor: AppColor.selectedColor,
                  unSelectedColor: AppColor.unSelectedColor,
                  selectedBackgroundColor: AppColor.selectedBackgroundColor,
                  unSelectedBackgroundColor: AppColor.unSelectedBackgroundColor,
                ),
                const Gap(8.0),
                const SectionLabel(title: AppText.tag),
                const Gap(8.0),
                SparkleTextField(
                  placeholder: AppText.tagHint,
                  autoTag: true,
                  tags: (controller.kind == DetailsPageKind.add)
                      ? [AppText.tagExample]
                      : controller.diary.tags,
                  onTagsChanged: controller.updateTags,
                ),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionLabel(title: AppText.place),
                    const Gap(12),
                    AspectRatio(
                      aspectRatio: 3 / 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Obx(() {
                          debugPrint(
                              '(obx) center: ${controller.center.value.toString()}');
                          return GoogleMap(
                            onMapCreated: controller.onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: controller.center.value,
                              zoom: controller.zoomLevel.value,
                            ),
                            markers: controller.markers,
                          );
                        }),
                      ),
                    ),
                    const Gap(12),
                    LocationListView(),
                  ],
                ),
                const Gap(16),
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
      ),
    );
  }

  Widget locationSection({required BuildContext context}) {
    const double spacing = 12;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(title: AppText.place),
        const Gap(spacing),
        AspectRatio(
          aspectRatio: 3 / 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Obx(() {
              debugPrint('(obx) center: ${controller.center.value.toString()}');
              return GoogleMap(
                onMapCreated: controller.onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: controller.center.value,
                  zoom: controller.zoomLevel.value,
                ),
              );
            }),
          ),
        ),
        const Gap(spacing),
        LocationListView(),
      ],
    );
  }
}

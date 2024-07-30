import 'package:diary_toy_project/application/common/app_color.dart';
import 'package:diary_toy_project/application/common/app_text.dart';
import 'package:diary_toy_project/controller/diary_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

final class LocationListView extends StatelessWidget {
  LocationListView({super.key});

  final DiaryDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final locations = controller.diary.locationList;
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: (locations?.length ?? 0) + 1,
          itemBuilder: (context, index) {
            var some = (index == 0)
                ? const Text(
                    AppText.addAddress,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        locations?[(index - 1)].placeName ?? "",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const Gap(8.0),
                      Text(
                        locations?[(index - 1)].placeName ?? "",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      )
                    ],
                  );

            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  controller.searchAddress(context: context);
                } else {
                  controller.deleteLocation();
                }
              },
              child: Container(
                width: 120,
                height: 52,
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: AppColor.border,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/map_pin_area.svg'),
                    const Gap(12),
                    some,
                  ],
                ),
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/location.dart';
import '../../application/common/app_color.dart';
import '../../application/common/app_text.dart';
import '../../controller/diary_details_controller.dart';

final class LocationListView extends StatelessWidget {
  LocationListView({super.key});

  final DiaryDetailsController controller = Get.find();

  Widget createContent(int index, List<Location> locations) {
    Widget content;
    if (index == 0) {
      content = const Text(
        AppText.addAddress,
        style: TextStyle(
          fontFamily: AppText.font,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      );
    } else {
      final item = locations[(index - 1)];
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.placeName,
            style: const TextStyle(
              fontFamily: AppText.font,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(4.0),
          Text(
            item.address,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      );
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 88,
      child: Obx(() {
        final locations = controller.locations.toList();
        final selectedIndex = controller.selectedIndex.value;
        return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: (locations.length) + 1,
            separatorBuilder: (context, index) => const Gap(8.0),
            itemBuilder: (context, index) {
              print('item index: $index');
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    controller.searchAddress(
                        context: context, nextIndex: (locations.length) + 1);
                  } else {
                    controller.moveTo(locations[index - 1], index);
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      width: 132,
                      height: 88,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 10,
                      ),
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
                          SvgPicture.asset(
                            'assets/icons/map_pin_area.svg',
                            colorFilter: ColorFilter.mode(
                              (index != 0)
                                  ? Colors.black.withOpacity(
                                      (selectedIndex == index) ? 1.0 : 0.3)
                                  : Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          const Gap(12),
                          (index == 0)
                              ? createContent(index, locations)
                              : Expanded(
                                  child: createContent(index, locations),
                                ),
                        ],
                      ),
                    ),
                    if (index != 0)
                      Positioned(
                        left: 8.0,
                        top: 8.0,
                        child: GestureDetector(
                          onTap: () {
                            controller.deleteLocation(index: index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$index location delete'),
                              ),
                            );
                          },
                          child: SvgPicture.asset('assets/icons/x_circle.svg'),
                        ),
                      ),
                  ],
                ),
              );
            });
      }),
    );
  }
}

import 'package:get/get.dart';

import '../model/diary.dart';
import '../controller/diary_details_controller.dart';

final class DiaryDetailsBinding implements Bindings {
  DiaryDetailsBinding({Diary? diary})
      : _diary = diary ?? Diary(),
        _kind = (diary == null) ? DetailsPageKind.add : DetailsPageKind.update;
  final Diary _diary;
  final DetailsPageKind _kind;

  @override
  void dependencies() {
    Get.lazyPut(() => DiaryDetailsController(diary: _diary, kind: _kind));
  }
}

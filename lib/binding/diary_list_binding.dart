import 'package:get/get.dart';

import '../controller/diary_list_controller.dart';

final class DiaryListBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => DiaryListController());
  }
}
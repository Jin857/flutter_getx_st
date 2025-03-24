import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt count = 0.obs; // 计数值

  RxInt value = 0.obs;

  // 增加函数
  void increment() {
    count++;
    Get.log("count change $count");
  }

  void incrementValue() {
    value++;
  }

  @override
  void onClose() {
    super.onClose();
    print("----------------- HomeController 被清理了");
  }
}

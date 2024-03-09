import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_tugas_api_database/db_helper.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  Database db = DbHelper.getDb();
  RxBool isLoading = false.obs;
  RxBool isMobileLayout = true.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    checkScreenWidth();
  }

  void checkScreenWidth() {
    double screenWidth = Get.width;
    isMobileLayout.value = screenWidth < 640;
  }

  @override
  void didChangeMetrics() {
    checkScreenWidth();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}

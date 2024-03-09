import 'dart:async';
import 'dart:io';
import 'package:flutter_tugas_api_database/api/ProductResponseModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

class ControllerListProduct extends GetxController {
  RxList<ProductResponseModel> productResponModelCtr =
      <ProductResponseModel>[].obs;
  RxBool isOffline = false.obs;
  StreamSubscription? connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    loadData();
    startMonitoringConnectivity();
  }

  @override
  void onClose() {
    connectivitySubscription?.cancel();
    super.onClose();
  }

  loadData() async {
    try {
      bool isConnected = await checkInternetConnection();

      if (isConnected) {
        final response = await http.get(Uri.parse(
            "https://makeup-api.herokuapp.com/api/v1/products.json?brand=smashbox"));

        if (response.statusCode == 200) {
          productResponModelCtr.value =
              productResponseModelFromJson(response.body);
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      } else {
        print('Offline mode: Unable to load data from API.');
        isOffline.value = true;
        productResponModelCtr.clear();
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void startMonitoringConnectivity() {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        isOffline.value = true;
        productResponModelCtr.clear();
      } else {
        isOffline.value = false;
        loadData();
      }
    });
  }
}

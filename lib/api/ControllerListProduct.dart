import 'package:flutter_tugas_api_database/model/ProductResponseModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ControllerListProduct extends GetxController {
  RxList<ProductResponseModel> productResponModelCtr =
      <ProductResponseModel>[].obs;
  SharedPreferences? prefs;
  RxBool isLoading = true.obs;

  RxString sessionUsername = "".obs;
  void loadSession() async{
    prefs = await SharedPreferences.getInstance();
    sessionUsername.value = prefs!.getString("username") ?? "no data";
    print("get username "+ sessionUsername.value.toString());
  }

  @override
  void onInit(){
    super.onInit();
    loadSession();
    loadData();
  }

  void loadData() async {
    try{
      final response = await http.get(Uri.parse(
          "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline"));

      if (response.statusCode == 200) {
        // mengisi data productResponModelCtr dengan hasil json dari model
        productResponModelCtr.value = productResponseModelFromJson(response.body);
      } else {
        print("status code : " + response.statusCode.toString());
      }

      isLoading.value = false;

    }catch(e){
      print("error : "+e.toString());
    }
  }
}
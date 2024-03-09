import 'dart:typed_data';
import 'package:flutter_tugas_api_database/db_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_tugas_api_database/model/favorite_model.dart';

class FavoriteController extends GetxController {
  Database? db = DbHelper.getDb();

  RxBool isLoading = false.obs;
  RxList<Like> like = <Like>[].obs;

  @override
  void onInit() {
    super.onInit();
    getNotes();
  }

  void getNotes() async {
    isLoading.value = true;
    List<Map<String, dynamic>> mapNotes = await db!.query("product");
    like.assignAll(mapNotes.map((e) => Like.fromMap(map: e)).toList());
    isLoading.value = false;
    print('Number of liked products: ${like.length}');
  }

  void createNote({
    required String name,
    required String price,
    required Uint8List imageLink,
  }) async {
    try {
      await db!.insert(
        'product',
        {'name': name, 'price': price, 'imageLink': imageLink},
      );
      print("$price, $name");
      getNotes();
    } catch (e) {
      print('Error inserting note: $e');
    }
  }

  void deleteNote(String name) async {
    await db!.delete("product", where: "name = ?", whereArgs: [name]);
    print("deleted");
    getNotes();
  }

  RxBool isLiked(String name) {
    return like.any((product) => product.name == name).obs;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tugas_api_database/controller/ControllerFavorite.dart';
import 'package:flutter_tugas_api_database/db_helper.dart';
import 'package:flutter_tugas_api_database/view/home/homepage.dart';
import 'package:flutter_tugas_api_database/view/like/like.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProductListPage(),
    );
  }
}

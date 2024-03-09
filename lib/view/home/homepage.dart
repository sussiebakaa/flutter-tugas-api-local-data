import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tugas_api_database/controller/ControllerListProduct.dart';
import 'package:flutter_tugas_api_database/model/favorite_model.dart';
import 'package:flutter_tugas_api_database/controller/ControllerFavorite.dart';
import 'package:flutter_tugas_api_database/view/like/like.dart';
import 'package:http/http.dart';

class ProductListPage extends StatelessWidget {
  final productController = Get.put(ControllerListProduct());
  final favoriteController = Get.put(FavoriteController());

  ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "MakemeUp",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
            onPressed: () {
              Get.to(
                () => FavoriteLayout(
                  favoriteController: favoriteController,
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          return productController.isOffline.value
              ? const Center(
                  child: Text(
                    'No Internet Connection',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                )
              : productController.productResponModelCtr.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount:
                                productController.productResponModelCtr.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio:
                                  0.8, // Adjust the aspect ratio as needed
                            ),
                            itemBuilder: (BuildContext ctx, int index) {
                              final product = productController
                                  .productResponModelCtr[index];
                              return Container(
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 220, 220, 220),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Image.network(
                                          product.imageLink,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.pink,
                                              ),
                                            ),
                                            SizedBox(height: 4.0),
                                            Text(
                                              '\$${product.price}',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 218, 83, 128),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Obx(() {
                                        return IconButton(
                                          onPressed: () async {
                                            var img = await get(
                                                Uri.parse(product.imageLink));
                                            var bytes = img.bodyBytes;
                                            if (favoriteController
                                                .isLiked(product.name)
                                                .value) {
                                              favoriteController
                                                  .deleteNote(product.name);
                                            } else {
                                              favoriteController.createNote(
                                                name: product.name,
                                                price: product.price.toString(),
                                                imageLink: bytes,
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            favoriteController
                                                    .isLiked(product.name)
                                                    .value
                                                ? Icons.favorite_rounded
                                                : Icons
                                                    .favorite_outline_rounded,
                                            size: 20,
                                            color: Colors.pinkAccent,
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
        }),
      ),
    );
  }
}

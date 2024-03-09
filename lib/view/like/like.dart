import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tugas_api_database/controller/ControllerListProduct.dart';
import 'package:flutter_tugas_api_database/controller/ControllerFavorite.dart';
import 'package:flutter_tugas_api_database/model/favorite_model.dart';

class FavoriteLayout extends StatelessWidget {
  final FavoriteController favoriteController;

  const FavoriteLayout({Key? key, required this.favoriteController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;
    // final itemWidth = (screenSize.width - 30) / 2;

    return Scaffold(
      body: Obx(() {
        return favoriteController.like.isEmpty
            ? Center(
                child: Text(
                  'No Favorited Product',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 236, 73, 130)),
                ),
              )
            : ListView.builder(
                itemCount: favoriteController.like.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      children: [
                        Image.memory(
                          favoriteController.like[index].imageLink,
                          width: 100,
                          height: 100,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              favoriteController.like[index].name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () async {
                            bool confirmDelete = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm Delete"),
                                  content: const Text(
                                      "Are you sure you want to delete this item?"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmDelete == true) {
                              favoriteController.deleteNote(
                                  favoriteController.like[index].name);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
      }),
    );
  }
}

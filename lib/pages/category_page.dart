import 'package:flutter/material.dart';
import 'package:flutter_application_pw21/models/media_model.dart';
import 'package:flutter_application_pw21/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryWidget extends ConsumerWidget {
  final PageController controller;
  final Box<String>? categoriesBox;
  const CategoryWidget(
      {super.key, required this.controller, required this.categoriesBox});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        categoriesBox != null
            ? ValueListenableBuilder(
                valueListenable: categoriesBox!.listenable(),
                builder: (context, Box<String> box, valueWidget) =>
                    ListView.builder(
                  itemCount: categoriesBox!.length,
                  itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      categoriesBox!.deleteAt(index);
                    },
                    child: GestureDetector(
                      child: Card(
                        color: Colors.blue,
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(categoriesBox!.values.elementAt(index)),
                          ),
                        ),
                      ),
                      onTap: () {
                        ref.read(mediaProvider.notifier).update(
                              (state) => MediaModel(
                                name: '',
                                info: '',
                                type: categoriesBox!.values.elementAt(index),
                              ),
                            );
                        controller.jumpToPage(1);
                      },
                    ),
                  ),
                ),
              )
            : const Center(child: Text('category list is emtpy')),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                showCategoryDialog(context, categoriesBox!);
              },
              child: const Icon(Icons.add),
            ),
          ),
        )
      ],
    );
  }
}

Future<void> showCategoryDialog(BuildContext context, Box<String> box) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      String category = '';
      return AlertDialog(
        title: const Text('Add Category'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                onChanged: (value) => category = value,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              if (category.isNotEmpty) {
                box.add(category);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

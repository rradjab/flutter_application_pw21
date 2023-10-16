import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw21/models/media_model.dart';
import 'package:flutter_application_pw21/providers/providers.dart';

class MultimediaWidget extends ConsumerWidget {
  final Box<MediaModel>? multimediasBox;
  final PageController controller;
  const MultimediaWidget(
      {super.key, required this.controller, required this.multimediasBox});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaModel = ref.watch(mediaProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(mediaModel.type),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => controller.jumpToPage(0),
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Stack(
        children: [
          multimediasBox != null
              ? ValueListenableBuilder(
                  valueListenable: multimediasBox!.listenable(),
                  builder: (context, Box<MediaModel> box, valueWidget) {
                    final multimediaList = multimediasBox!.values
                        .where((element) => element.type == mediaModel.type)
                        .toList();

                    return ListView.builder(
                      itemCount: multimediaList.length,
                      itemBuilder: (context, index) => Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          for (int i = 0;
                              i < multimediasBox!.values.length;
                              i++) {
                            if (multimediasBox!.values.elementAt(i).name ==
                                    multimediaList[index].name &&
                                multimediasBox!.values.elementAt(i).type ==
                                    mediaModel.type) {
                              multimediasBox!.deleteAt(i);
                              break;
                            }
                          }
                        },
                        child: GestureDetector(
                          child: Card(
                            color: Colors.blue,
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(multimediaList[index].name),
                              ),
                            ),
                          ),
                          onTap: () {
                            ref
                                .read(mediaProvider.notifier)
                                .update((state) => multimediaList[index]);
                            controller.jumpToPage(2);
                          },
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text('category list is emtpy')),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  showAddMediModelDialog(
                      context, multimediasBox!, mediaModel.type);
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showAddMediModelDialog(
    BuildContext context, Box<MediaModel> box, String category) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      String name = '';
      String info = '';
      return AlertDialog(
        title: const Text('Add Multimedia'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(hintText: 'Enter name'),
                onChanged: (value) => name = value,
              ),
              const Divider(),
              TextField(
                maxLines: null,
                minLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(hintText: 'Enter info'),
                onChanged: (value) => info = value,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              if (name.isNotEmpty && category.isNotEmpty) {
                box.add(MediaModel(name: name, info: info, type: category));
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

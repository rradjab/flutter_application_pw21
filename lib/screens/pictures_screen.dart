import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_pw21/services/download_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_application_pw21/models/widgets_model.dart';

class PicturesWidget extends StatefulWidget implements PageSample {
  const PicturesWidget({super.key});

  @override
  State<PicturesWidget> createState() => _PicturesWidgetState();

  @override
  getTitle() => 'Pictures';
}

class _PicturesWidgetState extends State<PicturesWidget> {
  final controller = TextEditingController();
  late final Directory documentsDir;
  List<FileSystemEntity> images = [];
  String? helperText;

  @override
  void initState() {
    getDocumentsDir();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getDocumentsDir() async {
    documentsDir = await getApplicationDocumentsDirectory();
    images = listImages();
    setState(() {});
  }

  List<FileSystemEntity> listImages() {
    return documentsDir
        .listSync()
        .where((e) =>
            e is File &&
            ['jpg', 'jpeg', 'bmp', 'png', 'ico', 'heic', 'svg']
                .contains(e.path.split('.').last.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: images.length,
            itemBuilder: ((context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Image.file(
                        File(images[index].path),
                      ),
                      subtitle: Text(
                          'File name: ${images[index].path.split('/').last}\nFile size (in bytes): ${File(images[index].path).lengthSync()}'),
                    ),
                  ),
                )),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Type url of image',
                    helperText: helperText,
                    helperStyle: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                helperText = await downloadImage(controller.text);
                if (helperText == null) {
                  controller.text = '';
                }
                images = listImages();
                setState(() {});
              },
              child: const Text('Get'),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_pw21/models/media_model.dart';
import 'package:flutter_application_pw21/models/widgets_model.dart';
import 'package:flutter_application_pw21/pages/category_page.dart';
import 'package:flutter_application_pw21/pages/multimedia_info_page.dart';
import 'package:flutter_application_pw21/pages/multimedia_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MoviesWidget extends StatefulWidget implements PageSample {
  const MoviesWidget({super.key});

  @override
  State<MoviesWidget> createState() => _MoviesWidgetState();

  @override
  getTitle() => 'Multimedia';
}

class _MoviesWidgetState extends State<MoviesWidget> {
  Box<String>? categoriesBox;
  Box<MediaModel>? multimediasBox;
  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(MediaModelAdapter().typeId)) {
      Hive.registerAdapter(MediaModelAdapter());
    }
    await Hive.openBox<String>('categories').then((value) {
      setState(() {
        categoriesBox = value;
      });
    });
    await Hive.openBox<MediaModel>('multimedias').then((value) {
      setState(() {
        multimediasBox = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      children: [
        CategoryWidget(controller: controller, categoriesBox: categoriesBox),
        MultimediaWidget(
          controller: controller,
          multimediasBox: multimediasBox,
        ),
        MultimediaInfoWidget(controller: controller)
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw21/providers/providers.dart';

class MultimediaInfoWidget extends ConsumerWidget {
  final PageController controller;
  const MultimediaInfoWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaModel = ref.watch(mediaProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(mediaModel.name),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => controller.jumpToPage(1),
            icon: const Icon(Icons.keyboard_arrow_left)),
      ),
      body: Card(
        child: Center(
          child: Text(mediaModel.info),
        ),
      ),
    );
  }
}

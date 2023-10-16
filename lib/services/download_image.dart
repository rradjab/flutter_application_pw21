import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> downloadImage(String link) async {
  Dio dio = Dio();
  final dir = await getApplicationDocumentsDirectory();
  String ext = 'jpg';
  if (link.split('/').last.contains('.')) {
    ext = link.split('/').last.split('.').last;
    if (!['jpg', 'jpeg', 'bmp', 'png', 'ico', 'heic', 'svg'].contains(ext)) {
      ext = 'jpg';
    }
  }
  String fileName =
      'image_${DateTime.now().toString().split('.')[0].replaceAll(' ', '_').replaceAll(':', '-')}.$ext';
  try {
    await dio.download(
      link,
      '${dir.path}/$fileName',
    );
    return null;
  } catch (e) {
    return 'Wrong image url';
  }
}

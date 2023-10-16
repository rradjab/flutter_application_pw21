import 'package:hive/hive.dart';

part 'media_model.g.dart';

@HiveType(typeId: 0)
class MediaModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String info;

  @HiveField(2)
  String type;

  MediaModel({required this.name, required this.info, required this.type});
}

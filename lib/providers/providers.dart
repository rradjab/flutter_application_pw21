import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw21/models/media_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_application_pw21/services/profiles_database.dart';

final mediaProvider = StateProvider<MediaModel>(
    (ref) => MediaModel(name: '', info: '', type: ''));

final databaseProvider = Provider<ProfileDatabase>((ref) => ProfileDatabase());

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  ),
);

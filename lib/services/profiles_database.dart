import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_application_pw21/models/bank_card_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'profiles_database.g.dart';

class ProfileItems extends Table {
  IntColumn get age => integer()();
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get bankIdKey => text()();
  TextColumn get firstname => text()();
  TextColumn get lastname => text()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  TextColumn get image => text()();

  @override
  Set<Column> get primaryKey => {email};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [ProfileItems])
class ProfileDatabase extends _$ProfileDatabase {
  ProfileDatabase() : super(_openConnection());

  Future<List<ProfileItem>> get allProfiles => select(profileItems).get();
  Stream<List<ProfileItem>> get profilesStream => select(profileItems).watch();
  // Future<int> insertProfile(ProfileItem profileItem) =>
  //     into(profileItems).insert(profileItem);
  // Future<bool> updateProfile(ProfileItem profileItem) =>
  //     update(profileItems).replace(profileItem);
  Future<int> createOrUpdateUser(ProfileItem profileItem) {
    return into(profileItems).insertOnConflictUpdate(profileItem);
  }

  Future<int> deleteProfile(String email) =>
      (delete(profileItems)..where((tbl) => tbl.email.equals(email))).go();

  @override
  int get schemaVersion => 1;
}

Future<BankCardModel> getCardInfo(
    FlutterSecureStorage secureStorage, String id) async {
  String? json = await secureStorage.read(key: id);
  return json == null
      ? BankCardModel(number: '', expireDate: '', cvv: '')
      : BankCardModel.deserialize(json);
}

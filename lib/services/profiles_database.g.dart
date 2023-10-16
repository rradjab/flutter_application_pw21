// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiles_database.dart';

// ignore_for_file: type=lint
class $ProfileItemsTable extends ProfileItems
    with TableInfo<$ProfileItemsTable, ProfileItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _bankIdKeyMeta =
      const VerificationMeta('bankIdKey');
  @override
  late final GeneratedColumn<String> bankIdKey = GeneratedColumn<String>(
      'bank_id_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstnameMeta =
      const VerificationMeta('firstname');
  @override
  late final GeneratedColumn<String> firstname = GeneratedColumn<String>(
      'firstname', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastnameMeta =
      const VerificationMeta('lastname');
  @override
  late final GeneratedColumn<String> lastname = GeneratedColumn<String>(
      'lastname', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [age, id, bankIdKey, firstname, lastname, email, phone, image];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_items';
  @override
  VerificationContext validateIntegrity(Insertable<ProfileItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bank_id_key')) {
      context.handle(
          _bankIdKeyMeta,
          bankIdKey.isAcceptableOrUnknown(
              data['bank_id_key']!, _bankIdKeyMeta));
    } else if (isInserting) {
      context.missing(_bankIdKeyMeta);
    }
    if (data.containsKey('firstname')) {
      context.handle(_firstnameMeta,
          firstname.isAcceptableOrUnknown(data['firstname']!, _firstnameMeta));
    } else if (isInserting) {
      context.missing(_firstnameMeta);
    }
    if (data.containsKey('lastname')) {
      context.handle(_lastnameMeta,
          lastname.isAcceptableOrUnknown(data['lastname']!, _lastnameMeta));
    } else if (isInserting) {
      context.missing(_lastnameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {email};
  @override
  ProfileItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileItem(
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bankIdKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bank_id_key'])!,
      firstname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}firstname'])!,
      lastname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lastname'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
    );
  }

  @override
  $ProfileItemsTable createAlias(String alias) {
    return $ProfileItemsTable(attachedDatabase, alias);
  }
}

class ProfileItem extends DataClass implements Insertable<ProfileItem> {
  final int age;
  final String id;
  final String bankIdKey;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String image;
  const ProfileItem(
      {required this.age,
      required this.id,
      required this.bankIdKey,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.phone,
      required this.image});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['age'] = Variable<int>(age);
    map['id'] = Variable<String>(id);
    map['bank_id_key'] = Variable<String>(bankIdKey);
    map['firstname'] = Variable<String>(firstname);
    map['lastname'] = Variable<String>(lastname);
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['image'] = Variable<String>(image);
    return map;
  }

  ProfileItemsCompanion toCompanion(bool nullToAbsent) {
    return ProfileItemsCompanion(
      age: Value(age),
      id: Value(id),
      bankIdKey: Value(bankIdKey),
      firstname: Value(firstname),
      lastname: Value(lastname),
      email: Value(email),
      phone: Value(phone),
      image: Value(image),
    );
  }

  factory ProfileItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileItem(
      age: serializer.fromJson<int>(json['age']),
      id: serializer.fromJson<String>(json['id']),
      bankIdKey: serializer.fromJson<String>(json['bankIdKey']),
      firstname: serializer.fromJson<String>(json['firstname']),
      lastname: serializer.fromJson<String>(json['lastname']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'age': serializer.toJson<int>(age),
      'id': serializer.toJson<String>(id),
      'bankIdKey': serializer.toJson<String>(bankIdKey),
      'firstname': serializer.toJson<String>(firstname),
      'lastname': serializer.toJson<String>(lastname),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'image': serializer.toJson<String>(image),
    };
  }

  ProfileItem copyWith(
          {int? age,
          String? id,
          String? bankIdKey,
          String? firstname,
          String? lastname,
          String? email,
          String? phone,
          String? image}) =>
      ProfileItem(
        age: age ?? this.age,
        id: id ?? this.id,
        bankIdKey: bankIdKey ?? this.bankIdKey,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
      );
  @override
  String toString() {
    return (StringBuffer('ProfileItem(')
          ..write('age: $age, ')
          ..write('id: $id, ')
          ..write('bankIdKey: $bankIdKey, ')
          ..write('firstname: $firstname, ')
          ..write('lastname: $lastname, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(age, id, bankIdKey, firstname, lastname, email, phone, image);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileItem &&
          other.age == this.age &&
          other.id == this.id &&
          other.bankIdKey == this.bankIdKey &&
          other.firstname == this.firstname &&
          other.lastname == this.lastname &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.image == this.image);
}

class ProfileItemsCompanion extends UpdateCompanion<ProfileItem> {
  final Value<int> age;
  final Value<String> id;
  final Value<String> bankIdKey;
  final Value<String> firstname;
  final Value<String> lastname;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> image;
  final Value<int> rowid;
  const ProfileItemsCompanion({
    this.age = const Value.absent(),
    this.id = const Value.absent(),
    this.bankIdKey = const Value.absent(),
    this.firstname = const Value.absent(),
    this.lastname = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.image = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileItemsCompanion.insert({
    required int age,
    this.id = const Value.absent(),
    required String bankIdKey,
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required String image,
    this.rowid = const Value.absent(),
  })  : age = Value(age),
        bankIdKey = Value(bankIdKey),
        firstname = Value(firstname),
        lastname = Value(lastname),
        email = Value(email),
        phone = Value(phone),
        image = Value(image);
  static Insertable<ProfileItem> custom({
    Expression<int>? age,
    Expression<String>? id,
    Expression<String>? bankIdKey,
    Expression<String>? firstname,
    Expression<String>? lastname,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? image,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (age != null) 'age': age,
      if (id != null) 'id': id,
      if (bankIdKey != null) 'bank_id_key': bankIdKey,
      if (firstname != null) 'firstname': firstname,
      if (lastname != null) 'lastname': lastname,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (image != null) 'image': image,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileItemsCompanion copyWith(
      {Value<int>? age,
      Value<String>? id,
      Value<String>? bankIdKey,
      Value<String>? firstname,
      Value<String>? lastname,
      Value<String>? email,
      Value<String>? phone,
      Value<String>? image,
      Value<int>? rowid}) {
    return ProfileItemsCompanion(
      age: age ?? this.age,
      id: id ?? this.id,
      bankIdKey: bankIdKey ?? this.bankIdKey,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bankIdKey.present) {
      map['bank_id_key'] = Variable<String>(bankIdKey.value);
    }
    if (firstname.present) {
      map['firstname'] = Variable<String>(firstname.value);
    }
    if (lastname.present) {
      map['lastname'] = Variable<String>(lastname.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileItemsCompanion(')
          ..write('age: $age, ')
          ..write('id: $id, ')
          ..write('bankIdKey: $bankIdKey, ')
          ..write('firstname: $firstname, ')
          ..write('lastname: $lastname, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('image: $image, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ProfileDatabase extends GeneratedDatabase {
  _$ProfileDatabase(QueryExecutor e) : super(e);
  late final $ProfileItemsTable profileItems = $ProfileItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [profileItems];
}

import 'package:flutter_application_pw21/models/bank_card_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_pw21/services/profiles_database.dart';

class ProfileAddWidget extends StatefulWidget {
  final ProfileDatabase database;
  final FlutterSecureStorage secureStorage;
  final ProfileItem? profileItem;
  const ProfileAddWidget(
      {super.key,
      required this.database,
      required this.secureStorage,
      this.profileItem});

  @override
  State<ProfileAddWidget> createState() => _ProfileAddWidgetState();
}

class _ProfileAddWidgetState extends State<ProfileAddWidget> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final bankCardNumber = TextEditingController();
  final bankCardExpiredate = TextEditingController();
  final bankCardCvv = TextEditingController();
  final age = TextEditingController();

  String? emailHelper;
  bool isNewProfile = true;
  final uuid = const Uuid().v4();
  late ProfileItem tempProfileItem;

  @override
  void initState() {
    if (widget.profileItem != null) {
      isNewProfile = false;
      initProfileParams(widget.profileItem!);
    } else {
      tempProfileItem = ProfileItem(
          age: 0,
          id: uuid,
          bankIdKey: '${uuid}_user_card_key',
          firstname: '',
          lastname: '',
          email: '',
          phone: '',
          image: '');
    }
    super.initState();
  }

  void initProfileParams(ProfileItem profileItem) async {
    String? json = await widget.secureStorage
        .read(key: '${widget.profileItem!.id}_user_card_key');
    BankCardModel model = json == null
        ? BankCardModel(number: '', expireDate: '', cvv: '')
        : BankCardModel.deserialize(json);
    firstname.text = profileItem.firstname;
    lastname.text = profileItem.lastname;
    email.text = profileItem.email;
    phone.text = profileItem.phone;
    age.text = profileItem.age.toString();
    bankCardNumber.text = model.number;
    bankCardExpiredate.text = model.expireDate;
    bankCardCvv.text = model.cvv;
    setState(() {});
  }

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    phone.dispose();
    bankCardNumber.dispose();
    bankCardExpiredate.dispose();
    bankCardCvv.dispose();
    age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${isNewProfile ? 'Add' : 'Edit'} User Profile'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(hintText: 'Enter First Name'),
              controller: firstname,
            ),
            const Divider(),
            TextField(
              decoration: const InputDecoration(hintText: 'Enter Last Name'),
              controller: lastname,
            ),
            const Divider(),
            TextField(
              enabled: isNewProfile,
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: InputDecoration(
                  hintText: 'Enter Email Address',
                  helperText: emailHelper,
                  helperStyle: const TextStyle(color: Colors.red)),
              onChanged: (value) {
                emailHelper = null;
                setState(() {});
              },
            ),
            const Divider(),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(hintText: 'Enter Phone'),
              controller: phone,
            ),
            const Divider(),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter Age',
              ),
              controller: age,
            ),
            const Divider(),
            const Text(
              'Bank Card Info',
              textAlign: TextAlign.center,
            ),
            const Divider(),
            TextField(
              maxLength: 16,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Bank Card Number',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.zero,
              ),
              controller: bankCardNumber,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Expire Date',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.zero,
                    ),
                    controller: bankCardExpiredate,
                    onChanged: (value) {
                      if (value.length == 2) {
                        bankCardExpiredate.text = '$value/';
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 3,
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.zero,
                    ),
                    controller: bankCardCvv,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(isNewProfile ? 'Add Profile' : 'Edit Profile'),
          onPressed: () {
            if (email.text.isEmpty) {
              emailHelper = 'Email must be added!';
            } else {
              widget.database.createOrUpdateUser(
                ProfileItem(
                    id: uuid,
                    age: int.parse(age.text),
                    bankIdKey: '${uuid}_user_card_key',
                    firstname: firstname.text,
                    lastname: lastname.text,
                    email: email.text,
                    phone: phone.text,
                    image: 'https://random.imagecdn.app/100/100'),
              );
              widget.secureStorage.write(
                  key: '${uuid}_user_card_key',
                  value: BankCardModel.serialize(BankCardModel(
                      number: bankCardNumber.text,
                      expireDate: bankCardExpiredate.text,
                      cvv: bankCardCvv.text)));
              Navigator.of(context).pop();
            }
            setState(() {});
          },
        ),
      ],
    );
  }
}

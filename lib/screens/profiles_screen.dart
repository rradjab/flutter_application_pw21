import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw21/providers/providers.dart';
import 'package:flutter_application_pw21/models/widgets_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_application_pw21/views/profile_add_view.dart';
import 'package:flutter_application_pw21/services/profiles_database.dart';

class ProfilesWidget extends ConsumerWidget implements PageSample {
  const ProfilesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseProvider);
    final secureStorage = ref.watch(secureStorageProvider);

    return Stack(
      children: [
        StreamBuilder<List<ProfileItem>>(
          stream: database.profilesStream,
          initialData: const [],
          builder: (context, profiles) => profiles.data == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: profiles.data!.length,
                  itemBuilder: (context, index) => FutureBuilder(
                    future: getCardInfo(
                        secureStorage, profiles.data![index].bankIdKey),
                    builder: (context, snap) {
                      return snap.data == null
                          ? const Center(child: CircularProgressIndicator())
                          : Dismissible(
                              key: UniqueKey(),
                              child: Card(
                                child: ListTile(
                                  onTap: () => showAddProfileDialog(
                                    context,
                                    database,
                                    secureStorage,
                                    profileItem: profiles.data![index],
                                  ),
                                  leading: Image.network(
                                      profiles.data![index].image),
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Name: ${profiles.data![index].firstname} ${profiles.data![index].lastname}, Age: ${profiles.data![index].age}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Email: ${profiles.data![index].email}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Phone: ${profiles.data![index].phone}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Bank card: ${snap.data!.number}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onDismissed: (direction) => database
                                  .deleteProfile(profiles.data![index].email),
                            );
                    },
                  ),
                ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                showAddProfileDialog(context, database, secureStorage);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }

  @override
  getTitle() => 'Profiles';
}

Future<void> showAddProfileDialog(BuildContext context,
    ProfileDatabase database, FlutterSecureStorage secureStorage,
    {ProfileItem? profileItem}) async {
  return showDialog<void>(
    context: context,
    //barrierDismissible: false,
    builder: (BuildContext context) {
      return ProfileAddWidget(
        database: database,
        secureStorage: secureStorage,
        profileItem: profileItem,
      );
    },
  );
}

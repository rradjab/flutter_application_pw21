import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw21/models/widgets_model.dart';
import 'package:flutter_application_pw21/screens/medias_screen.dart';
import 'package:flutter_application_pw21/screens/pictures_screen.dart';
import 'package:flutter_application_pw21/screens/profiles_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PageSample> pages = const [
    MoviesWidget(),
    PicturesWidget(),
    ProfilesWidget(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${pages[_selectedIndex].getTitle()} Page'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.movie),
            label: pages[0].getTitle(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.image),
            label: pages[1].getTitle(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_box),
            label: pages[2].getTitle(),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey[500],
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}

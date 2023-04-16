import 'package:flutter/material.dart';

void main() {
  MyApp app = MyApp();
  runApp(app);
}

class MyApp extends StatefulWidget {
  final List<IconData> icons = [
    Icons.format_paint,
    Icons.edit,
    Icons.animation,
    Icons.music_note_outlined,
    Icons.movie_outlined,
  ];

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _theme = ThemeData(primarySwatch: Colors.green);

  void _changeThemeColor(MaterialColor color) {
    setState(() {
      _theme = ThemeData(primarySwatch: color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _theme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomAppBar(
          title: "Escolha seu tema",
          changeThemeColor: _changeThemeColor,
        ),
        body: DataBodyWidget(objects: [
          "Mude o tema do app de acordo com sua preferência!",
        ]),
        bottomNavigationBar: NewNavBar(icons: widget.icons),
      ),
    );
  }
}

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
    required String title,
    required void Function(MaterialColor) changeThemeColor,
  }) : super(
          key: key,
          title: Text(title),
          actions: [
            PopupMenuButton<MaterialColor>(
              onSelected: changeThemeColor,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("Azul"),
                    value: Colors.blue,
                  ),
                  PopupMenuItem(
                    child: Text("Laranja"),
                    value: Colors.orange,
                  ),
                  PopupMenuItem(
                    child: Text("Verde"),
                    value: Colors.green,
                  ),
                  PopupMenuItem(
                    child: Text("Roxo"),
                    value: Colors.deepPurple,
                  ),
                ];
              },
            ),
          ],
        );
}

class NewNavBar extends StatelessWidget {
  final List<IconData> icons;

  NewNavBar({required this.icons});

  void buttonTouched(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: buttonTouched,
      fixedColor: Colors.green,
      unselectedItemColor: Colors.green,
      items: List.generate(
        icons.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(icons[index]),
          label: "Color $index",
        ),
      ),
    );
  }
}

class DataBodyWidget extends StatelessWidget {
  final List<String> objects;

  DataBodyWidget({required this.objects});

  Expanded processElement(String obj) {
    return Expanded(
      child: Center(child: Text(obj)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: objects
          .map(
            (obj) => Expanded(
              child: Center(child: Text(obj)),
            ),
          )
          .toList(),
    );
  }
}

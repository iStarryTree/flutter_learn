import 'package:flutter/material.dart';

import 'BaseCtrl/PFolderPicker.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pig Tools',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pig Porter')),
      body: Column(
        children: [
          PFolderPicker(),
        ],
      ),
    );
  }
}

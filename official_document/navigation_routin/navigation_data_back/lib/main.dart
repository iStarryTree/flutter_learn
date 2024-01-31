import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Returning Data Example'),
      ),
      body: const Center(
        child: Selectionbutton(),
      ),
    );
  }
}

class Selectionbutton extends StatefulWidget {
  const Selectionbutton({super.key});

  @override
  State<Selectionbutton> createState() => _SelectionbuttonState();
}

class _SelectionbuttonState extends State<Selectionbutton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Pick an option, any option!'),
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick an Option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Yep!');
                },
                child: const Text('Yep'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Nope');
                },
                child: const Text('Nope'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

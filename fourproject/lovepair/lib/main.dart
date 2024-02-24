import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '爱心配对',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _words = <WordPair>[];
  final _myWords = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    _words.addAll(generateWordPairs().take(10));

    return Scaffold(
      appBar: AppBar(
        title: const Text('爱心配对'),
        actions: [IconButton(onPressed: _goToLoved, icon: Icon(Icons.list))],
      ),
      body: Center(
        child: _buildList(),
      ),
    );
  }

  void _goToLoved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _myWords.map(
            (WordPair wordPair) {
              return ListTile(
                title: Text(wordPair.asCamelCase),
              );
            },
          );

          return Scaffold(
              appBar: AppBar(
                title: Text("喜爱的列表"),
              ),
              body: ListView(
                children: tiles.toList(),
              ));
        },
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index >= 10) {
            _words.addAll(generateWordPairs().take(10));
          }

          return _buildRow(index);
        },
        itemCount: _words.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        });
  }

  Widget _buildRow(index) {
    return ListTile(
      title: Text(_words[index].asPascalCase),
      subtitle: Text('subtitle'),
      trailing: _buildLoveIcon(_words[index]),
      onTap: () {
        _addToLove(_words[index]);
      },
    );
  }

  Widget _buildLoveIcon(WordPair wordPair) {
    {
      if (_myWords.contains(wordPair)) {
        return const Icon(Icons.favorite, color: Colors.red);
      } else {
        return const Icon(Icons.favorite_border);
      }
    }
  }

  void _addToLove(WordPair wordPair) {
    setState(() {
      if (_myWords.contains(wordPair)) {
        _myWords.remove(wordPair);
      } else {
        _myWords.add(wordPair);
      }
    });

    print(_myWords.length);
  }
}

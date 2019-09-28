// This code is fully working. No bugs.
// Showing how a lazy list of items can be loaded, how to route to another page when an icon is clicked, and how to save favourite items.
// This template can be combined with the listings.dart template to complete the listings/offerings feature.

// Tutorial:  https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1/#0
//            https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2/#1
// Source code: https://github.com/axross/flutter-startup-namer

// Send data from one screen to another screen
// https://flutter.dev/docs/cookbook/navigation/passing-data

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Startup Name Generator'), actions: [
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: _pushSaved,
        )
      ]),
      body: _buildSuggesions());

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final tiles = _saved.map((pair) =>
          ListTile(title: Text(pair.asPascalCase, style: _biggerFont)));
      final divided = ListTile.divideTiles(context: context, tiles: tiles);

      return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Suggestions'),
        ),
        body: new ListView(children: divided.toList()),
      );
    }));
  }

  Widget _buildSuggesions() => ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;

          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestions[index]);
        },
      );

  Widget _buildRow(WordPair pair) {
    final isSaved = _saved.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, style: _biggerFont),
      trailing: Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ),
      onTap: () =>
          setState(() => isSaved ? _saved.remove(pair) : _saved.add(pair)),
    );
  }
}

class LoginState extends State<Login> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Startup Name Generator'), actions: [
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: _pushSaved,
        )
      ]),
      body: _buildSuggesions());

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final tiles = _saved.map((pair) =>
          ListTile(title: Text(pair.asPascalCase, style: _biggerFont)));
      final divided = ListTile.divideTiles(context: context, tiles: tiles);

      return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Suggestions'),
        ),
        body: new ListView(children: divided.toList()),
      );
    }));
  }

  Widget _buildSuggesions() => ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;

          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestions[index]);
        },
      );

  Widget _buildRow(WordPair pair) {
    final isSaved = _saved.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, style: _biggerFont),
      trailing: Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ),
      onTap: () =>
          setState(() => isSaved ? _saved.remove(pair) : _saved.add(pair)),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class Login extends StatefulWidget {
  @override
  LoginState createState() => new LoginState();
}
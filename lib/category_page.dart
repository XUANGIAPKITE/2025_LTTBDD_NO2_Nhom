import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  final List<String> items;

  const CategoryPage({super.key, required this.category, required this.items});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          String word = widget.items[index];
          return ListTile(
            leading: const Icon(Icons.star_border, color: Colors.amber),
            title: Text(word, style: const TextStyle(fontSize: 18)),
            trailing: IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.teal),
              onPressed: () => _speak(word),
            ),
          );
        },
      ),
    );
  }
}

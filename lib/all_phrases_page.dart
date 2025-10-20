import 'package:flutter/material.dart';
import 'phrases_page.dart';

class AllPhrasesPage extends StatelessWidget {
  const AllPhrasesPage({super.key});

  final Map<String, List<Map<String, String>>> allPhrases = const {
    "Numbers": [
      {"en": "One", "vi": "Một"},
      {"en": "Two", "vi": "Hai"},
      {"en": "Three", "vi": "Ba"},
    ],
    "Colors": [
      {"en": "Red", "vi": "Đỏ"},
      {"en": "Blue", "vi": "Xanh dương"},
      {"en": "Green", "vi": "Xanh lá"},
    ],
    "Greetings": [
      {"en": "Hello!", "vi": "Xin chào!"},
      {"en": "Good morning!", "vi": "Chào buổi sáng!"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Phrases")),
      body: ListView(
        children: allPhrases.keys.map((category) {
          return ListTile(
            leading: const Icon(Icons.folder_open, color: Colors.teal),
            title: Text(
              category,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhrasesPage(category: category),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

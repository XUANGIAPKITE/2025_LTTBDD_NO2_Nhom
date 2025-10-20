import 'package:flutter/material.dart';
import 'practice_page.dart';

class PracticeTopicPage extends StatelessWidget {
  const PracticeTopicPage({super.key});

  final List<Map<String, String>> topics = const [
    {"title": "Greetings", "image": "https://i.imgur.com/6HmjOAK.png"},
    {"title": "Shopping", "image": "https://i.imgur.com/m8OAcf8.png"},
    {"title": "Travel", "image": "https://i.imgur.com/t3fB0GI.png"},
    {"title": "Food", "image": "https://i.imgur.com/yLdxY9N.png"},
    {"title": "Work", "image": "https://i.imgur.com/Ax5PcBj.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🎯 Choose a Topic"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PracticePage(topic: topic["title"]!),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      topic["image"]!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    topic["title"]!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

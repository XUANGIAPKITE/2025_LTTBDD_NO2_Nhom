import 'package:flutter/material.dart';
import 'practice_page.dart';

class PracticeTopicPage extends StatelessWidget {
  const PracticeTopicPage({super.key});

  final List<Map<String, String>> topics = const [
    {"title": "Greetings", "image": "assets/imgs/greetings.webp"},
    {"title": "Shopping", "image": "assets/imgs/shopping.jpg"},
    {"title": "Travel", "image": "assets/imgs/travel.jpg"},
    {"title": "Food", "image": "assets/imgs/food.jpg"},
    {"title": "Work", "image": "assets/imgs/work.webp"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose a Topic"),
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
                    child: Image.asset(
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

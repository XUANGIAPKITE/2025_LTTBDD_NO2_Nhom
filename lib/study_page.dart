import 'package:flutter/material.dart';
import 'lesson_detail_page.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = [
      {"title": "Lesson 1: Alphabet", "desc": "Learn English letters"},
      {"title": "Lesson 2: Numbers", "desc": "Counting from 1 to 100"},
      {"title": "Lesson 3: Basic Phrases", "desc": "Common greetings"},
      {"title": "Lesson 4: Food & Drinks", "desc": "Names of foods"},
      {"title": "Lesson 5: Travel", "desc": "Words for directions"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Study Page")),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(lesson["title"]!),
              subtitle: Text(lesson["desc"]!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // 👉 Chuyển sang trang chi tiết
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonDetailPage(
                      title: lesson["title"]!,
                      desc: lesson["desc"]!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

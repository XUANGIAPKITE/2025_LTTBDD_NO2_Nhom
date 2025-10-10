import 'package:flutter/material.dart';
import 'quiz_page.dart';
import 'study_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override    
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("American English"),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 10),
          Icon(Icons.flag),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Menu trên cùng (Phrases, Quiz, Study)
            Container(
              color: Colors.teal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const TabButton(title: "PHRASES", isActive: true),
                  TabButton(
                    title: "QUIZ",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizPage()),
                      );
                    },
                  ),
                  TabButton(
                    title: "STUDY",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudyPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Lưới ô chức năng
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: const [
                  FeatureCard(
                    title: "Favorites",
                    icon: Icons.star,
                    color: Colors.grey,
                  ),
                  FeatureCard(
                    title: "To Review",
                    icon: Icons.bookmark,
                    color: Colors.grey,
                  ),
                  FeatureCard(
                    title: "All Phrases",
                    icon: Icons.menu,
                    color: Colors.grey,
                  ),

                  FeatureCard(
                    title: "Numbers",
                    icon: Icons.onetwothree,
                    color: Colors.indigo,
                  ),
                  FeatureCard(
                    title: "Time & Date",
                    icon: Icons.access_time,
                    color: Colors.indigo,
                  ),
                  FeatureCard(
                    title: "Basic Conversation",
                    icon: Icons.chat,
                    color: Colors.indigo,
                  ),

                  FeatureCard(
                    title: "Greetings",
                    icon: Icons.waving_hand,
                    color: Colors.deepPurple,
                  ),
                  FeatureCard(
                    title: "Directions",
                    icon: Icons.directions_bus,
                    color: Colors.deepPurple,
                  ),
                  FeatureCard(
                    title: "Shopping",
                    icon: Icons.shopping_cart,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback? onTap;

  const TabButton({
    super.key,
    required this.title,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: isActive
            ? const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 3),
                ),
              )
            : null,
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap; // thêm callback

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // gắn sự kiện click
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

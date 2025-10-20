import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_page.dart';
import 'study_page.dart';
import 'login_page.dart';
import 'phrases_page.dart';
import 'favorites_page.dart';
import 'review_page.dart';
import 'all_phrases_page.dart';
import 'phrase_provider.dart';
import 'language_provider.dart'; // ✅ thêm dòng này
import 'practice_topic_page.dart';
import 'package:firebase_core/firebase_core.dart'; // ✅ Thêm dòng này để dùng Firebase

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ✅ Khởi tạo Firebase
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PhraseProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final language = context.watch<LanguageProvider>().language;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: language == 'en' ? 'Learning App' : 'Ứng dụng học tiếng Anh',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const LoginPage(), // Trang khởi đầu
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>().language;
    final langProvider = context.read<LanguageProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'en' ? "American English" : "Tiếng Anh Mỹ"),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          const SizedBox(width: 10),
          TextButton.icon(
            onPressed: () => langProvider.toggleLanguage(),
            icon: const Icon(Icons.language, color: Colors.white),
            label: Text(
              lang.toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Thanh menu trên đầu
            Container(
              color: Colors.teal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TabButton(
                    title: lang == 'en' ? "PHRASES" : "CỤM TỪ",
                    isActive: true,
                  ),
                  TabButton(
                    title: lang == 'en' ? "QUIZ" : "CÂU ĐỐ",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizPage()),
                      );
                    },
                  ),
                  TabButton(
                    title: lang == 'en' ? "STUDY" : "HỌC TẬP",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudyPage(),
                        ),
                      );
                    },
                  ),
                  TabButton(
                    title: lang == 'en' ? "PRACTICE" : "LUYỆN TẬP",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PracticeTopicPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // 🔹 Lưới danh mục chính
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  FeatureCard(
                    title: lang == 'en' ? "Favorites" : "Yêu thích",
                    icon: Icons.star,
                    color: Colors.grey,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoritesPage(),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: lang == 'en' ? "To Review" : "Ôn tập",
                    icon: Icons.bookmark,
                    color: Colors.grey,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ToReviewPage(),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: lang == 'en' ? "All Phrases" : "Tất cả cụm từ",
                    icon: Icons.menu,
                    color: Colors.grey,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllPhrasesPage(),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: lang == 'en' ? "Numbers" : "Số đếm",
                    icon: Icons.onetwothree,
                    color: Colors.indigo,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhrasesPage(category: "Numbers"),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: lang == 'en'
                        ? "Time & Date"
                        : "Thời gian & Ngày tháng",
                    icon: Icons.access_time,
                    color: Colors.indigo,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhrasesPage(category: "Time & Date"),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: lang == 'en' ? "Colors" : "Màu sắc",
                    icon: Icons.palette,
                    color: Colors.indigo,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhrasesPage(category: "Colors"),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: lang == 'en' ? "Greetings" : "Chào hỏi",
                    icon: Icons.waving_hand,
                    color: Colors.deepPurple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhrasesPage(category: "Greetings"),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: lang == 'en' ? "Directions" : "Chỉ đường",
                    icon: Icons.directions_bus,
                    color: Colors.deepPurple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhrasesPage(category: "Directions"),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: lang == 'en' ? "Shopping" : "Mua sắm",
                    icon: Icons.shopping_cart,
                    color: Colors.deepPurple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhrasesPage(category: "Shopping"),
                        ),
                      );
                    },
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

// -------------------- COMPONENT: Nút menu --------------------
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

// -------------------- COMPONENT: Ô danh mục --------------------
class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

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
      onTap: onTap,
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

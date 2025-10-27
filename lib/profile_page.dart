import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'phrase_provider.dart';
import 'practice_provider.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double quizAverage = 0.0;
  int quizCount = 0;
  int practiceCount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserStats();
  }

  Future<void> _loadUserStats() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        setState(() {
          quizAverage = (data['quizAverage'] ?? 0.0).toDouble();
          quizCount = (data['quizCount'] ?? 0).toInt();
          practiceCount = (data['practiceCount'] ?? 0).toInt();
        });
      }
    } catch (e) {
      debugPrint("❌ Error loading user stats: $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final phraseProvider = Provider.of<PhraseProvider>(context);
    final email = user?.email ?? "Chưa đăng nhập";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin cá nhân"),
        backgroundColor: Colors.teal,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadUserStats,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.person, size: 65, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      email,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    _buildInfoItem(
                      icon: Icons.favorite,
                      color: Colors.redAccent,
                      title: "Từ vựng yêu thích",
                      value: "${phraseProvider.favorites.length} từ",
                    ),
                    _buildInfoItem(
                      icon: Icons.quiz,
                      color: Colors.blueAccent,
                      title: "Điểm quiz trung bình",
                      value: "${quizAverage.toStringAsFixed(1)} điểm",
                    ),
                    _buildInfoItem(
                      icon: Icons.list_alt,
                      color: Colors.purple,
                      title: "Tổng số quiz đã làm",
                      value: "$quizCount lần",
                    ),
                    _buildInfoItem(
                      icon: Icons.refresh,
                      color: Colors.green,
                      title: "Số lần luyện nói",
                      value: "$practiceCount lần",
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Đăng xuất"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: color, size: 28),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      subtitle: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}

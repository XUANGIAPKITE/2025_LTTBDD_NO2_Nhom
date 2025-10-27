import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuestionPage extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final String quizTitle;

  const QuestionPage({
    super.key,
    required this.questions,
    required this.quizTitle,
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int currentQuestion = 0;
  int score = 0;
  bool answered = false;
  String? selectedAnswer;
  bool isSaving = false;

  void checkAnswer(String answer) {
    if (answered) return;

    final correctAnswer = widget.questions[currentQuestion]['answer'] as String;
    setState(() {
      answered = true;
      selectedAnswer = answer;
      if (answer == correctAnswer) {
        score++;
      }
    });
  }

  Future<void> nextQuestion() async {
    if (currentQuestion < widget.questions.length - 1) {
      setState(() {
        currentQuestion++;
        answered = false;
        selectedAnswer = null;
      });
    } else {
      await _saveQuizResult(); // ✅ lưu vào Firestore khi hoàn thành
      _showResultDialog();
    }
  }

  Future<void> _saveQuizResult() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => isSaving = true);

    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);

    final quizData = {
      'quizTitle': widget.quizTitle,
      'score': score,
      'totalQuestions': widget.questions.length,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      // ✅ 1️⃣: Lưu kết quả quiz vào subcollection
      await userRef.collection('quizResults').add(quizData);

      // ✅ 2️⃣: Lấy dữ liệu hiện tại của user (quizCount + quizAverage)
      final userDoc = await userRef.get();

      int prevCount = 0;
      double prevAverage = 0.0;

      if (userDoc.exists && userDoc.data() != null) {
        prevCount = (userDoc.data()!['quizCount'] ?? 0) as int;
        prevAverage = (userDoc.data()!['quizAverage'] ?? 0.0).toDouble();
      }

      // ✅ 3️⃣: Tính điểm phần trăm của lần làm quiz hiện tại
      final scorePercent = (score / widget.questions.length) * 100;
      final newCount = prevCount + 1;
      final newAverage = ((prevAverage * prevCount) + scorePercent) / newCount;

      // ✅ 4️⃣: Cập nhật lại vào document người dùng
      await userRef.set({
        'quizCount': newCount,
        'quizAverage': newAverage,
      }, SetOptions(merge: true));

      debugPrint(
        "✅ Quiz result saved successfully. New average: ${newAverage.toStringAsFixed(2)}",
      );
    } catch (e) {
      debugPrint("❌ Error saving quiz result: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error saving quiz result: $e")));
      }
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  void _showResultDialog() {
    final total = widget.questions.length;
    final scorePercent = (score / total) * 100;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("🎉 Quiz Completed!"),
        content: Text(
          "Your score: $score / $total\n(${scorePercent.toStringAsFixed(1)}%)",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Back to Quiz List"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestion];
    final options = question['options'] as List<String>;

    return Scaffold(
      appBar: AppBar(title: Text(widget.quizTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (currentQuestion + 1) / widget.questions.length,
            ),
            const SizedBox(height: 20),
            Text(
              "Question ${currentQuestion + 1}/${widget.questions.length}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              question['question'] as String,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ...options.map((option) {
              final isCorrect = option == question['answer'];
              final isSelected = option == selectedAnswer;
              Color? color;

              if (answered) {
                if (isSelected) {
                  color = isCorrect ? Colors.green : Colors.red;
                } else if (isCorrect) {
                  color = Colors.green.withOpacity(0.5);
                }
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color ?? Colors.teal,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(option),
                ),
              );
            }),
            const Spacer(),
            if (answered)
              ElevatedButton(
                onPressed: isSaving ? null : nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        currentQuestion == widget.questions.length - 1
                            ? "Finish Quiz"
                            : "Next Question",
                      ),
              ),
          ],
        ),
      ),
    );
  }
}

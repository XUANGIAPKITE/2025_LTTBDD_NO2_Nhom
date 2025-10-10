import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  final String setName;
  const QuestionPage({super.key, required this.setName});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int currentQuestion = 0;
  int score = 0;
  bool isFinished = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Flutter duoc viet bang ngon ngu nao?",
      "options": ["Java", "Kotlin", "Dart", "Swift"],
      "answer": 2,
    },
    {
      "question": "Widget nao dung de hien thi van ban?",
      "options": ["Text()", "Image()", "Column()", "Row()"],
      "answer": 0,
    },
    {
      "question": "Firebase la gi?",
      "options": [
        "He dieu hanh",
        "CSDL & Backend",
        "IDE",
        "Ngon ngu lap trinh",
      ],
      "answer": 1,
    },
  ];

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[currentQuestion]["answer"]) {
      score++;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      setState(() {
        isFinished = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.setName)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isFinished
            ? Center(
                child: Text(
                  "Ban da hoan thanh quiz!\nDiem: $score / ${questions.length}",
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cau ${currentQuestion + 1}/${questions.length}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    questions[currentQuestion]["question"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(
                    questions[currentQuestion]["options"].length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ElevatedButton(
                        onPressed: () => checkAnswer(index),
                        child: Text(
                          questions[currentQuestion]["options"][index],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

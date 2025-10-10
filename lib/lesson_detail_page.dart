import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonDetailPage extends StatefulWidget {
  final String title;
  final String desc;

  const LessonDetailPage({super.key, required this.title, required this.desc});

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  late YoutubePlayerController _controller;

  int? selectedAnswer;
  bool isFinished = false;

  final Map<String, dynamic> quiz = {
    "question": "Tu 'Hello' co nghia la gi?",
    "options": ["Xin chao", "Tam biet", "Cam on", "Hen gap lai"],
    "answer": 0,
  };

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        "https://www.youtube.com/watch?v=QFaFIcGhPoM",
      )!, // 👈 link video
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkAnswer(int index) {
    setState(() {
      selectedAnswer = index;
      isFinished = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.desc, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),

            // Video
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.teal,
            ),
            const SizedBox(height: 20),

            const Text(
              "Mini Quiz",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Text(quiz["question"], style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            ...List.generate(quiz["options"].length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFinished
                        ? (index == quiz["answer"]
                              ? Colors.green
                              : (index == selectedAnswer ? Colors.red : null))
                        : null,
                  ),
                  onPressed: isFinished ? null : () => checkAnswer(index),
                  child: Text(quiz["options"][index]),
                ),
              );
            }),

            if (isFinished)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  selectedAnswer == quiz["answer"]
                      ? "Chinh xac!"
                      : "Sai roi. Dap an dung la: ${quiz["options"][quiz["answer"]]}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

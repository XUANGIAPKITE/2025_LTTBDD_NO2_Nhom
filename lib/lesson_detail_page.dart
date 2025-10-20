import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonDetailPage extends StatefulWidget {
  final String title;
  final String desc;
  final String videoUrl;
  final Map<String, dynamic> quiz;

  const LessonDetailPage({
    super.key,
    required this.title,
    required this.desc,
    required this.videoUrl,
    required this.quiz,
  });

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  late YoutubePlayerController _controller;
  int? selectedAnswer;
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
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

  void restartQuiz() {
    setState(() {
      selectedAnswer = null;
      isFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final quiz = widget.quiz;

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

            // 🎥 YouTube Video
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
              final isCorrect = index == quiz["answer"];
              final isSelected = selectedAnswer == index;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFinished
                        ? (isCorrect
                              ? Colors.green
                              : (isSelected ? Colors.red : null))
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedAnswer == quiz["answer"]
                          ? "✅ Correct!"
                          : "❌ Incorrect. The correct answer is: ${quiz["options"][quiz["answer"]]}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: restartQuiz,
                      child: const Text("Try Again"),
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

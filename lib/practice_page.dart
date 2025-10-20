import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class PracticePage extends StatefulWidget {
  final String topic;
  const PracticePage({super.key, required this.topic});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isListening = false;
  String _spokenText = '';
  double _accuracy = 0;
  int _currentIndex = 0;

  final Map<String, List<Map<String, String>>> _sentences = {
    "Greetings": [
      {
        "sentence": "Hello, how are you?",
        "image": "https://i.imgur.com/3ZQ3ZbB.png",
      },
      {"sentence": "Good morning!", "image": "https://i.imgur.com/Ax5PcBj.png"},
      {
        "sentence": "Nice to meet you!",
        "image": "https://i.imgur.com/6HmjOAK.png",
      },
      {"sentence": "Good night!", "image": "https://i.imgur.com/ueCDmsF.png"},
    ],
    "Shopping": [
      {
        "sentence": "How much is this?",
        "image": "https://i.imgur.com/qRGm1nb.png",
      },
      {
        "sentence": "Do you have this in red?",
        "image": "https://i.imgur.com/m8OAcf8.png",
      },
      {
        "sentence": "I’d like to buy this one.",
        "image": "https://i.imgur.com/giYd4Us.png",
      },
      {
        "sentence": "Can I try it on?",
        "image": "https://i.imgur.com/GlrSuXZ.png",
      },
    ],
    "Travel": [
      {
        "sentence": "Where is the nearest bus stop?",
        "image": "https://i.imgur.com/De3qT4p.png",
      },
      {
        "sentence": "I need a taxi, please.",
        "image": "https://i.imgur.com/mgYwEwN.png",
      },
      {
        "sentence": "Can you show me on the map?",
        "image": "https://i.imgur.com/t3fB0GI.png",
      },
      {
        "sentence": "How long is the flight?",
        "image": "https://i.imgur.com/HZlYAK8.png",
      },
    ],
    "Food": [
      {
        "sentence": "I’d like a cup of coffee.",
        "image": "https://i.imgur.com/ysQDJk3.png",
      },
      {
        "sentence": "The food tastes great!",
        "image": "https://i.imgur.com/TbflMtG.png",
      },
      {
        "sentence": "Can I have the menu, please?",
        "image": "https://i.imgur.com/WZV3z5C.png",
      },
    ],
    "Work": [
      {
        "sentence": "I have a meeting today.",
        "image": "https://i.imgur.com/4jPoPpH.png",
      },
      {
        "sentence": "I need to send an email.",
        "image": "https://i.imgur.com/YcOeeRC.png",
      },
      {
        "sentence": "Let’s take a short break.",
        "image": "https://i.imgur.com/RsoPhtv.png",
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _initTTS();
  }

  void _initTTS() async {
    await _tts.setLanguage("en-US");
    await _tts.setSpeechRate(0.5);
  }

  Future<void> _speak(String text) async {
    await _tts.speak(text);
  }

  Future<void> _listen(String target) async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() {
            _spokenText = result.recognizedWords;
            _accuracy = _calculateAccuracy(_spokenText, target);
          });
        },
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  double _calculateAccuracy(String userSpeech, String target) {
    if (userSpeech.isEmpty) return 0;
    userSpeech = userSpeech.toLowerCase();
    target = target.toLowerCase();

    final userWords = userSpeech.split(' ');
    final targetWords = target.split(' ');
    int match = 0;

    for (var word in userWords) {
      if (targetWords.contains(word)) match++;
    }

    return (match / targetWords.length) * 100;
  }

  void _nextSentence() {
    final total = _sentences[widget.topic]!.length;
    setState(() {
      _currentIndex = (_currentIndex + 1) % total;
      _spokenText = '';
      _accuracy = 0;
    });
  }

  List<Widget> _buildStars(double accuracy) {
    int stars = (accuracy / 20).clamp(0, 5).toInt();
    return List.generate(
      5,
      (index) => Icon(
        index < stars ? Icons.star : Icons.star_border,
        color: index < stars ? Colors.amber : Colors.grey,
        size: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final current = _sentences[widget.topic]![_currentIndex];
    final sentence = current["sentence"]!;
    final image = current["image"]!;

    return Scaffold(
      appBar: AppBar(
        title: Text("🎙 ${widget.topic} Practice"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(image, height: 200, fit: BoxFit.cover),
            ),
            const SizedBox(height: 24),

            Text(
              sentence,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: () => _speak(sentence),
              icon: const Icon(Icons.volume_up),
              label: const Text("Listen"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: _isListening ? _stopListening : () => _listen(sentence),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: _isListening ? Colors.red : Colors.teal,
                child: Icon(
                  _isListening ? Icons.stop : Icons.mic,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              _spokenText.isEmpty
                  ? "🎧 Say the sentence aloud!"
                  : '"$_spokenText"',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),

            Text(
              "Accuracy: ${_accuracy.toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 20,
                color: _accuracy > 80
                    ? Colors.green
                    : _accuracy > 50
                    ? Colors.orange
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildStars(_accuracy),
            ),

            const Spacer(),

            ElevatedButton.icon(
              onPressed: _nextSentence,
              icon: const Icon(Icons.navigate_next),
              label: const Text("Next Sentence"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

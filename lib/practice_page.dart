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

  /// 🖼️ Thay thế toàn bộ link ảnh mạng bằng ảnh nội bộ trong assets/imgs/
  final Map<String, List<Map<String, String>>> _sentences = {
    "Greetings": [
      {"sentence": "Hello, how are you?", "image": "assets/imgs/hello.jpg"},
      {"sentence": "Good morning!", "image": "assets/imgs/good_morning.jpg"},
      {
        "sentence": "Nice to meet you!",
        "image": "assets/imgs/nice_to_meet_you.png",
      },
      {"sentence": "Good night!", "image": "assets/imgs/good_night.jpg"},
    ],
    "Shopping": [
      {"sentence": "How much is this?", "image": "assets/imgs/how_much.jpg"},
      {
        "sentence": "Do you have this in red?",
        "image": "assets/imgs/do_you_have_this_in_red.jpg",
      },
      {
        "sentence": "I’d like to buy this one.",
        "image": "assets/imgs/i_d_like_to_buy.jpg",
      },
      {"sentence": "Can I try it on?", "image": "assets/imgs/can_i_try.jpg"},
    ],
    "Travel": [
      {
        "sentence": "Where is the nearest bus stop?",
        "image": "assets/imgs/where_is_the_nearest_bus.jpg",
      },
      {
        "sentence": "I need a taxi, please.",
        "image": "assets/imgs/i_need_a_taxi.jpg",
      },
      {
        "sentence": "Can you show me on the map?",
        "image": "assets/imgs/can_u_show_me_on_the_map.jpg",
      },
      {
        "sentence": "How long is the flight?",
        "image": "assets/imgs/how_long_is_the_flight.jpg",
      },
    ],
    "Food": [
      {
        "sentence": "I’d like a cup of coffee.",
        "image": "assets/imgs/i_d_like_a_cup.jpg",
      },
      {
        "sentence": "The food tastes great!",
        "image": "assets/imgs/the_food_tastes_great.jpg",
      },
      {
        "sentence": "Can I have the menu, please?",
        "image": "assets/imgs/can_i_have_the_menu.jpg",
      },
    ],
    "Work": [
      {
        "sentence": "I have a meeting today.",
        "image": "assets/imgs/i_have_a_metting_today.jpg",
      },
      {
        "sentence": "I need to send an email.",
        "image": "assets/imgs/i_need_to_send_an_email.png",
      },
      {
        "sentence": "Let’s take a short break.",
        "image": "assets/imgs/let_take_a_break.jpg",
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
              child: Image.asset(image, height: 200, fit: BoxFit.cover),
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

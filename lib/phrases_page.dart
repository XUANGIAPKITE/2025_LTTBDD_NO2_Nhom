import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'phrase_provider.dart';

class PhrasesPage extends StatefulWidget {
  final String category;

  const PhrasesPage({super.key, required this.category});

  @override
  State<PhrasesPage> createState() => _PhrasesPageState();
}

class _PhrasesPageState extends State<PhrasesPage> {
  final FlutterTts tts = FlutterTts();

  final Map<String, List<Map<String, String>>> phrases = {
    "Numbers": [
      {"en": "One", "vi": "Một"},
      {"en": "Two", "vi": "Hai"},
      {"en": "Three", "vi": "Ba"},
      {"en": "Four", "vi": "Bốn"},
      {"en": "Five", "vi": "Năm"},
    ],
    "Time & Date": [
      {"en": "What time is it?", "vi": "Mấy giờ rồi?"},
      {"en": "It's nine o'clock.", "vi": "Bây giờ là 9 giờ."},
    ],
    "Colors": [
      {"en": "Red", "vi": "Đỏ"},
      {"en": "Blue", "vi": "Xanh dương"},
      {"en": "Green", "vi": "Xanh lá"},
    ],
    "Greetings": [
      {"en": "Hello!", "vi": "Xin chào!"},
      {"en": "Good morning!", "vi": "Chào buổi sáng!"},
      {"en": "How are you?", "vi": "Bạn khỏe không?"},
    ],
    "Directions": [
      {"en": "Turn left", "vi": "Rẽ trái"},
      {"en": "Go straight", "vi": "Đi thẳng"},
      {"en": "Turn right", "vi": "Rẽ phải"},
    ],
    "Shopping": [
      {"en": "How much is this?", "vi": "Cái này bao nhiêu tiền?"},
      {"en": "I’d like to buy this.", "vi": "Tôi muốn mua cái này."},
    ],
  };

  Future<void> speak(String text) async {
    await tts.setLanguage("en-US");
    await tts.setSpeechRate(0.5);
    await tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PhraseProvider>(context);
    final items = phrases[widget.category] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final phrase = items[index];
          final en = phrase["en"]!;
          final vi = phrase["vi"]!;

          final isFavorite = provider.favorites.contains(en);
          final isFlagged = provider.flagged.contains(en);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              title: Text(
                en,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(vi, style: const TextStyle(fontSize: 16)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ❤️
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => provider.toggleFavorite(en),
                  ),
                  // 🚩
                  IconButton(
                    icon: Icon(
                      isFlagged ? Icons.flag : Icons.outlined_flag,
                      color: isFlagged ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () => provider.toggleFlagged(en),
                  ),
                  // 🔊
                  IconButton(
                    icon: const Icon(Icons.volume_up, color: Colors.teal),
                    onPressed: () => speak(en),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

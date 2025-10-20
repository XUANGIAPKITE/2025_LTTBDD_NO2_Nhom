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
  bool answered = false;
  int? selectedAnswer;

  late List<Map<String, dynamic>> questions;

  @override
  void initState() {
    super.initState();
    questions = _getQuestionsBySet(widget.setName);
  }

  // ✅ Giữ nguyên toàn bộ phần câu hỏi gốc của bạn
  List<Map<String, dynamic>> _getQuestionsBySet(String setName) {
    switch (setName) {
      case "Set 1: Basic English Vocabulary":
        return [
          {
            "question": "What does the word 'apple' mean?",
            "options": ["A fruit", "An animal", "A color", "A drink"],
            "answer": 0,
          },
          {
            "question": "Which of these is a color?",
            "options": ["Dog", "Blue", "Table", "Book"],
            "answer": 1,
          },
          {
            "question": "What is the opposite of 'hot'?",
            "options": ["Cold", "Warm", "Big", "Fast"],
            "answer": 0,
          },
          {
            "question": "Which word is an animal?",
            "options": ["Chair", "Tiger", "Cloud", "Water"],
            "answer": 1,
          },
          {
            "question": "Which one is used for writing?",
            "options": ["Pen", "Car", "Apple", "TV"],
            "answer": 0,
          },
        ];

      case "Set 2: Common Phrases":
        return [
          {
            "question": "What does 'Good morning' mean?",
            "options": [
              "A greeting in the morning",
              "A farewell at night",
              "A thank you",
              "An apology",
            ],
            "answer": 0,
          },
          {
            "question": "What do you say when you meet someone new?",
            "options": ["Goodbye", "Hello", "Sorry", "Please"],
            "answer": 1,
          },
          {
            "question": "What do you say when you make a mistake?",
            "options": ["Sorry", "Thanks", "Welcome", "Yes"],
            "answer": 0,
          },
          {
            "question": "What does 'How are you?' mean?",
            "options": [
              "A way to ask about health",
              "A way to say goodbye",
              "A way to say thank you",
              "A way to introduce someone",
            ],
            "answer": 0,
          },
          {
            "question": "What is the correct reply to 'Thank you'?",
            "options": ["Welcome!", "Sorry!", "Goodbye!", "Yes!"],
            "answer": 0,
          },
        ];

      case "Set 3: Grammar Practice":
        return [
          {
            "question": "Choose the correct form: She ___ to school every day.",
            "options": ["go", "goes", "going", "gone"],
            "answer": 1,
          },
          {
            "question": "I ___ a book now.",
            "options": ["read", "reads", "am reading", "reading"],
            "answer": 2,
          },
          {
            "question": "They ___ football yesterday.",
            "options": ["play", "played", "plays", "playing"],
            "answer": 1,
          },
          {
            "question": "He ___ not like coffee.",
            "options": ["does", "do", "is", "has"],
            "answer": 0,
          },
          {
            "question": "There ___ some milk in the fridge.",
            "options": ["is", "are", "be", "was"],
            "answer": 0,
          },
        ];

      case "Set 4: Verb Tenses":
        return [
          {
            "question": "I ___ English for 5 years.",
            "options": ["learn", "have learned", "am learning", "learned"],
            "answer": 1,
          },
          {
            "question": "She ___ TV when I called.",
            "options": ["watched", "was watching", "is watching", "watches"],
            "answer": 1,
          },
          {
            "question": "They ___ to the park tomorrow.",
            "options": ["go", "went", "will go", "gone"],
            "answer": 2,
          },
          {
            "question": "He ___ already finished his homework.",
            "options": ["has", "have", "had", "is"],
            "answer": 0,
          },
          {
            "question": "By 2025, we ___ here for ten years.",
            "options": ["live", "lived", "will have lived", "have been living"],
            "answer": 2,
          },
        ];

      case "Set 5: Daily Conversations":
        return [
          {
            "question": "You meet a friend at a café. What do you say first?",
            "options": [
              "Good night",
              "Hi, how are you?",
              "See you soon",
              "Sorry",
            ],
            "answer": 1,
          },
          {
            "question": "You need help. What do you say?",
            "options": ["Please help me", "Good morning", "See you", "Welcome"],
            "answer": 0,
          },
          {
            "question": "Someone thanks you. You say:",
            "options": ["Goodbye", "You're welcome", "Hi", "Sorry"],
            "answer": 1,
          },
          {
            "question": "You didn’t hear what someone said. What do you say?",
            "options": ["What?", "Excuse me?", "Hi!", "Bye!"],
            "answer": 1,
          },
          {
            "question": "At the end of a call, you say:",
            "options": ["Goodbye!", "Hi!", "Sorry!", "What’s up?"],
            "answer": 0,
          },
        ];

      case "Set 6: Travel English":
        return [
          {
            "question": "You want to buy a train ticket. You say:",
            "options": [
              "How much is a ticket to London?",
              "Where is the toilet?",
              "Can I have a coffee?",
              "What time is it?",
            ],
            "answer": 0,
          },
          {
            "question":
                "At the airport, you need to find your flight. You ask:",
            "options": [
              "Where is the check-in counter?",
              "What’s your name?",
              "How much is it?",
              "Can I see a doctor?",
            ],
            "answer": 0,
          },
          {
            "question": "In a hotel, you want a room. You say:",
            "options": [
              "I’d like a room, please.",
              "Can I cook here?",
              "Is this your bag?",
              "Where’s the school?",
            ],
            "answer": 0,
          },
          {
            "question": "You are lost. You ask:",
            "options": [
              "Can you help me find this place?",
              "How much is this?",
              "What time is it?",
              "Where is my phone?",
            ],
            "answer": 0,
          },
          {
            "question": "At a restaurant, you say:",
            "options": [
              "Can I see the menu, please?",
              "Can I play football?",
              "Where is my teacher?",
              "Is this your car?",
            ],
            "answer": 0,
          },
        ];

      case "Set 7: Business English":
        return [
          {
            "question": "What does CEO stand for?",
            "options": [
              "Chief Executive Officer",
              "Customer Experience Officer",
              "Corporate Employment Office",
              "Central Economic Office",
            ],
            "answer": 0,
          },
          {
            "question": "Which word means 'meeting by internet'?",
            "options": ["Conference call", "Office trip", "Vacation", "Lunch"],
            "answer": 0,
          },
          {
            "question": "You want to send a file by email. You say:",
            "options": [
              "Please find attached the file.",
              "I lost the file.",
              "Check my phone.",
              "It's too late.",
            ],
            "answer": 0,
          },
          {
            "question": "A polite way to ask for help in business:",
            "options": [
              "Could you please help me?",
              "Give me that!",
              "Do it now!",
              "Help!",
            ],
            "answer": 0,
          },
          {
            "question": "A 'deadline' means:",
            "options": [
              "The final date to finish something",
              "A lunch break",
              "A type of meeting",
              "A holiday",
            ],
            "answer": 0,
          },
        ];

      case "Set 8: Idioms & Expressions":
        return [
          {
            "question": "What does 'Break a leg!' mean?",
            "options": ["Good luck!", "Be careful!", "Run fast!", "Sit down!"],
            "answer": 0,
          },
          {
            "question": "‘Piece of cake’ means:",
            "options": [
              "Something very easy",
              "Something delicious",
              "Something expensive",
              "Something hard",
            ],
            "answer": 0,
          },
          {
            "question": "‘Under the weather’ means:",
            "options": [
              "Feeling sick",
              "It’s raining",
              "Feeling happy",
              "In trouble",
            ],
            "answer": 0,
          },
          {
            "question": "‘Hit the books’ means:",
            "options": [
              "Start studying",
              "Throw books",
              "Go to sleep",
              "Read for fun",
            ],
            "answer": 0,
          },
          {
            "question": "‘Let the cat out of the bag’ means:",
            "options": [
              "Reveal a secret",
              "Buy a pet",
              "Run away",
              "Make a mistake",
            ],
            "answer": 0,
          },
        ];

      default:
        return [
          {
            "question": "No questions available for this set.",
            "options": ["OK"],
            "answer": 0,
          },
        ];
    }
  }

  // ✅ Logic chấm điểm + hiển thị đúng/sai từng câu
  void checkAnswer(int selectedIndex) {
    if (answered) return; // không cho bấm lại
    setState(() {
      selectedAnswer = selectedIndex;
      answered = true;
      if (selectedIndex == questions[currentQuestion]["answer"]) score++;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestion < questions.length - 1) {
        setState(() {
          currentQuestion++;
          answered = false;
          selectedAnswer = null;
        });
      } else {
        setState(() => isFinished = true);
      }
    });
  }

  void restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      isFinished = false;
      answered = false;
      selectedAnswer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.setName)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isFinished
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "🎉 You finished the quiz!\nScore: $score / ${questions.length}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: restartQuiz,
                      child: const Text("Restart Quiz"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Back to Quiz List"),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Question ${currentQuestion + 1} of ${questions.length}",
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
                    (index) {
                      final isCorrect =
                          index == questions[currentQuestion]["answer"];
                      final isSelected = index == selectedAnswer;

                      Color color = Colors.blue;
                      if (answered) {
                        if (isSelected && isCorrect)
                          color = Colors.green;
                        else if (isSelected && !isCorrect)
                          color = Colors.red;
                        else if (isCorrect)
                          color = Colors.green;
                        else
                          color = Colors.grey;
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          onPressed: () => checkAnswer(index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(
                            questions[currentQuestion]["options"][index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

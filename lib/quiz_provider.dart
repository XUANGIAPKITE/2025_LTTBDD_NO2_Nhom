import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  double _averageScore = 0.0;
  int _quizCount = 0;

  double get averageScore => _averageScore;
  int get quizCount => _quizCount;

  Future<void> loadUserQuizData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      _averageScore = (data['quizAverage'] ?? 0.0).toDouble();
      _quizCount = (data['quizCount'] ?? 0).toInt();
      notifyListeners();
    }
  }

  Future<void> saveQuizResult(double newScore) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore.collection('users').doc(user.uid);
    final doc = await docRef.get();

    int prevCount = 0;
    double prevAvg = 0.0;

    if (doc.exists) {
      final data = doc.data()!;
      prevCount = (data['quizCount'] ?? 0).toInt();
      prevAvg = (data['quizAverage'] ?? 0.0).toDouble();
    }

    final newCount = prevCount + 1;
    final newAverage = ((prevAvg * prevCount) + newScore) / newCount;

    await docRef.set({
      'quizCount': newCount,
      'quizAverage': newAverage,
    }, SetOptions(merge: true));

    _quizCount = newCount;
    _averageScore = newAverage;
    notifyListeners();
  }
}

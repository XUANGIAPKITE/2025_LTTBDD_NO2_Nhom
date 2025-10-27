import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PracticeProvider extends ChangeNotifier {
  int practiceCount = 0;
  double averageAccuracy = 0;

  PracticeProvider() {
    _loadPracticeData();
  }

  Future<void> _loadPracticeData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final data = doc.data();
    if (data != null) {
      practiceCount = (data['practiceCount'] ?? 0);
      averageAccuracy = (data['averageAccuracy'] ?? 0).toDouble();
      notifyListeners();
    }
  }

  Future<void> updatePractice(double accuracy) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    practiceCount++;
    averageAccuracy =
        ((averageAccuracy * (practiceCount - 1)) + accuracy) / practiceCount;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'practiceCount': practiceCount,
      'averageAccuracy': averageAccuracy,
    }, SetOptions(merge: true));

    notifyListeners();
  }
}

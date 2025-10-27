import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhraseProvider extends ChangeNotifier {
  final Set<String> favorites = {};
  final Set<String> flagged = {};

  PhraseProvider() {
    _loadUserPhrases();
  }

  Future<void> _loadUserPhrases() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final data = doc.data();
    if (data != null) {
      favorites.addAll(List<String>.from(data['favorites'] ?? []));
      flagged.addAll(List<String>.from(data['flagged'] ?? []));
      notifyListeners();
    }
  }

  Future<void> _saveUserPhrases() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'favorites': favorites.toList(),
      'flagged': flagged.toList(),
      'favoriteCount': favorites.length, // ✅ lưu thêm số lượng từ yêu thích
    }, SetOptions(merge: true));
  }

  void toggleFavorite(String phrase) {
    if (favorites.contains(phrase)) {
      favorites.remove(phrase);
    } else {
      favorites.add(phrase);
    }
    _saveUserPhrases();
    notifyListeners();
  }

  void toggleFlagged(String phrase) {
    if (flagged.contains(phrase)) {
      flagged.remove(phrase);
    } else {
      flagged.add(phrase);
    }
    _saveUserPhrases();
    notifyListeners();
  }
}

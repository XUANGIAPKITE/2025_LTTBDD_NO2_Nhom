import 'package:flutter/material.dart';

class PhraseProvider extends ChangeNotifier {
  final Set<String> _favorites = {};
  final Set<String> _flagged = {};

  Set<String> get favorites => _favorites;
  Set<String> get flagged => _flagged;

  void toggleFavorite(String phrase) {
    if (_favorites.contains(phrase)) {
      _favorites.remove(phrase);
    } else {
      _favorites.add(phrase);
    }
    notifyListeners();
  }

  void toggleFlagged(String phrase) {
    if (_flagged.contains(phrase)) {
      _flagged.remove(phrase);
    } else {
      _flagged.add(phrase);
    }
    notifyListeners();
  }
}

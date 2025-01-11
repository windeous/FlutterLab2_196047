import 'package:flutter/material.dart';
import '../models/joke.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Joke> _favoriteJokes = [];

  List<Joke> get favoriteJokes => List.unmodifiable(_favoriteJokes);

  void addFavorite(Joke joke) {
    if (!_favoriteJokes.contains(joke)) {
      _favoriteJokes.add(joke);
      notifyListeners();
    }
  }

  void removeFavorite(Joke joke) {
    if (_favoriteJokes.contains(joke)) {
      _favoriteJokes.remove(joke);
      notifyListeners();
    }
  }

  bool isFavorite(Joke joke) {
    return _favoriteJokes.contains(joke);
  }
}

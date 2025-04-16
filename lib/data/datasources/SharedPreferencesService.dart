import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesService {
  final SharedPreferences prefs;

  SharedPreferencesService(this.prefs);

  static const _favouritesKey = 'favourite_books';

  Future<void> saveFavourites(List<String> favouriteKeys) async {
    await prefs.setStringList(_favouritesKey, favouriteKeys);
  }

  List<String> loadFavourites() {
    return prefs.getStringList(_favouritesKey) ?? [];
  }

  loadFavouriteBooks() {}
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class ApiService {
  static const String _baseUrl = 'https://official-joke-api.appspot.com';

  static Future<List<String>> getJokeTypes() async {
    final response = await http.get(Uri.parse('$_baseUrl/types'));

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load joke types');
    }
  }

  static Future<List<Joke>> getJokesByType(String type) async {
    final response = await http.get(Uri.parse('$_baseUrl/jokes/$type/ten'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Joke.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  static Future<Joke> getRandomJoke() async {
    final response = await http.get(Uri.parse('$_baseUrl/random_joke'));

    if (response.statusCode == 200) {
      return Joke.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load random joke');
    }
  }
}

import 'dart:convert';

import 'package:hoblist_movies/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieController {
  var url = 'https://hoblist.com/movieList';
  Future<MovieList?> fetchMovies() async {
    final Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    Object params = {
      "category": "movies",
      "language": "telugu",
      "genre": "all",
      "sort": "voting",
    };

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: jsonEncode(params),
    );
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw 'Error Occurred';
    }
  }
}

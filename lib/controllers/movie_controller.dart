import 'dart:convert';

import 'package:hoblist_movies/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieController {
  var url = 'https://hoblist.com/movieList';

  MovieList? _movieList;
  Future<void> fetchMovies() async {
    var params = {
      "category": "movies",
      "language": "telugu",
      "genre": "all",
      "sort": "voting"
    };

    var body = jsonEncode(params);

    try {
      var response = await http.post(
        Uri.parse(url),
        body: body,
      );

      if (response.statusCode == 200) {
        _movieList = MovieList.fromJson(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}

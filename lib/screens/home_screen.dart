import 'package:flutter/material.dart';
import 'package:hoblist_movies/controllers/movie_controller.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();

    getMovie();
  }

  void getMovie() async {
    await MovieController().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

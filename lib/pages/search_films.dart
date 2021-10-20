import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imdb_api/functions/functions.dart';
import 'dart:convert';
import 'package:imdb_api/constants/constants.dart';
import 'package:imdb_api/pages/movie_card.dart';
import 'package:imdb_api/modals/movie_model.dart';

class SerachPage extends StatefulWidget {
  final List<Movie> moviesList;
  const SerachPage({Key? key, required this.moviesList}) : super(key: key);

  @override
  _SerachPageState createState() => _SerachPageState();
}

class _SerachPageState extends State<SerachPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Searching'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
          itemCount: widget.moviesList.length,
          itemBuilder: (context, index) {
            return MovieCard(
              movie: widget.moviesList[index],
            );
          }),
    );
  }
}

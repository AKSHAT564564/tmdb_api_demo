import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:imdb_api/modals/movie_model.dart';

class MyHomePage extends StatefulWidget {
  final Movie movie;
  const MyHomePage({Key? key, required this.movie}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> dataMap = [];
  final String TMDB_API_BASE_URL = 'https://api.themoviedb.org/3';
  final String TMDB_API_KEY = 'd11e770e2c07687ac0ba5be868758004';

  getResponse() async {
    MovieList movieList;
    var res = await http.get(Uri.parse(
        '$TMDB_API_BASE_URL/movie/157336?api_key=$TMDB_API_KEY&append_to_response=credits'));
    var decodeRes = jsonDecode(res.body);
    movieList = MovieList.fromJson(decodeRes);
  }

  @override
  void initState() {
    super.initState();
    print(widget.movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width,
                      child: widget.movie.posterPath == null
                          ? Image.asset('assets/na.jpg')
                          : Image.network(
                              'https://image.tmdb.org/t/p/w500/${widget.movie.posterPath!}',
                              fit: BoxFit.cover,
                            )),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    color: Colors.black.withOpacity(0.4),
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 1.8,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          child: Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.movie.title!,
                                      style: const TextStyle(
                                          fontSize: 24.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 8.0, 8.0, 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(Icons.star_border_outlined),
                                        Text(widget.movie.voteAverage!),
                                        Text(widget.movie.releaseDate!),
                                      ],
                                    ),
                                  ),
                                  const Text("Plot",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(widget.movie.overview!),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text("Vote Count ${widget.movie.voteCount!}",
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                      "Language ${widget.movie.originalLanguage!}",
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text("Adult ${widget.movie.adult!}",
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ));
    // body: Center(child: Text(widget.movie.title!),),
  }
}

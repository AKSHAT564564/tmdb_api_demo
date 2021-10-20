import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:imdb_api/constants/constants.dart';
import 'package:imdb_api/modals/movie_model.dart';
import 'package:imdb_api/pages/film_detail_page.dart';
import 'package:imdb_api/functions/functions.dart';

class ScrollMovie extends StatefulWidget {
  final String api,title;
  const ScrollMovie({Key? key, required this.api,required this.title}) : super(key: key);

  @override
  _ScrollMovieState createState() => _ScrollMovieState();
}

class _ScrollMovieState extends State<ScrollMovie> {
  List<Movie>? movieList;
  @override
  void initState() {
    super.initState();
    ApiFunctions().fetchMovies(widget.api).then((value) {
      setState(() {
        movieList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(widget.title),
        )
      ]),
      SizedBox(
        width: double.infinity,
        height: 200,
        child: movieList == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: movieList!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyHomePage(movie: movieList![index])));
                      },
                      child: Hero(
                          tag: '${movieList![index].id}${widget.title}',
                          child: SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                Expanded(
                                    child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: FadeInImage(
                                    placeholder:
                                        const AssetImage('assets/na.jpg'),
                                    image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500/${movieList![index].posterPath!}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    movieList![index].title!,
                                    style: const TextStyle(fontSize: 12.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  );
                },
              ),
      )
    ]);
  }
}

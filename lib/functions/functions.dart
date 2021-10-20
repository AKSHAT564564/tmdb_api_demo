import 'package:imdb_api/modals/movie_model.dart';
import 'package:imdb_api/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:imdb_api/modals/genres_modal.dart';


class ApiFunctions {
  Future<List<Movie>> fetchMovies(String api) async {
    MovieList movieList;
    var res = await http.get(Uri.parse(api));
    var decodeRes = jsonDecode(res.body);
    movieList = MovieList.fromJson(decodeRes);

    return movieList.movies ?? [];
  }

  
  Future<GenresList> fetchGenres() async {
    GenresList genresList;
    var res = await http.get(Uri.parse(
        '$TMDB_API_BASE_URL/genre/movie/list?api_key=$TMDB_API_KEY&language=en-US'));
    var decodeRes = jsonDecode(res.body);
    print(decodeRes);
    genresList = GenresList.fromJson(decodeRes);
    return genresList;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api/functions/functions.dart';
import 'package:imdb_api/modals/movie_model.dart';
import 'package:imdb_api/constants/constants.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  final ApiFunctions _repo;
  MovieSearchCubit(this._repo) : super(NoMovieSearchedState());

  final searchController = TextEditingController();

  Future getMovieSearched() async {
    String query = searchController.text;
    emit(MovieSearchingState());

    final movieList = await _repo.fetchMovies(
        '$TMDB_API_BASE_URL/search/movie?query=$query&api_key=$TMDB_API_KEY');

    if (movieList == null)
      emit(ErrorState());
    else {
      print(movieList);
      emit(MovieSearchedState(movieList));
      emit(NoMovieSearchedState());
    }
  }
}

abstract class MovieSearchState {}

class NoMovieSearchedState extends MovieSearchState {}

class MovieSearchingState extends MovieSearchState {}

class MovieSearchedState extends MovieSearchState {
  final List<Movie> moviesList;

  MovieSearchedState(this.moviesList);
}

class ErrorState extends MovieSearchState {}

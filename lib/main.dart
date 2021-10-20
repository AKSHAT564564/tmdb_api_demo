import 'package:flutter/material.dart';
import 'package:imdb_api/bloc/search_bloc.dart';
import 'package:imdb_api/functions/functions.dart';
import 'package:imdb_api/pages/film_detail_page.dart';
import 'package:imdb_api/pages/search_films.dart';
import 'package:imdb_api/pages/widgets.dart';
import 'package:imdb_api/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
            create: (context) => MovieSearchCubit(ApiFunctions()),
            child: MyHomePageOne()));
  }
}

class MyHomePageOne extends StatefulWidget {
  const MyHomePageOne({Key? key}) : super(key: key);

  @override
  _MyHomePageOneState createState() => _MyHomePageOneState();
}

class _MyHomePageOneState extends State<MyHomePageOne> {
  bool _searchRequest = false, _isLoading = false;
  String searchFeildValue = "";
  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget customSearchBar = const Text('IMDB API Demo');

  List<Map<String, dynamic>> searchDetails = [];

  @override
  void initState() {
    super.initState();
    ApiFunctions().fetchGenres();
  }

  getLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  getErrorWidget() {
    return Center(
      child: Text('Some Eorror'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MovieSearchCubit>();
    return BlocListener(
      listener: (context, state) {
        if (state is MovieSearchedState && state.moviesList != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SerachPage(moviesList: state.moviesList)));
        }
      },
      bloc: cubit,
      child: Scaffold(
          body: cubit.state is MovieSearchingState
              ? getLoadingWidget()
              : cubit.state is ErrorState
                  ? getErrorWidget()
                  : cubit.state is NoMovieSearchedState
                      ? Container(
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                controller: cubit.searchController,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  prefixIcon: GestureDetector(
                                      onTap: (() {
                                        cubit.getMovieSearched();
                                      }),
                                      child: const Icon(Icons.search)),
                                  hintText: 'Enter your ',
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                ),
                              ),
                              const ScrollMovie(
                                api: '$TMDB_API_BASE_URL'
                                    '/discover/movie?api_key='
                                    '$TMDB_API_KEY'
                                    '&language=en-US&sort_by=popularity'
                                    '.desc&include_adult=false&include_video=false&page'
                                    '=1',
                                title: 'Popular',
                              ),
                              const ScrollMovie(
                                api: '$TMDB_API_BASE_URL'
                                    '/movie/top_rated?api_key='
                                    '$TMDB_API_KEY'
                                    '&include_adult=false&page=1'
                                    '=1',
                                title: 'Top Rated',
                              ),
                              const ScrollMovie(
                                api: '$TMDB_API_BASE_URL'
                                    '/movie/upcoming?api_key='
                                    '$TMDB_API_KEY'
                                    '&include_adult=false&page=1',
                                title: 'Upcoming',
                              ),
                              const ScrollMovie(
                                  api: '$TMDB_API_BASE_URL'
                                      '/movie/now_playing?api_key='
                                      '$TMDB_API_KEY'
                                      '&include_adult=false&page=1',
                                  title: 'Now Playing'),
                            ],
                          ),
                        )
                      : Container(
                          child: Text('pata nhi kya hua'),
                        )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/model.dart/moviesdetailsModel.dart';
import 'package:transparent_image/transparent_image.dart';

class MoviesDetails extends StatefulWidget {
  const MoviesDetails({super.key, required this.movieId});
  final int movieId;
  @override
  // ignore: no_logic_in_create_state
  State<MoviesDetails> createState() =>
      // ignore: no_logic_in_create_state
      _MoviesDetailsState(movieId);
}

class _MoviesDetailsState extends State<MoviesDetails> {
  MoviesdetailsResponse? movieDetailsResults;
  var isLoaded = false;
  final int movieId;
  _MoviesDetailsState(this.movieId);

  @override
  void initState() {
    super.initState();
    getTrendingMoviesData();
  }

  getTrendingMoviesData() async {
    movieDetailsResults = await API().fetchMoviesDetails(movieId);
    if (movieDetailsResults != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: API().fetchMoviesDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 21, 28, 38),
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 240,
                    pinned: true,
                    backgroundColor: const Color.fromARGB(255, 21, 28, 38),
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(left: 5, bottom: 6),
                      title: Text(
                        movieDetailsResults?.title ?? "".toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      background: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(2),
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: NetworkImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://image.tmdb.org/t/p/w1280/${movieDetailsResults!.backdropPath}"))),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.5)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0, 1],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SliverPadding(
                      padding: const EdgeInsets.all(0.0),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "OVERVIEW",
                                    style: TextStyle(
                                        color: Colors.white60,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0),
                                  )),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, bottom: 10, top: 10, right: 10),
                                child: Text(
                                  movieDetailsResults!.overview.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      height: 1.5),
                                ),
                              ),
                            ],
                          ),
                        )
                      ])))
                ],
              ),
              //appBar: AppBar(
              //  title: Text(movieDetailsResults?.title ?? "".toString()),
              //),
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

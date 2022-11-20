import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/model.dart/moviesdetailsModel.dart';

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
                    backgroundColor: const Color.fromARGB(255, 21, 28, 38),
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(left: 5, bottom: 6),
                      title: Text(
                        movieDetailsResults?.title ?? "".toString(),
                      ),
                      background: Container(
                        // margin: const EdgeInsets.only(right: 10, left: 10),
                        //   width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            // borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w1280/${movieDetailsResults!.backdropPath}"))),
                      ),
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
                                  padding: EdgeInsets.only(left: 10),
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
                                padding: const EdgeInsets.all(10.0),
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

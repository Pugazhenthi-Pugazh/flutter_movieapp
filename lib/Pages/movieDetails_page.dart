import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/model.dart/moviesdetailsModel.dart';
import 'package:shimmer/shimmer.dart';
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
                    expandedHeight: 200,
                    // pinned: true,
                    backgroundColor: const Color.fromARGB(255, 21, 28, 38),
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.only(left: 10, bottom: 10),
                      title: Text(
                        movieDetailsResults?.title ?? "".toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      background: Stack(children: [
                        Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.white54,
                            child: Container(
                                decoration: const BoxDecoration(
                              color: Colors.black12,
                            ))),

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
                                Colors.black.withOpacity(0.2)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0, 1],
                            ),
                          ),
                        ),
                        //  AspectRatio(
                        //    aspectRatio: 1.8234,
                        //    child: Container(
                        //      decoration: BoxDecoration(
                        //        gradient: LinearGradient(
                        //          colors: [
                        //            Colors.black.withOpacity(0.1),
                        //            const Color.fromARGB(255, 21, 28, 38)
                        //                .withOpacity(1.0)
                        //          ],
                        //          begin: Alignment.topCenter,
                        //          end: Alignment.bottomCenter,
                        //          stops: const [0, 1],
                        //        ),
                        //      ),
                        //    ),
                        //  ),
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
                              Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.0,
                                          bottom: 10,
                                          top: 10,
                                          right: 10),
                                      child: Icon(
                                        Icons.access_time_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                  Text(
                                    getDuration(movieDetailsResults!.runtime),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        height: 1.5),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40.0,
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            movieDetailsResults!.genres.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Center(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    color: Colors.white
                                                        .withOpacity(0.1)),
                                                child: Text(
                                                  movieDetailsResults!
                                                      .genres[index].name,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      height: 1.4,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 9.0),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
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
                        ),
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

  String getDuration(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}min';
  }
}

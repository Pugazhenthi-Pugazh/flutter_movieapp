import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/model.dart/movieCastsModel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieCasts extends StatefulWidget {
  final int id;
  const MovieCasts({super.key, required this.id});

  @override
  // ignore: no_logic_in_create_state
  State<MovieCasts> createState() => _MovieCastsState(id);
}

class _MovieCastsState extends State<MovieCasts> {
  final int id;
  _MovieCastsState(this.id);

  List<CastResult>? movieCastsResult;
  var isLoaded = false;
  var movieCastsResult_ResultLength;

  @override
  void initState() {
    super.initState();
    getCastData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getCastData() async {
    movieCastsResult = await API().fetchCast(id);
    if (movieCastsResult != null) {
      print(movieCastsResult!.length.toString());
      setState(() {
        isLoaded = true;
        movieCastsResult_ResultLength = movieCastsResult!.length.toInt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: movieCastsResult_ResultLength,
          padding: EdgeInsets.only(left: 5.0),
          itemBuilder: (BuildContext context, int index) {
            if (movieCastsResult != null) {
              return Container(
                padding: EdgeInsets.only(top: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Stack(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.black87,
                                  highlightColor: Colors.white54,
                                  enabled: true,
                                  child: const SizedBox(
                                    height: 120.0,
                                    child: AspectRatio(
                                        aspectRatio: 2 / 3,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.black26,
                                          size: 40.0,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 120.0,
                                  child: Stack(
                                    children: [
                                      AspectRatio(
                                          aspectRatio: 2 / 3,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            child: movieCastsResult![index]
                                                        .profilePath ==
                                                    null
                                                ? Container(
                                                    child: const Icon(
                                                      Icons.person,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                // ignore: prefer_interpolation_to_compose_strings
                                                                "https://image.tmdb.org/t/p/w1280/${movieCastsResult![index].profilePath}"))),
                                                  ),
                                          )),
                                      AspectRatio(
                                        aspectRatio: 2 / 3,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.2),
                                                Colors.black.withOpacity(0.5)
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: const [0, 1],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 3.0,
                                          left: 3.0,
                                          right: 3.0,
                                          child: SizedBox(
                                            width: 80.0,
                                            child: Text(
                                              movieCastsResult![index].name,
                                              style: const TextStyle(
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.transparent,
              ));
            }
          }),
    );
  }
}

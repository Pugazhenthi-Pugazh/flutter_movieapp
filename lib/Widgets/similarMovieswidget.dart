import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/Pages/movieDetails_page.dart';
import 'package:flutter_movieapp/model.dart/smilarMoviesModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SimilarMovies extends StatefulWidget {
  const SimilarMovies({super.key, required this.movieId});
  final int movieId;
  @override
  State<SimilarMovies> createState() => _SimilarMoviesState(movieId);
}

class _SimilarMoviesState extends State<SimilarMovies> {
  final int movieId;
  _SimilarMoviesState(this.movieId);

  List<SimilarMovieResult>? similarmoviesResults;
  var isLoaded = false;
  var similarmovies_ResultLength;

  @override
  void initState() {
    super.initState();
    getSimilarMoviesData();
  }

  getSimilarMoviesData() async {
    similarmoviesResults = await API().fetchSimilarmovies(movieId);
    if (similarmoviesResults != null) {
      print(similarmoviesResults!.length.toString());
      setState(() {
        isLoaded = true;
        similarmovies_ResultLength = similarmoviesResults!.length.toInt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          height: 250,
          // color: Colors.white,
          child: Visibility(
              visible: isLoaded,
              replacement: Center(child: const CircularProgressIndicator()),
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: similarmovies_ResultLength,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoviesDetails(
                                        movieId: similarmoviesResults![index]
                                            .id
                                            .toInt(),
                                      )),
                            );
                          },
                          child: similarmoviesResults![index].posterPath == null
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  width: 110.0,
                                  height: 170.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: const Icon(
                                    Icons.image_outlined,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  width: 110.0,
                                  height: 170.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(2),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              "https://image.tmdb.org/t/p/w1280/" +
                                                  similarmoviesResults![index]
                                                      .posterPath
                                                      .toString()))),
                                )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 120.0,
                        child: Text(
                          similarmoviesResults![index].title,
                          maxLines: 2,
                          style: const TextStyle(
                              height: 1.4,
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: 110.0,
                          child: Row(
                            children: [
                              Text(
                                similarmoviesResults![index]
                                    .voteAverage
                                    .toStringAsFixed(1),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              RatingBar.builder(
                                itemSize: 8.0,
                                initialRating:
                                    similarmoviesResults![index].voteAverage /
                                        2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                unratedColor: Colors.white.withOpacity(0.5),
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )
                            ],
                          ))
                    ],
                  );
                },
              )))
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_movieapp/model.dart/genersMoviesModel.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GenresMovieWidget extends StatefulWidget {
  const GenresMovieWidget({super.key, required this.generid});
  final int generid;

  @override

  // ignore: no_logic_in_create_state
  State<GenresMovieWidget> createState() => _GenresMovieWidgetState(generid);
}

class _GenresMovieWidgetState extends State<GenresMovieWidget> {
  List<GenersMoviesResult>? genersMoviesResults;
  var isLoaded = false;
  var genersMovies_ResultLength;
  final int generid;
  _GenresMovieWidgetState(this.generid);

  @override
  void initState() {
    super.initState();
    getGenersMoviesData();
  }

  getGenersMoviesData() async {
    genersMoviesResults = await API().fetchGeneresMovies(generid);
    if (genersMoviesResults != null) {
      setState(() {
        isLoaded = true;
        genersMovies_ResultLength = genersMoviesResults!.length.toInt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          height: 270,
          // color: Colors.white,
          child: Visibility(
              visible: isLoaded,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: genersMovies_ResultLength,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      // ignore: unnecessary_null_comparison
                      genersMoviesResults![index].posterPath == null
                          ? Container(
                              height: 180,
                              width: 120,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                                shape: BoxShape.rectangle,
                              ),
                              child: Column(
                                children: const [Icon(Icons.movie_rounded)],
                              ),
                            )
                          : Container(
                              margin:
                                  const EdgeInsets.only(right: 10, left: 10),
                              width: 120.0,
                              height: 180.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(2),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "https://image.tmdb.org/t/p/w1280/" +
                                              genersMoviesResults![index]
                                                  .posterPath))),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 120.0,
                        child: Text(
                          genersMoviesResults![index].title,
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
                                genersMoviesResults![index]
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
                                    genersMoviesResults![index].voteAverage / 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
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
    ;
  }
}

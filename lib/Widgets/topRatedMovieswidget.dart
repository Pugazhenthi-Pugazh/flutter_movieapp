import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/model.dart/topRatedMoviesModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TopRatedMoviesWidget extends StatefulWidget {
  const TopRatedMoviesWidget({super.key});

  @override
  State<TopRatedMoviesWidget> createState() => _TopRatedMoviesWidgetState();
}

class _TopRatedMoviesWidgetState extends State<TopRatedMoviesWidget> {
  List<TopRatedMoviesResult>? topRatedMoviesResults;
  var isLoaded = false;
  var topRatedMovies_ResultLength;

  @override
  void initState() {
    super.initState();
    getTopRatedMoviesData();
  }

  getTopRatedMoviesData() async {
    topRatedMoviesResults = await API().fetchTopRatedMovies();
    if (topRatedMoviesResults != null) {
      print(topRatedMoviesResults!.length.toString());
      setState(() {
        isLoaded = true;
        topRatedMovies_ResultLength = topRatedMoviesResults!.length.toInt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        alignment: Alignment.centerLeft,
        child: const Text(
          "  TOP RATED MOVIES",
          style: TextStyle(
              height: 1.5,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      // ignore: sized_box_for_whitespace
      Container(
          height: 270,
          // color: Colors.white,
          child: Visibility(
              visible: isLoaded,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: topRatedMovies_ResultLength,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10, left: 10),
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
                                        topRatedMoviesResults![index]
                                            .posterPath))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 120.0,
                        child: Text(
                          topRatedMoviesResults![index].title,
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
                                topRatedMoviesResults![index]
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
                                    topRatedMoviesResults![index].voteAverage /
                                        2,
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
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/Pages/movieDetails_page.dart';
import 'package:flutter_movieapp/model.dart/trendingMoviesModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TrendingMoviesWidget extends StatefulWidget {
  const TrendingMoviesWidget({super.key});

  @override
  State<TrendingMoviesWidget> createState() => _TrendingMoviesWidgetState();
}

class _TrendingMoviesWidgetState extends State<TrendingMoviesWidget> {
  List<TrendingMoivesResult>? trendingmovieResults;
  var isLoaded = false;
  var trending_ResultLength;

  @override
  void initState() {
    super.initState();
    getTrendingMoviesData();
  }

  getTrendingMoviesData() async {
    trendingmovieResults = await API().fetchTrendingMovies();
    if (trendingmovieResults != null) {
      print(trendingmovieResults!.length.toString());
      setState(() {
        isLoaded = true;
        trending_ResultLength = trendingmovieResults!.length.toInt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        alignment: Alignment.centerLeft,
        child: const Text(
          "  TRENDING MOVIES",
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
                itemCount: trending_ResultLength,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoviesDetails(
                                        movieId: trendingmovieResults![index]
                                            .id
                                            .toInt(),
                                      )),
                            );
                          },
                          child: Container(
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
                                            trendingmovieResults![index]
                                                .posterPath))),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 120.0,
                        child: Text(
                          trendingmovieResults![index].title,
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
                                trendingmovieResults![index]
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
                                    trendingmovieResults![index].voteAverage /
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

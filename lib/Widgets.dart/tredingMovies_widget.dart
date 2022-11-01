import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/model.dart/TrendingMoviesModel.dart';

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
          "  Trending Movies",
          style: TextStyle(
              height: 1.5,
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 23.0),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
          height: 270,
          // color: Colors.white,
          child: Visibility(
              visible: isLoaded,
              replacement: Center(child: const CircularProgressIndicator()),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trending_ResultLength,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        width: 130.0,
                        height: 190.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(3),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    "https://image.tmdb.org/t/p/w200/" +
                                        trendingmovieResults![index]
                                            .posterPath))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 100.0,
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
                    ],
                  );
                },
              )))
    ]);
  }
}

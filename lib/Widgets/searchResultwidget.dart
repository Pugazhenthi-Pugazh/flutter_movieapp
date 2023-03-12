// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/Pages/movieDetails_page.dart';
import 'package:flutter_movieapp/model.dart/searchResultModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class SearchResultWiget extends StatefulWidget {
  const SearchResultWiget({super.key, required this.movieName});
  final String movieName;

  @override
  State<SearchResultWiget> createState() => _SearchResultWigetState(movieName);
}

class _SearchResultWigetState extends State<SearchResultWiget> {
  List<SearchMoiveResult>? searchMovieResult;
  var isLoaded = false;
  var searchMovieResult_ResultLength;
  final String movieName;
  _SearchResultWigetState(this.movieName);

  @override
  void initState() {
    super.initState();

    getsearchMoiveResultData();

    print("movine name:$movieName");
  }

  @override
  void dispose() {
    super.dispose();
  }

  getsearchMoiveResultData() async {
    searchMovieResult = await API().fetchSearchResult(movieName);
    if (searchMovieResult != null) {
      print(searchMovieResult!.length.toString());
      setState(() {
        isLoaded = true;
        searchMovieResult_ResultLength = searchMovieResult!.length.toInt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: API().fetchSearchResult(movieName),
        builder: (context, snapshot) {
          if (searchMovieResult != null) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: searchMovieResult_ResultLength,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoviesDetails(
                                  movieId: searchMovieResult![index].id.toInt(),
                                )),
                      );
                    },
                    child: Card(
                        color: const Color.fromARGB(255, 21, 28, 38),
                        child: Container(
                          child: Column(
                            children: [
                              Row(children: [
                                searchMovieResult![index].posterPath == null
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        width: 100.0,
                                        height: 130.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: const Icon(
                                          Icons.image_outlined,
                                          size: 100,
                                          color: Colors.grey,
                                        ))
                                    : Container(
                                        margin: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        width: 100.0,
                                        height: 130.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    "https://image.tmdb.org/t/p/w1280/" +
                                                        searchMovieResult![
                                                                index]
                                                            .posterPath
                                                            .toString()))),
                                      ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      child: Text(
                                        searchMovieResult![index].title,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            height: 1.4,
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: 100.0,
                                        child: Row(
                                          children: [
                                            Text(
                                              searchMovieResult![index]
                                                  .voteAverage
                                                  .toStringAsFixed(1),
                                              textAlign: TextAlign.start,
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
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
                                                  searchMovieResult![index]
                                                          .voteAverage /
                                                      2,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              unratedColor:
                                                  Colors.white.withOpacity(0.5),
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            )
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          135,
                                      child: Text(
                                        searchMovieResult![index]
                                            .overview
                                            .toString(),
                                        textDirection: TextDirection.ltr,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            height: 1.5),
                                      ),
                                    )
                                  ],
                                )
                              ]),
                            ],
                          ),
                        )));
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

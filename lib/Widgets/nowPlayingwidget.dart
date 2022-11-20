// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/model.dart/nowPlayingModel.dart';
import 'package:page_indicator/page_indicator.dart';

class NowPlayingwidget extends StatefulWidget {
  const NowPlayingwidget({super.key});

  @override
  State<NowPlayingwidget> createState() => _NowPlayingwidgetState();
}

class _NowPlayingwidgetState extends State<NowPlayingwidget> {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  final API moviesApi = API();
  List<NowPlayingMoviesResult>? nowPlayingmovieResults;
  var isLoaded = false;
  var resultLength;
  @override
  void initState() {
    super.initState();
    getMoviesData();
  }

  getMoviesData() async {
    nowPlayingmovieResults = await API().fetchNowPlayingMovies();
    if (nowPlayingmovieResults != null) {
      setState(() {
        isLoaded = true;
        resultLength = nowPlayingmovieResults!.take(10).length.toInt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230,
        child: Visibility(
            visible: isLoaded,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: PageIndicatorContainer(
              align: IndicatorAlign.bottom,
              length: 10,
              indicatorSpace: 8.0,
              padding: const EdgeInsets.all(5.0),
              indicatorColor: Colors.white,
              indicatorSelectorColor: const Color(0xFFF4c10F),
              shape: IndicatorShape.circle(size: 5.0),
              child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: resultLength,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(children: [
                            Hero(
                                tag: nowPlayingmovieResults![index].id,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  width: MediaQuery.of(context).size.width - 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://image.tmdb.org/t/p/w1280/" +
                                                  nowPlayingmovieResults![index]
                                                      .backdropPath))),
                                )),
                            const Positioned(
                                top: 0,
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Icon(
                                  Icons.play_circle_outline_rounded,
                                  color: Color(0xFFF4c10F),
                                  size: 50,
                                )),
                            Positioned(
                                bottom: 20.0,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  width: 250.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        nowPlayingmovieResults![index].title,
                                        style: const TextStyle(
                                            height: 1.2,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 23.0),
                                      )
                                    ],
                                  ),
                                ))
                          ])
                        ]);
                  }),
            )));
  }
}

// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';

class NowPlayingwidget extends StatefulWidget {
  const NowPlayingwidget({super.key});

  @override
  State<NowPlayingwidget> createState() => _NowPlayingwidgetState();
}

class _NowPlayingwidgetState extends State<NowPlayingwidget> {
  final API moviesApi = API();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: moviesApi.fetchMovies(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          }
          if (snapshot.hasData) {
            return Container(
                height: 230,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(children: [
                              Hero(
                                  tag: snapshot.data[index]['id'],
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "https://image.tmdb.org/t/p/w500/" +
                                                    snapshot.data[index]
                                                        ['backdrop_path']))),
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
                                          snapshot.data[index]['title'],
                                          style: const TextStyle(
                                              height: 1.5,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23.0),
                                        )
                                      ],
                                    ),
                                  ))
                            ])
                          ]);
                    }));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

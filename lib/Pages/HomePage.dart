// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/Pages/searchPage.dart';
import 'package:flutter_movieapp/Widgets/genresWidget.dart';
import 'package:flutter_movieapp/Widgets/nowPlayingwidget.dart';
import 'package:flutter_movieapp/Widgets/tredingMovies_widget.dart';
import 'package:flutter_movieapp/Widgets/topRatedMovieswidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final API moviesApi = API();
  @override
  void initState() {
    super.initState();
    API().fetchGeneresList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 21, 28, 38),
        appBar: AppBar(
            leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            backgroundColor: const Color.fromARGB(255, 21, 28, 38),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MovieSearchPage()),
                    );
                  })
            ],
            centerTitle: true,
            title: (const Text(
              "Movie Buff",
              textAlign: TextAlign.center,
            ))),
        body: ListView(
          shrinkWrap: true,
          children: const [
            SizedBox(
              height: 10,
            ),
            NowPlayingwidget(),
            SizedBox(
              height: 10,
            ),
            TrendingMoviesWidget(),
            TopRatedMoviesWidget(),
            GenresWidget(),
          ],
        ));
  }
}

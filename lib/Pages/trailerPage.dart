// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/model.dart/movieTrailerModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerPage extends StatefulWidget {
  const MovieTrailerPage({super.key, required this.id});
  final int id;
  @override
  // ignore: no_logic_in_create_state
  State<MovieTrailerPage> createState() => _MovieTrailerPageState(id);
}

class _MovieTrailerPageState extends State<MovieTrailerPage> {
  final int id;
  _MovieTrailerPageState(this.id);
  List<MovieTrailerResult>? moviTrailerResult;
  var isLoaded = false;

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    getTrendingMovieTrailer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getTrendingMovieTrailer() async {
    moviTrailerResult = await API().fetchTrailer(id);
    if (moviTrailerResult != null) {
      setState(() {
        isLoaded = true;
        int trailerIndex =
            // ignore: non_constant_identifier_names
            moviTrailerResult!.indexWhere((Ind) => Ind.type == 'Trailer');

        _controller = YoutubePlayerController(
            initialVideoId: moviTrailerResult![trailerIndex].key,
            flags: const YoutubePlayerFlags(
              controlsVisibleAtStart: true,
              autoPlay: false,
            ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: API().fetchTrailer(id),
        builder: (context, snapshot) {
          if (moviTrailerResult != null) {
            return OrientationBuilder(
                builder: (BuildContext context, Orientation orientation) {
              if (orientation == Orientation.portrait) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                  ),
                  backgroundColor: Colors.black,
                  body: Container(
                    alignment: Alignment.center,
                    child: YoutubePlayer(
                      progressIndicatorColor: Colors.yellow,
                      controller: _controller,
                      onReady: () => debugPrint('Ready'),
                      bottomActions: [
                        CurrentPosition(),
                        ProgressBar(
                          isExpanded: true,
                          colors: const ProgressBarColors(
                              playedColor: Colors.red, handleColor: Colors.red),
                        ),
                        FullScreenButton(),
                        RemainingDuration(),
                      ],
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  backgroundColor: Colors.black,
                  body: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 1.05,
                    child: YoutubePlayer(
                      progressIndicatorColor: Colors.yellow,
                      controller: _controller,
                      onReady: () => debugPrint('Ready'),
                      bottomActions: [
                        CurrentPosition(),
                        ProgressBar(
                          isExpanded: true,
                          colors: const ProgressBarColors(
                              playedColor: Colors.red, handleColor: Colors.red),
                        ),
                        FullScreenButton(),
                        RemainingDuration(),
                      ],
                    ),
                  ),
                );
              }
            });
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

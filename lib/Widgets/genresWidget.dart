// ignore: file_names

import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/Widgets/genresMoviewidget.dart';
import 'package:flutter_movieapp/model.dart/genersListModel.dart';

class GenresWidget extends StatefulWidget {
  const GenresWidget({super.key});

  @override
  State<GenresWidget> createState() => _GenresWidgetState();
}

class _GenresWidgetState extends State<GenresWidget>
    with TickerProviderStateMixin {
  List<GenersListResult>? genersListResults;

  //late TabController _tabController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: API().fetchGeneresList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                height: 320,
                child: DefaultTabController(
                    length: snapshot.data!.length,
                    child: Scaffold(
                      backgroundColor: const Color.fromARGB(255, 21, 28, 38),
                      appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(50.0),
                        child: AppBar(
                          backgroundColor:
                              const Color.fromARGB(255, 21, 28, 38),
                          bottom: TabBar(
                            physics: const BouncingScrollPhysics(),
                            isScrollable: true,
                            indicatorColor: const Color(0xFFF4c10F),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 3.0,
                            unselectedLabelColor: Colors.grey[700],
                            labelColor: Colors.white,
                            tabs: snapshot.data!.map((geners) {
                              return Container(
                                padding: const EdgeInsets.only(
                                    bottom: 15.0, top: 10),
                                child: Text(
                                  geners.name.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      body: TabBarView(
                        physics: BouncingScrollPhysics(),
                        children: snapshot.data!.map((generes) {
                          return GenresMovieWidget(generid: generes.id);
                        }).toList(),
                      ),
                    )));
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const Text(
              'Loading',
              style: TextStyle(color: Colors.white),
            );
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_movieapp/API/API.dart';
import 'package:flutter_movieapp/model.dart/genersListModel.dart';

class GenersMoiveWidget extends StatefulWidget {
  const GenersMoiveWidget({super.key});

  @override
  State<GenersMoiveWidget> createState() => _GenersMoiveWidgetState();
}

class _GenersMoiveWidgetState extends State<GenersMoiveWidget>
    with TickerProviderStateMixin {
  List<GenersListResult>? genersListResults;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: API().fetchGeneresList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // API data will be stored as snapshot.data
            return Container(
                height: 250,
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
                              isScrollable: true,
                              indicatorColor: Colors.white,
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
                                ;
                              }).toList(),
                            ),
                          ),
                        ))));
          } else if (snapshot.hasError) {
            return Text('Error');
          } else {
            return Text('Loading');
          }
        });
  }
}

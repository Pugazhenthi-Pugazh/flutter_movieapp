// ignore: file_names
import 'package:flutter/material.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 21, 28, 38),
        // appBar: AppBar(
        //   backgroundColor: const Color.fromARGB(255, 21, 28, 38),
        //   title: const Text("Search for a movie"),
        // ),
        body: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      )),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: "Search here",
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: Colors.grey,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              fillColor: const Color.fromARGB(172, 32, 42, 56),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_movieapp/Widgets/searchResultwidget.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  final _controller = TextEditingController();
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BackButton(
                    color: Colors.white,
                  ),
                  Expanded(child: LayoutBuilder(builder: (context, constrait) {
                    final padding = (MediaQuery.of(context).size.width -
                        constrait.maxWidth);
                    return Padding(
                        padding: EdgeInsets.only(right: padding),
                        child: const Center(
                          child: Text(
                            "Search",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                        ));
                  })),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _controller,
                          onChanged: (text) {
                            setState(() {});
                          },
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              filled: true,
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: "Search..",
                              suffixIcon: _controller.text.length > 0
                                  ? IconButton(
                                      onPressed: () {
                                        _controller.clear();
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.clear,
                                          color: Colors.grey))
                                  : const Icon(
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
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String filterType = "tasks";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        shadowColor: Color(0xffdbdbdb),
        centerTitle: true,
        title: Text(
          "Tnotes",
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xff815FC0)),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 30.0),
            icon: Icon(
              Icons.account_circle,
              color: Color(0xff815FC0),
              size: 30,
            ),
            onPressed: () {},
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 110,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.check_circle_sharp,
                                      color: (filterType == "tasks")
                                          ? Color(0xff815FC0)
                                          : Color(0xff815FC0).withOpacity(0.5),
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      changeFilter("tasks");
                                    },
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 40,
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.sticky_note_2_sharp,
                                      color: (filterType == "notes")
                                          ? Color(0xff815FC0)
                                          : Color(0xff815FC0).withOpacity(0.5),
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      changeFilter("notes");
                                    },
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 65,
                        width: 65,
                        child: FittedBox(
                          child: Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: FloatingActionButton(
                              onPressed: () {
                                // Add your onPressed code here!
                              },
                              child: const Icon(
                                Icons.add,
                                size: 32.5,
                              ),
                              backgroundColor: Color(0xff815FC0),
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  changeFilter(String filter) {
    filterType = filter;
    setState(() {});
  }
}

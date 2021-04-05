import 'package:flutter/material.dart';
import 'TaskPage.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(129, 95, 192, .1),
  100: Color.fromRGBO(129, 95, 192, .2),
  200: Color.fromRGBO(129, 95, 192, .3),
  300: Color.fromRGBO(129, 95, 192, .4),
  400: Color.fromRGBO(129, 95, 192, .5),
  500: Color.fromRGBO(129, 95, 192, .6),
  600: Color.fromRGBO(129, 95, 192, .7),
  700: Color.fromRGBO(129, 95, 192, .8),
  800: Color.fromRGBO(129, 95, 192, .9),
  900: Color.fromRGBO(129, 95, 192, 1),
};

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: MaterialColor(0xff815FC0, color),
          fontFamily: 'avenir'),
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
                                openTaskPage();
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

  void openTaskPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TaskPage()));
  }
}

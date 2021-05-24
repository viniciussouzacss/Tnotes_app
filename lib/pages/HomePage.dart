import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tnotes_app/pages/AuthPage.dart';
import 'package:tnotes_app/provider/GoogleSignIn.dart';
import 'package:tnotes_app/pages/NewNotePage.dart';
import 'package:tnotes_app/pages/NewTaskPage.dart';
import 'NotePage.dart';
import 'TaskPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);

              if (provider.isSigningIn) {
                return buildLoading();
              } else if (snapshot.hasData) {
                return homePage();
              } else {
                return AuthPage();
              }
            },
          ),
        ),
      );

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          //CustomPaint(painter: BackgroundPainter()),
          Center(child: CircularProgressIndicator()),
        ],
      );
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final user = FirebaseAuth.instance.currentUser;
  PageController _pageController = PageController();

  var taskPage = TaskPage();
  var notePage = NotePage();

  double currentPage = 0;
  String filterType = "tasks";

  _updateTaskPage() {
    taskPage.getState().updateTaskList();
  }

  _updateNotePage() {
    notePage.getState().updateNoteList();
  }

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;

        if (currentPage == 0) {
          filterType = "tasks";
        } else {
          filterType = "notes";
        }
      });
    });

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
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
            /*onPressed: (){
              showDialog(context: context,
                  builder: (BuildContext context){
                    return CustomDialogBox(
                      title: user.displayName,
                      descriptions: user.email,
                      text: user.photoURL,
                    );
                  }
              );
            },*/
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
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: <Widget>[taskPage, notePage],
                ),
              ),
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
                                      _pageController.previousPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.bounceInOut);
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
                                      _pageController.nextPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.bounceInOut);
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
                              onPressed: (filterType == "tasks")
                                  ? () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => NewTaskPage(
                                            updateTaskList: _updateTaskPage,
                                          ),
                                        ),
                                      )
                                  : () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => NewNotePage(
                                            updateNoteList: _updateNotePage,
                                          ),
                                        ),
                                      ),
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

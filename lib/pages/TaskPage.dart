import 'package:flutter/material.dart';
import 'HomePage.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Widget _buildItemTask(int index) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Task Title'),
              subtitle: Text('April 4, 2020 - High'),
              trailing: Checkbox(
                onChanged: (value) {
                  print(value);
                },
                activeColor: Color(0xff815FC0),
                value: true,
              ),
            ),
            Divider(
              color: Colors.black26,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        shadowColor: Color(0xffdbdbdb),
        centerTitle: true,
        title: Text(
          "Work Tasks",
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xff815FC0)),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xff815FC0),
                size: 26,
              ),
              onPressed: () {
                returnHomePage();
              },
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    '1 of 10',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          }
          return _buildItemTask(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff815FC0),
        child: Icon(Icons.add),
        onPressed: () => print('Navigate to add task page'),
      ),
    );
  }

  void returnHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tnotes_app/helpers/Database_helper.dart';
import 'package:tnotes_app/models/Task_model.dart';
import 'HomePage.dart';
import 'NewTaskPage.dart';

class TaskPage extends StatefulWidget {
  /*@override
  TaskPageState createState() => TaskPageState();*/

  TaskPageState taskPageState;

  @override
  TaskPageState createState() {
    taskPageState = TaskPageState();
    return taskPageState;
  }

  getState() => taskPageState;
}

class TaskPageState extends State<TaskPage> {
  Future<List<Task>> _taskList;
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  void initState() {
    super.initState();
    updateTaskList();
  }

  updateTaskList() {
    setState(() {
      _taskList = DatabaseHelper.instance.getTaskList();
    });
  }

  Widget _buildItemTask(Task task) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  fontSize: 18.0,
                  decoration: task.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough,
                ),
              ),
              subtitle: Text(
                '${_dateFormatter.format(task.date)} - ${task.priority}',
                style: TextStyle(
                  fontSize: 15.0,
                  decoration: task.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough,
                ),
              ),
              trailing: Checkbox(
                onChanged: (value) {
                  task.status = value ? 1 : 0;
                  DatabaseHelper.instance.updateTask(task);
                  updateTaskList();
                },
                activeColor: Color(0xff815FC0),
                value: task.status == 1 ? true : false,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewTaskPage(
                    updateTaskList: updateTaskList,
                    task: task,
                  ),
                ),
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
      backgroundColor: Color(0xffF1F2F6),
      /* appBar: AppBar(
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
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 30.0),
            icon: Icon(
              Icons.edit_rounded,
              color: Color(0xff815FC0),
              size: 25,
            ),
            onPressed: () {
              // Edit Task Name
            },
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
          )
        ],
      ),*/
      body: FutureBuilder(
        future: _taskList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final int completedTaskCount = snapshot.data
              .where((Task task) => task.status == 1)
              .toList()
              .length;

          return ListView.builder(
            itemCount: 1 + snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        '$completedTaskCount of ${snapshot.data.length}',
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
              return _buildItemTask(snapshot.data[index - 1]);
            },
          );
        },
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff815FC0),
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewTaskPage(
                updateTaskList: updateTaskList,
              ),
            ),),
      ),*/
    );
  }

  void returnHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}

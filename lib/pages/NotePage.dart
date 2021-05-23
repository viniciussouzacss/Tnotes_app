import 'package:flutter/material.dart';
import 'package:tnotes_app/helpers/Database_helper.dart';
import 'package:tnotes_app/models/Note_model.dart';

import 'NewNotePage.dart';

class NotePage extends StatefulWidget {
  NotePageState notePageState;

  @override
  NotePageState createState() {
    notePageState = NotePageState();
    return notePageState;
  }

  getState() => notePageState;
}

class NotePageState extends State<NotePage> {
  Future<List<Note>> _noteList;

  @override
  void initState() {
    super.initState();
    updateNoteList();
  }

  updateNoteList() {
    setState(() {
      _noteList = DatabaseHelper.instance.getNoteList();
    });
  }

  Widget _buildItemNote(Note note) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 14.0),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(15.0),
                dense:true,
                title: Text(
                  note.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    decoration: TextDecoration.none,
                  ),
                ),
                subtitle: note.text.length < 140
                    ? Text(
                  note.text,
                  style: TextStyle(
                    fontSize: 15.0,
                    decoration: TextDecoration.none,
                  ),
                )
                    : Text(
                  note.text.substring(1, 140) + '...',
                  style: TextStyle(
                    fontSize: 15.0,
                    decoration: TextDecoration.none,
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewNotePage(
                      updateNoteList: updateNoteList,
                      note: note,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      body: FutureBuilder(
        future: _noteList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildItemNote(snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}

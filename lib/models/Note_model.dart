class Note {
  int id;
  String title;
  String text;

  Note({this.title, this.text});

  Note.withId({this.id, this.title, this.text});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['text'] = text;
    return map;
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note.withId(
      id: map['id'],
      title: map['title'],
      text: map['text'],
    );
  }
}

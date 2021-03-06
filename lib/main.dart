import 'package:flutter/material.dart';
import 'package:flutter_note_app/services/notes_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }

}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _titleController = TextEditingController();

  final noteServices=NotesServices();

  void showBottomModal(BuildContext context){
    showModalBottomSheet(context: context, builder: (Contxt){
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom+10),
          width: double.infinity,
          color: Colors.white70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                    ),
                    controller: _titleController,
                  )
              ),
              FlatButton(
                  onPressed: (){
                    setState(() {
                      noteServices.addNote(_titleController.text);
                    });
                    Navigator.of(context).pop();
                    _titleController.clear();
                  },
                  child: Text("Save Note"))
            ],
          ),
        ),
      );
    });
  }

  void showUpdatePopup(String noteId,BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          _titleController.text=noteServices.getNotes.firstWhere((element) => element.id==noteId).title;
          return AlertDialog(
            title: Text('Edit note!'),
            content: TextField(
              controller: _titleController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _titleController.clear();
                },
              ),
              FlatButton(
                child: new Text('UPDATE'),
                onPressed: () {
                  setState(() {
                    noteServices.updateTodo(noteId, _titleController.text);
                  });
                  Navigator.of(context).pop();
                  _titleController.clear();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Note Taking",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 25
        ),
        ),
      ),
      body: ListView(
        children: noteServices.getNotes.map(
              (item) =>Card(
                elevation: 5,
                child: ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.createdAt),
                  trailing:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => showUpdatePopup(item.id,context)),
                      IconButton(icon: Icon(Icons.delete_forever,color: Colors.red,), onPressed: (){
                        setState(() {
                          noteServices.deleteNotes(item.id);
                        });
                      })
                    ],
                  ) ,
                ),
              )
        ).toList(),

      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        onPressed: ()=>showBottomModal(context),
        label: Text("Add"),
      ),
    );
  }
}


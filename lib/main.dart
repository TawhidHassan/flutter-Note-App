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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Taking"),
      ),
      body: ListView(
        children: noteServices.getNotes.map(
              (item) =>ListTile(
                title: Text(item.title),
                subtitle: Text(item.createdAt),
                trailing:IconButton(icon: Icon(Icons.delete_forever,color: Colors.red,), onPressed: (){
                  setState(() {
                    noteServices.deleteNotes(item.id);
                  });
                }) ,
              )
        ).toList(),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showBottomModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}


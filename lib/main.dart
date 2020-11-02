import 'package:flutter/material.dart';

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

class Home extends StatelessWidget {
  TextEditingController _titleController = TextEditingController();

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
                  onPressed: (){},
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
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showBottomModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}


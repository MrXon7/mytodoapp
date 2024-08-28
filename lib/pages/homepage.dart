import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mytodo/data/database.dart';
import 'package:mytodo/utils/todo_tile.dart';

import '../utils/dialog_box.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // hive box ni chaqirish
  final _mybox=Hive.box('mybox');
  ToDoDatabase db=ToDoDatabase();

  @override
  void initState() {
    // TODO: implement initState
    // ilova birinchi aochilganda defoilt malumotlarni olish
    if(_mybox.get('TODOLIST')==null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();


  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void savaNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDataBase();
    Navigator.of(context).pop();
  }

  void createTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: savaNewTask,
            onCancel: () {
              _controller.clear();
              Navigator.of(context).pop();},
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: Center(
            child: Text(
          'TO DO',
          style: TextStyle(color: Colors.white),
        )),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: createTask,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskname: db.toDoList[index][0],
            taskComplated: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value!, index),
            deleteFunc: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}

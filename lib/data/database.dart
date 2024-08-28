import 'package:hive/hive.dart';

class ToDoDatabase{
  List toDoList=[];

  final _mybox=Hive.box('mybox');

  void createInitialData(){
    toDoList=[
      ['Make Tutorial', false]
    ];
  }

  void loadData(){
    toDoList=_mybox.get("TODOLIST");
  }

  void updateDataBase(){
    _mybox.put('TODOLIST', toDoList);
  }
}
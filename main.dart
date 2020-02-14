import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

//Colors
const bgColor = const Color(0xFFF5BCBA);
const appBarColor = const Color(0xFF01CBC6);
const buttonColor = const Color(0xFFBB2CD9);
//running the app state
class TodoApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Todo List",
      home: TodoList(),
    );
  }
}

//creating the app state
class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

//defining the state of the app
class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  //called when the "add button is pressed"
  void _addTodoItem(String task) {
    if(task.length > 0){
      setState(() {
        _todoItems.add(task);
      });
    }
  }

  //removing item from list
  void _removeTodoItem(int index){
    setState(() => _todoItems.removeAt(index));
  }
  
  //prompting before removing a item from list
  void _promptRemoveTodoList(int index){
    showDialog(
        context: context,
      builder: (BuildContext context){
          return new AlertDialog(
            title:  new Text("Mark'${_todoItems[index]}'as done ?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("CANCEL"),
                onPressed: () => Navigator.of(context).pop()
              ),
              new FlatButton(
               child: new Text('Mark as done'),
                onPressed: (){
                 _removeTodoItem(index);
                 Navigator.of(context).pop();
                }
              )
            ],
          );
      }
    );
  }

  Widget _buildTodoList(){
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index],index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText,int index){
    return new ListTile(
      title: new Text(todoText),
      onTap: () =>_promptRemoveTodoList(index),
    );
  }
  //Building all the items  to the list
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: bgColor,
      appBar: new AppBar(
        backgroundColor: appBarColor,
        title: Center(
          child: new Text("Todo List"),
        ),
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: "Add Task",
        backgroundColor: buttonColor,
        child: new Icon(Icons.add),
      )
    );
  }

  void _pushAddTodoScreen(){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context){
          return new Scaffold(
            backgroundColor: bgColor,
            appBar: new AppBar(
              backgroundColor: appBarColor,
              title: new Text("Add a new Task"),
            ),
            body: new TextField(
              autofocus: true,
              onSubmitted: (task){
                _addTodoItem(task);
                Navigator.pop(context);
              },
              decoration: new InputDecoration(
                hintText: "Enter a work... to do",
                contentPadding: const EdgeInsets.all(20)
              ),
            ),
          );
        }
      )
    );
  }
}

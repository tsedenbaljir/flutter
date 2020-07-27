import 'package:flutter/material.dart';
import 'TaskModel.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key key}) : super(key: key);
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final textController = TextEditingController();

  List<TaskModel> tasks = [];

  TaskModel currentTask;

  @override
  Widget build(BuildContext context) {
    final TodoHelper _todoHelper = TodoHelper();
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text("Show All Task"),
              onPressed: () async {
                List<TaskModel> list = await _todoHelper.getAllTask();

                setState(() {
                  tasks = list;
                });
              },
              color: Colors.orange[400],
              textColor: Colors.white,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text("${tasks[index].id}"),
                    title: Text("${tasks[index].name}"),
                    trailing: FlatButton(
                      child: Text("Delete"),
                      onPressed: () {
                        _todoHelper.deleteTask(tasks[index].id);
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: tasks.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

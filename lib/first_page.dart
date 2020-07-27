import 'package:flutter/material.dart';
import 'TaskModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            TextField(
              controller: textController,
            ),
            FlatButton(
              child: Text("Insert"),
              onPressed: () {
                currentTask = TaskModel(name: textController.text);
                _todoHelper.insertTask(currentTask);
              },
              color: Colors.blue,
              textColor: Colors.white,
            ),
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

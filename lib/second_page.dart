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
              child: Text("Бүх зээлийг харах"),
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
                  return Card(
                    elevation: 1,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                      ),
                                      Text(
                                        "Мөнгө ₮:",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w200),
                                      ),
                                      Text(
                                        "Нэр:",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w200),
                                      ),
                                      Text(
                                        "Ажил:",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                      ),
                                      Text(
                                        tasks[index].rent + "₮",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        tasks[index].name,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        tasks[index].job,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        Column(
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                "Устгах",
                                style: TextStyle(fontSize: 10.0),
                              ),
                              onPressed: () {
                                _todoHelper.deleteTask(tasks[index].id);
                              },
                              color: Colors.red[700],
                              textColor: Colors.white,
                            ),
                            Text(
                              tasks[index].date.toString().substring(0, 10),
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ],
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'TaskModel.dart';

class First_page extends StatefulWidget {
  First_page({Key key}) : super(key: key);
  @override
  _First_pageState createState() => _First_pageState();
}

class _First_pageState extends State<First_page> {
  DateTime _dateTime;

  final name = TextEditingController();
  final job = TextEditingController();
  final rent = TextEditingController();

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
            Text("Зээл бүртгэх талбар"),
            TextField(
              controller: name,
              // obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Зээлж буй хүний нэр',
              ),
            ),
            TextField(
              controller: job,
              // obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Эрхэлдэг ажил, алба',
              ),
            ),
            TextField(
              keyboardType: TextInputType.datetime,
              // obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Хэдэн төрөг зээлдэж байгаа',
              ),
              // validator: (String value) {
              //   if (value.isEmpty) {
              //     return 'Phone number (+x xxx-xxx-xxxx)';
              //   }
              //   return null;
              // },
              controller: rent,
            ),
            FlatButton(
              child: Text("Хадгалах"),
              onPressed: () {
                currentTask = TaskModel(
                  name: name.text,
                  job: job.text,
                  rent: rent.text,
                );
                _todoHelper.insertTask(currentTask);
              },
              color: Colors.blue,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'TaskModel.dart';

class Last_page extends StatefulWidget {
  Last_page({Key key}) : super(key: key);
  @override
  _Last_pageState createState() => _Last_pageState();
}

class _Last_pageState extends State<Last_page> {
  final textController = TextEditingController();

  List<TaskModel> tasks = [];

  TaskModel currentTask;

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    parsenumber(String before, String now) {
      var a = int.parse(before);
      var b = int.parse(now);
      a -= b;
      return a;
    }

    final TodoHelper _todoHelper = TodoHelper();
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      body: Container(
        padding: EdgeInsets.only(top: 30),
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
                                        "Ойрын хүн:",
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
                                        tasks[index].most_phone,
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
                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "Авсан: ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  "Хэтрэлт: ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  tasks[index]
                                          .date
                                          .toString()
                                          .substring(0, 10) +
                                      "  ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  parsenumber(
                                          tasks[index]
                                              .date
                                              .toString()
                                              .substring(8, 10),
                                          date.toString().substring(8, 10))
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
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

// ////////////////////////
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'TaskModel.dart';

// class Last_page extends StatefulWidget {
//   Last_page({Key key}) : super(key: key);
//   @override
//   _Last_pageState createState() => _Last_pageState();
// }

// class _Last_pageState extends State<Last_page> {
//   @override
//   Widget eachvideo(String title) {
//     return Container(
//       padding: EdgeInsets.only(top: 32),
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 5.0,
//           ),
//           Container(
//             color: Colors.black12,
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.red,
//                 radius: 10.0,
//               ),
//               title: Text(
//                 "$title",
//                 textAlign: TextAlign.start,
//               ),
//               subtitle: Text(
//                 "Tsedenbaljir is video - 200 Views - 1 Hour",
//               ),
//               trailing: Icon(
//                 Icons.more_vert,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.black12,
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             eachvideo("title1"),
//             eachvideo("title2"),
//             eachvideo("title3"),
//             eachvideo("title4"),
//           ],
//         ),
//       ),
//     );
//   }
// }

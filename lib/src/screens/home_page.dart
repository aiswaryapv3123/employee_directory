import 'dart:convert';

import 'package:employee_directory/src/widgets/employee_tile.dart';
import 'package:employee_directory/src/screens/employee_details_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box box;
  List<dynamic> dataList = [];

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('data');
    return;
  }

  Future<bool> getData() async {
    await openBox();
    String url = "http://www.mocky.io/v2/5d565297300000680030a986";
    try {
      var response = await http.get(url);
      var data = jsonDecode(response.body);

      await addDataToDb(data);
    } catch (SocketException) {
      print("No internet");
    }

    var items = box.toMap().values.toList();
    if (items.isEmpty) {
      dataList.add('Empty');
    } else {
      dataList.add(items);
    }
    return Future.value(true);
  }

  Future addDataToDb(data) async {
    await box.clear();
    for (var d in data) {
      box.add(d);
    }
  }

  @override
  void initState() {
    openBox();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Row(
              children: [
                Icon(Icons.format_list_bulleted, color: Colors.teal),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(
                  "Employee Directory",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {}, child: Icon(Icons.search, color: Colors.grey))
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.09,
          ),
          child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (dataList.contains('Empty')) {
                  return Text("No data available");
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Employee's List",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                EmployeeTile(
                                    name:
                                    "Name",
                                    // dataList[index]['name'],
                                    companyName: "Company Name",
                                // dataList[index]['company['name'],
                                    image: null,
                                // dataList[index]['profile_image'],
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EmployeeDetailsPage(
                                                    name: "Name",
                                                    // dataList[index]['name'],
                                                    username: "username",
                                                    // dataList[index]
                                                    //     ['username'],
                                                    image: null,
                                                    // dataList[index]
                                                    //     ['profile_image'],
                                                    website: "www.abc.com",
                                                    // dataList[index]
                                                    //     ['website'],
                                                    companyName: "Company name",
                                                  // dataList[index]
                                                  //       ['company']['name'],
                                                    catchPhrase: "catchPhrase"
                                                    // dataList[index]
                                                    //     ['company']['catchPhrase'],
                                                  )));
                                    }),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.02,
                                ),
                              ],
                            );
                            // Container(
                            //   width: MediaQuery.of(context).size.width,
                            //   child: Row(children: [
                            //     Container(
                            //       width:
                            //           MediaQuery.of(context).size.width *
                            //               0.07,
                            //       height:
                            //           MediaQuery.of(context).size.width *
                            //               0.07,
                            //       color: Colors.red,
                            //     ),
                            //     Text(dataList[index]['name'])
                            //   ],),);
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                    ],
                  );
                }
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.width * .2,
                  child: Center(
                    child: SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transisi/ui/CreateEmployee.dart';
import 'package:transisi/ui/detail_page.dart';
import 'dart:convert';
import 'dart:async';
class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  Map data;
  List userData = [];

  Map datadetail;
  dynamic userDataDetail;

  Future getData() async {
    http.Response response = await http
        .get("https://reqres.in/api/users");
    data = jsonDecode(response.body);
    print(data);
    setState(() {
      userData = data["data"];
      print(userData);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
//    getDataDetail(userDataDetail);
  }

  @override
  Widget build(BuildContext context) {
//    getDataDetail(userDataDetail);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Home",
          style: new TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateEmployee()));
          }),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.8),
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext contsext, int index) {
          //getDataDetail(userDataDetail);
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  new Hero(
                    tag: userData[index]['last_name'],
                    child: new Material(
                      child: new InkWell(
                        onTap: () =>
                            Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => new DetailPage(
                                id: userData[index]['id'].toString(),
                                firstname: userData[index]['first_name'],
                                lastname: userData[index]['last_name'],
                                email: userData[index]['email'],
                                avatar: userData[index]["avatar"],

                              ),
                            )),
                        child: Image.network(
                          (userData[index]["avatar"]),
                          height: 125.0,
                          width: 125.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0,),
                  new Text(
                    "${userData[index]["first_name"]} ${userData[index]["last_name"]}",
                    style:
                    TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
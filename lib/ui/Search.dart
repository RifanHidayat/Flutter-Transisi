
// http://monitorsibi.000webhostapp.com/RestFullApi/getData
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transisi/model/ModelEmployee.dart';
import 'package:transisi/ui/detail_page.dart';



class SearchScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
Map data;
List userData = [];
class _HomePageState extends State<SearchScreen> {

  List<Datum> _ModelList = List<Datum>();
  List<Datum> _ModelListTampil = List<Datum>();


  Future<List<Datum>> fetchNotes() async {
    var url = 'https://reqres.in/api/users';
    var response = await http.get(url);
    data=jsonDecode(response.body);
    userData=data["data"];
    var notes = List<Datum>();

    if (response.statusCode == 200) {
      var notesJson = userData;
      for (var noteJson in notesJson) {
        notes.add(Datum.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _ModelList.addAll(value);
        _ModelListTampil = _ModelList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cari Employee'),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(


          itemBuilder: (context, index) {
            return index == 0 ?
            _searchBar() :
            _listItem(index-1);
          },
          itemCount: _ModelList.length+1,
        )
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(

        decoration: InputDecoration(

            hintText: 'Search...'
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _ModelListTampil = _ModelList.where((note) {
              var noteTitle = note.firstName.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return InkWell(
      onTap: (){
        final nDataList = _ModelList[index];

        Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new DetailPage(
            id: userData[index]['id'].toString(),
            firstname: userData[index]['first_name'],
            lastname: userData[index]['last_name'],
            email: userData[index]['email'],
            avatar: userData[index]["avatar"],

          ),
        ));
      },

      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _ModelListTampil[index].firstName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black),
              ),

              Text(
                _ModelListTampil[index].email,
                style: TextStyle(
                    color: Colors.grey.shade600
                ),
              ),
            ],
          ),
        ),


      ),

    );

  }
}


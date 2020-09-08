import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class DetailPage extends StatefulWidget {
  DetailPage({this.id,this.firstname, this.lastname, this.email,this.avatar});

  final String avatar;
  String id,firstname,lastname,email;


  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          new Container(
              height: 250.0,
              child: new Hero(
                tag: widget.firstname,
                child: new Material(
                  child: new InkWell(
                    /*child: Image.network(
                      (userData[index]["strMealThumb"]),
                      height: 200.0,
                      width: 150.0,
                    ),*/
                    child: Image.network(
                      "${widget.avatar}",
                      height: 120,
                      width: 200,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              )),
          new PartName(
            nama: "${widget.firstname} ${widget.lastname}",
          ),

          new Email(
            email: widget.email,
          ),
        ],
      ),
    );
  }
}



class PartName extends StatelessWidget {
  PartName({this.nama});
  final String nama;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  nama,
                  style: new TextStyle(fontSize: 20.0, color: Colors.blue),
                ),

              ],
            ),
          ),
          new Row(
            children: <Widget>[
              new Icon(
                Icons.star,
                size: 30.0,
                color: Colors.red,
              ),
              new Text(
                "12",
                style: new TextStyle(fontSize: 18.0),
              )
            ],
          )
        ],
      ),
    );
  }
}





class Email extends StatelessWidget {
  Email({this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Container(
        padding: new EdgeInsets.all(10.0),

        child: new Card(
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              new Icon(Icons.email,
//                color: Colors.blue,
//              ),
//              Text("$email")
//            ],
//          ),
          child: new Padding(

            padding: const EdgeInsets.all(15.0),
            child: Row(

              children: <Widget>[
                new Icon(Icons.email,
                color: Colors.blue,
                  size: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
               child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   new Text(
                  "$email",
                  style: new TextStyle(fontSize: 18.0,
                  color: Colors.black
                  ),

            ),
                   new Text(
                     "E-mail",
                     style: new TextStyle(fontSize: 15.0,
                       color: Colors.black54
                     ),

                   ),
                 ],
               ),
              )
              ],
            ),
//            child: new Text(
//              "$email",
//              style: new TextStyle(fontSize: 18.0),
//              textAlign: TextAlign.justify,
//            ),
          ),
        ),
      ),
    );
  }
}
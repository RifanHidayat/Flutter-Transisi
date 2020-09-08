import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEmployee extends StatefulWidget {
  @override
  _CreateEmployeeState createState() => _CreateEmployeeState();
}
class _CreateEmployeeState extends State<CreateEmployee> {

  Future<File> imageFile;
  final GlobalKey<ScaffoldState> scaffoldState =
  new GlobalKey<ScaffoldState>();
  TextEditingController Cfirst_name = new TextEditingController();
  TextEditingController Clast_name = new TextEditingController();
  TextEditingController Cemail = new TextEditingController();
  String base64;
  // ignore: non_constant_identifier_names
  String first_name,last_name,email;


  void addData() async {
    final responseData = await
    http.post("https://reqres.in/api/users",
        body: {"first_name" : Cfirst_name.text, "last_name" : Clast_name.text,"email":Cemail.text}
    );

    final data = jsonDecode(responseData.body);
    var id=data['id'];
    var tglBuat=data['createdAt'];
    if (id!=null){
      // ignore: unnecessary_statements
      Cfirst_name.text="";
      Clast_name.text="";
      Cemail.text="";
      showSnakeBar(scaffoldState,
          'Data Berhasil ditambahkan pada $tglBuat');
    }else{
      showSnakeBar(scaffoldState,
          'data tidak berhasil ditambahkan');

    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldState,
      appBar: new AppBar(
        title: Text('employee'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
     child: Column(
       children: <Widget>[

         Container(
           width: 200,
           height: 200,
           child: Column(
             children: <Widget>[
               SizedBox(height: 10,),
               tampilPhoto(),

             ],
           ),
         ),
         SizedBox(height: 10,),
         new RaisedButton(
           child: new Text("pilih Foto",
               style: TextStyle(color: Colors.white)
           ),
           color: Colors.blue,
           onPressed: (){
             pilihgalerry(ImageSource.gallery);

           },
         ),

         SizedBox(height: 20,),
         new TextField(
                    controller: Cfirst_name,
                    decoration: new InputDecoration(
                    hintText: "Masukan first name",
                    labelText: "First Name",
                    border: new OutlineInputBorder(
                     borderRadius: new BorderRadius.circular(20.0)))),
                    SizedBox(height: 20,),
                  new TextField(
                      controller: Clast_name,
                  decoration: new InputDecoration(
                  hintText: "Masukan last name",
                  labelText: "Last Name",
                  border: new OutlineInputBorder(
                     borderRadius: new BorderRadius.circular(20.0)))),

         SizedBox(height: 20,),

         new TextField(
             controller: Cemail,
             decoration: new InputDecoration(
                 prefixIcon: Icon(
                   Icons.email,
                   color: Colors.blue,
                 ),
                 hintText: "Masukan Email",
                 labelText: "Email",
                 border: new OutlineInputBorder(borderRadius: new
                 BorderRadius.circular(20.0)))),
         new Padding(padding: new EdgeInsets.all(5.0)),

         new Padding(padding: const EdgeInsets.all(5.0)),
         new RaisedButton(
           child: new Text("Simpan Data",
               style: TextStyle(color: Colors.white)
           ),

           color: Colors.blue,
           onPressed: (){
             email=Cemail.text;
             first_name=Cfirst_name.text;
             last_name=Clast_name.text;
            if(first_name.isEmpty) {
             showSnakeBar(scaffoldState, 'First Name tidak boleh kosong');
             }else if (first_name.contains(" ")){
               showSnakeBar(scaffoldState, 'First Name tidak boleh mengandung spasi');
             }else if (first_name.length>10){
               showSnakeBar(scaffoldState, 'Firstg Name tidak boleh lebih dari 10 karakter');
             }else if (last_name.isEmpty){
               showSnakeBar(scaffoldState, 'Firts Name tidak boleh kosong');
             } else if (last_name.contains(" ")){
               showSnakeBar(scaffoldState, 'Last Name tidak boleh mengandung spasi');
             }else if (last_name.length>10){
               showSnakeBar(scaffoldState, 'last Name tidak boleh lebih dari 10 karakter');
             } else if (!email.contains("@")){
               showSnakeBar(scaffoldState, 'Email tidak valid');
             }else{
               addData();
             }



           },
         )
       ],
     ),


      ),
    );
  }
  void initState() {
    super.initState();


  }


  void showSnakeBar(scaffoldState, String _pesan) {
    scaffoldState.currentState.showSnackBar(
      new SnackBar(
        content: Text(_pesan),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      ),
    );
  }

  Widget tampilPhoto(){
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot){
        if (snapshot.connectionState==ConnectionState.done && snapshot.data!=null)
        {//mengambil data image
        base64=base64Encode(snapshot.data.readAsBytesSync());

        //menampilkan image
          return Image.file(
            snapshot.data,
            width: 180,
              height: 180,
            fit: BoxFit.cover,


          );

        }else if (snapshot.error!=null) {
          return const Text("data",
          textAlign: TextAlign.center,
          );

        }else{
          return const Text("no image selected",
            textAlign: TextAlign.center,
          );

        }

      },
    );
  }
  pilihgalerry(ImageSource source){
    setState(() {
      imageFile=ImagePicker.pickImage(source: source) as Future<File>;
    });

  }
}

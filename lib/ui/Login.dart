import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transisi/ui/BottomBarMenu.dart';

import 'package:transisi/utilities/constants.dart';



class LoginScreen extends StatefulWidget{

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum statusLogin { signIn, notSignIn }
class _LoginScreenState extends State<LoginScreen>{


  statusLogin _loginStatus = statusLogin.notSignIn;

  var cEmail= new TextEditingController();
  var cPassword = new TextEditingController();
  var email = '';
  var password = '';
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child:TextFormField(
            controller: cEmail,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),

              hintText: 'contoh@email.com',
              hintStyle: kHintTextStyle,

            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: new TextField(
            controller: cPassword,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Masukan Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }





  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          email=cEmail.text;
          password=cPassword.text;
          if (!email.contains("@")){
            showSnakeBar(scaffoldState, 'Email tidak valide');
          }else if (password.length<4 || password.length>15 ){
            showSnakeBar(scaffoldState, 'Minimal password 4 karakter dan Maximal password 15 karakter');


          }else{

            submitDataLogin(email,password);


          }

        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
          key: scaffoldState,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF73AEF5),
                          Color(0xFF61A4F1),
                          Color(0xFF478DE0),
                          Color(0xFF398AE5),
                        ],
                        stops: [0.1, 0.4, 0.7, 0.9],
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,

                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 50.0,
                      ),


                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 100.0),
                          _buildEmailTF(),
                          SizedBox(
                            height: 30.0,
                          ),
                          _buildPasswordTF(),

                          //_buildRememberMeCheckbox(),
                          _buildLoginBtn(),




                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
        break;
      case statusLogin.signIn:
        return PageHomeBottomMenu();
        break;
    }
  }



  final GlobalKey<ScaffoldState> scaffoldState =
  new GlobalKey<ScaffoldState>();

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
// method untuk soimpan share pref
  // ignore: non_constant_identifier_names
  saveDataPref(String EmailUser,String TokenUser,int value) async {
    SharedPreferences sharedPreferences = await
    SharedPreferences.getInstance();
    setState(() {

      sharedPreferences.setString("email", EmailUser);
      sharedPreferences.setString("token", TokenUser);
      sharedPreferences.setInt("value", value);


    });
  }
  getDataLogin(String email) async{

  }
  submitDataLogin(String email,String password) async {
    confirm();
    final responseData = await
    http.post("https://reqres.in/api/login", body: {
      "email": email,
      "password": password,
    });

    final data = jsonDecode(responseData.body);

    String token = data['token'];
    String erorr = data['error'];


      if (erorr=="user not found"){
        Navigator.pop(context);
        showSnakeBar(scaffoldState,
            '$erorr');
      }else{

        _loginStatus = statusLogin.signIn;
        Navigator.pop(context);
      saveDataPref(cEmail.text,token,1);
      }


  }

  getDataPref() async {
    SharedPreferences sharedPreferences = await
    SharedPreferences.getInstance();
    setState(() {

      int nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;

    });
  }
  @override


  void initState() {
    getDataPref();
    super.initState();
  }
  void confirm() {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(

            content:Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Loading...."),
                  SizedBox(height: 30,),
                  CircularProgressIndicator(

                    backgroundColor: Colors.blue[250],

                  ),
                ],
              ),



            )

          );

        }
    );


  }

}


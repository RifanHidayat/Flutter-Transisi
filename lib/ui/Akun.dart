import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transisi/ui/BottomBarMenu.dart';
import 'package:transisi/ui/Login.dart';
class AkunScreen extends StatefulWidget {
  @override
  _AkunScreenState createState() => _AkunScreenState();
}
enum statusLogin { signIn, notSignIn }
class _AkunScreenState extends State<AkunScreen> {
  String token="";
  statusLogin _loginStatus = statusLogin.signIn;
  final GlobalKey<ScaffoldState> scaffoldState =
  new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    switch(_loginStatus) {
      case statusLogin.signIn:
    return Scaffold(
      key: scaffoldState,
     appBar: AppBar(
       title: Text("Akun"),
       backgroundColor: Colors.blue,
     ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 50,),
            Text("Token:$token",
              style: TextStyle(
                fontSize: 20
              ),

            ),
            SizedBox(height: 100,),
            _buildLogout()
          ],

        ),
      ),

);
    break;
      case statusLogin.notSignIn:
       return LoginScreen();

        break;
  }
  }
  getDataPref() async {
    SharedPreferences sharedPreferences = await
    SharedPreferences.getInstance();
    setState(() {
      token= sharedPreferences.getString("token");
      int nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;



    });
  }
  logout() async {
    SharedPreferences sharedPreferences = await
    SharedPreferences.getInstance();
    setState(() {
    sharedPreferences.clear();
    _loginStatus = statusLogin.notSignIn;


    });
  }
  void initState() {
    getDataPref();
    super.initState();
  }
  Widget _buildLogout() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0,horizontal: 10),
      width: double.infinity,
      child: RaisedButton(

        elevation: 5.0,
        onPressed: ()  {
      logout();

        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.white,
        child: Text(
          'Logout',
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
}

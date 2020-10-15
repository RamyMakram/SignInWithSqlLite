import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:signin/db.dart';
import 'package:signin/home.dart';
import 'package:signin/reg.dart';
import 'package:sqflite/sqflite.dart';

class login extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Main(title: 'Login'),
      ),
    );
  }
}

class Main extends StatefulWidget {
  Main({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Main> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    Load();
    super.initState();
  }

  Future<void> Load() async {
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Text(
                "مرحباً",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextFormField(
                decoration: InputDecoration(labelText: 'أسم المستخدم'),
                textDirection: TextDirection.rtl,
                onChanged: (String val) {
                  setState(() {
                    _username = val;
                  });
                }),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 15),
            child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter
                      .digitsOnly
                ],
                decoration: InputDecoration(labelText: 'كلمة المرور'),
                onChanged: (String val) {
                  setState(() {
                    _password = val;
                  });
                }),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        "تسجيل جديد",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      color: Colors.blueAccent,
                    ),
                    width: 100,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: RaisedButton(
                      onPressed: () async {
                        var _true=await Db.db.login(_username,int.parse( _password));
                        if(_true){
                          scaffoldKey.currentState.showSnackBar(new SnackBar(
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 100),
                              content: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  "اهلا بيك",
                                  textAlign: TextAlign.center,
                                ),
                              )));
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home()),
                                (Route<dynamic> route) => false,
                          );
                        }
                        else{
                          scaffoldKey.currentState.showSnackBar(new SnackBar(
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 100),
                              content: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  "لا يوجد بيانات مطابقه الرجاء الاشتراك",
                                  textAlign: TextAlign.center,
                                ),
                              )));
                        }

                      },
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                      color: Colors.amberAccent,
                    ),
                    width: 200,
                  )
                ],
              ))
        ],
      ),
    );
  }
}

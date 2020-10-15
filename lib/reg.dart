import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart' as dateformater;
import 'package:signin/db.dart';
import 'package:signin/login.dart';
import 'package:signin/user.dart';
import 'dart:core';

import 'package:sqflite/sqflite.dart';

class Register extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Main(title: 'Register'),
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
  @override
  void dispose() {
    super.dispose();
  }

  String _pass = "", _username = "", _email = "";
  var date_to = DateTime.now();
  var formatter = new dateformater.DateFormat('yyyy-MM-dd');

  var dateformated_to = "اختيار وقت";

  String ddvalue = "ذكر";
  double _height = 150, _weight = 70;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
                padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Text(
                  "تسجيل مستخدم",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                            child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'أسم المستخدم'),
                                textDirection: TextDirection.rtl,
                                onChanged: (String val) {
                                  setState(() {
                                    _username = val;
                                  });
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                            child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'البريد الالكتروني'),
                                textDirection: TextDirection.rtl,
                                onChanged: (String val) {
                                  setState(() {
                                    _email = val;
                                  });
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                decoration:
                                    InputDecoration(labelText: 'كلمة المرور'),
                                textDirection: TextDirection.rtl,
                                onChanged: (String val) {
                                  setState(() {
                                    _pass = val;
                                  });
                                }),
                          ),
                        ],
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 15),
                    child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Row(
                                children: [
                                  Text("تاريخ الميلاد"),
                                  FlatButton(
                                      onPressed: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(1950, 1, 1),
                                            maxTime: DateTime.now(),
                                            onConfirm: (date) {
                                          setState(() {
                                            this.date_to = date;

                                            var formatter =
                                                new dateformater.DateFormat(
                                                    'yyyy-MM-dd');
                                            dateformated_to =
                                                formatter.format(this.date_to);
                                          });
                                        },
                                            currentTime: this.date_to,
                                            locale: LocaleType.ar);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            '$dateformated_to',
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(3),
                                          ),
                                          Icon(
                                            Icons.alarm,
                                          ),
                                        ],
                                      )),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(30, 20, 30, 15),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text("الوزن"),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 175,
                                    child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        textDirection: TextDirection.rtl,
                                        onChanged: (String val) {
                                          setState(() {
                                            _weight = double.parse(val);
                                          });
                                        }),
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(30, 30, 30, 15),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text("الطول"),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width -
                                          178,
                                      child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          textDirection: TextDirection.rtl,
                                          onChanged: (String val) {
                                            setState(() {
                                              _height = double.parse(val);
                                            });
                                          }))
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(30, 30, 30, 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                                    child: Text('الجنس :   '),
                                  ),
                                  Container(
                                    width: 150.0,
                                    child: DropdownButton<String>(
                                      hint: Text("غير محدد"),
                                      value: ddvalue,
                                      isExpanded: true,
                                      onChanged: (String Value) {
                                        setState(() {
                                          setState(() {
                                            ddvalue = Value;
                                          });
                                        });
                                      },
                                      items: ['ذكر', 'انثي'].map((user) {
                                        return DropdownMenuItem<String>(
                                            value: user,
                                            child: Center(
                                              child: Text(
                                                user,
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ));
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                            child: RaisedButton(
                              color: Colors.amberAccent,
                              onPressed: () async {
                                var data = new user(
                                    uname: _username,
                                    email: _email,
                                    gender: ddvalue,
                                    he: _height,
                                    we: _weight,
                                    age: ((new DateTime.now())
                                                .difference(date_to as DateTime)
                                                .inDays /
                                            360)
                                        .floor(),
                                    pass: _pass,
                                    date: date_to,
                                    BMI: 0,
                                    total_Of_Calorie: 0);
                                try {
                                  var res = await Db.db.InserNew(data);
                                  if (res != null) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => login()),
                                      (Route<dynamic> route) => false,
                                    );
                                  } else {
                                    scaffoldKey.currentState
                                        .showSnackBar(new SnackBar(
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 100),
                                            content: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(
                                                "برجاء ملئ معلومات صحيحة",
                                                textAlign: TextAlign.center,
                                              ),
                                            )));
                                  }
                                } on DatabaseException catch (e) {
                                  scaffoldKey.currentState
                                      .showSnackBar(new SnackBar(
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 100),
                                          content: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              "برجاء ملئ معلومات صحيحة",
                                              textAlign: TextAlign.center,
                                            ),
                                          )));
                                }
                              },
                              child: Text(
                                "حفظ",
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.transparent)),
                            ),
                            width: 300,
                          ) /**/
                        ])))
              ],
            ),
          ]))
        ]));
  }
}

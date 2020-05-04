import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/shared/constants.dart';
import 'package:ourwearprototype/shared/loading.dart';
import 'package:ourwearprototype/shared/tombol/SocialButton.dart';
import 'package:ourwearprototype/services/auth.dart';

class LoginPage extends StatefulWidget {

  final Function toggleView;
  LoginPage({this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Email',
                    ),
                    validator: (val) => val.isEmpty ? 'Mohon masukan email' : null,
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Kata sandi',
                    ),
//                    validator: (val) => val.length < 6 ? 'Mohon masukan kata sandi diatas 6 karakter' : null,
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        child: Text('Lupa kata sandi'),
                        onPressed: (){

                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0,),
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'MASUK',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    color: Colors.green,
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if(result == null){
                          setState(() {
                            loading = false;
                            error = 'Tidak dapat masuk, salah email atau kata sandi?';
                          });
                        }
                      } else {

                      }
                    },
                  ),
                ],
              ),
              Row(children: <Widget>[
                //https://stackoverflow.com/questions/54058228/horizontal-divider-with-text-in-the-middle-in-flutter
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
                Text("atau"),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ]),
              SizedBox(height: 20.0,),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 35,
                        ),
                        onPressed: (){

                        },
                      ),
                      FlatButton(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 35,
                        ),
                        onPressed: (){

                        },
                      ),
                      FlatButton(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 35,
                        ),
                        onPressed: (){

                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Belum bergabung dengan OurWear?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          'Daftar',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: (){
                          widget.toggleView();
                        },
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ourwearprototype/shared/constants.dart';
import 'package:ourwearprototype/services/auth.dart';

class SignUpPage extends StatefulWidget {

  final Function toggleView;
  SignUpPage({this.toggleView});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String passwordAgain = '';
  String phoneNumber = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Form(
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
                          'Daftar Sekarang',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
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
                    validator: (val) => val.length < 6 ? 'Mohon masukan kata sandi diatas 6 karakter' : null,
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Ulang Kata sandi',
                    ),
                    validator: (val) => val != password ? 'Kata Sandi tidak cocok dengan yang diatas' : null,
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        passwordAgain = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Nomor Handphone',
                    ),
                    onChanged: (val){
                      setState(() {
                        phoneNumber = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0,),
                  //radio button drop down
                  SizedBox(height: 15.0,),
                  Row(
                    children: <Widget>[

                    ],
                  ),
                  SizedBox(height: 15.0,),
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Daftar Sekarang',
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
                        //print(email);
                        //print(password);
                        dynamic result = await _auth.registerWIthEmailAndPassword(email, password);
                        if(result == null){
                          setState(() {
                            loading = false;
                            error = 'Silahkan Periksa kembali email Anda';
                          });
                        }
                      } else {

                      }
                    },
                  ),
                ],
              ),

              SizedBox(height: 20.0,),
              Column( //alternative
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Sudah memiliki akun OurWear?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          'Masuk',
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
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Google',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    onPressed: (){

                    },
                  ),
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Facebook',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    onPressed: (){

                    },
                  ),
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Instagram',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    onPressed: (){

                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

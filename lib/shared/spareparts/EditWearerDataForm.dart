import 'package:flutter/material.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:ourwearprototype/shared/constants.dart';
import 'package:ourwearprototype/shared/loading.dart';
import 'package:ourwearprototype/shared/reusable/AnUserID.dart';
import 'package:provider/provider.dart';

class EditWearerDataForm extends StatefulWidget {
  @override
  _EditWearerDataFormState createState() => _EditWearerDataFormState();
}

class _EditWearerDataFormState extends State<EditWearerDataForm> {
  final _formKey = GlobalKey<FormState>();

  //Te
  String _currentName;
  String _currentPhone;
  String _currentAddress;
  FillData({String name, String phone, String address}){
    _currentName = name;
    _currentPhone = phone;
    _currentAddress = address;
  }

  String userID;
  AnUserID anUserID = AnUserID();
  void getUserID(){
    userID = anUserID.whatUserID();
  }

  @override
  void initState() {
    getUserID();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserID();
    //final user = Provider.of<User>(context);
    return StreamBuilder<Wearer>(
      stream: DatabaseService(uid: userID).wearerData,
      builder: (context, snapshot){
        //snapshot above is flutter part of implementation
        getUserID();
        
        if(snapshot.hasData){
          Wearer userData = snapshot.data;
          print("edit user ${userData.name}");
          // preFillData(
          //   name: userData.name,
          //   address: userData.address,
          //   phone: userData.phone,
          // );
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Ubah data Wearer-mu.',
                  style: TextStyle(fontSize: 18.0,),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Silahkan Masukan Nama' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0,),
                //Phone
                TextFormField(
                  initialValue: userData.phone,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Silahkan Masukan Nomor Telepon' : null,
                  onChanged: (val) => setState(() => _currentPhone = val),
                ),
                SizedBox(height: 20.0,),
                //Address (Dangerous! use raised button to select template instead!)
                //TODO: address Type such as Personal Private, Rent Shop, Deliver to, etc.
                TextFormField(
                  initialValue: userData.address,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Silahkan Masukan Alamat' : null,
                  onChanged: (val) => setState(() => _currentAddress = val),
                ),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      getUserID();


                      if(_formKey.currentState.validate()){
                        await DatabaseService(
                            uid: userID,
                        ).updateWearerData(
                          _currentName ?? userData.name, 
                          _currentPhone ?? userData.phone, 
                          _currentAddress ?? userData.address,
                        );
                        Navigator.pop(context);
                      } else {

                      }
                    }
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
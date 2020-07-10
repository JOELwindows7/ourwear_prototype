import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:ourwearprototype/shared/constants.dart';
import 'package:ourwearprototype/shared/loading.dart';
import 'package:ourwearprototype/shared/reusable/AnUserID.dart';

/*
https://api.flutter.dev/flutter/material/TextFormField-class.html
https://flutter.dev/docs/cookbook/forms/validation
https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter
https://medium.com/flutter-community/validating-and-formatting-payment-card-text-fields-in-flutter-bebe12bc9c602
https://stackoverflow.com/questions/55745219/flutter-switch-not-changing-after-tap-even-though-setstate-is-being-called
https://stackoverflow.com/questions/43214271/how-do-i-supply-an-initial-value-to-a-text-field
https://api.flutter.dev/flutter/material/CheckboxListTile-class.html
https://github.com/flutter/flutter/issues/28654

flutter run

https://github.com/flutter/flutter/issues/28654
https://api.flutter.dev/flutter/material/SwitchListTile-class.html
https://stackoverflow.com/questions/52814039/how-to-implement-checkbox-in-flutter
https://api.flutter.dev/flutter/material/Switch-class.html
*/

class EditRentalParticularly extends StatefulWidget {
  final String whichIDWasIt;
  EditRentalParticularly({this.whichIDWasIt});
  @override
  _EditRentalParticularlyState createState() =>
      _EditRentalParticularlyState(whichIDWasIt: whichIDWasIt);
}

class _EditRentalParticularlyState extends State<EditRentalParticularly> {
  final String whichIDWasIt;
  _EditRentalParticularlyState({this.whichIDWasIt});

  String _currentImager;
  String _currentNama;
  num _currentPrice;
  String _currentDescription;
  int _currentTimeBorrowDay;

  bool _currentAvailable = false;
  bool sparse = false;

  String userID;
  AnUserID anUserID = AnUserID();
  void getUserID() {
    userID = anUserID.whatUserID();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getUserID();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Rental>(
        stream: DatabaseService(uid: whichIDWasIt).particularRentalData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Rental particularData = snapshot.data;
            print(
                "edit Rental ${particularData.nama} is available = ${particularData.isAvailable}");

            if (!sparse) {
              _currentAvailable = particularData.isAvailable;

              sparse = true;
            }

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Ubah data Rental.',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'URL Gambar',
                    style: TextStyle(fontSize: 12.0),
                    textAlign: TextAlign.start,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.url,
                    initialValue: particularData.imager,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Silahkan Masukan URL gambar' : null,
                    onChanged: (val) => setState(() => _currentImager = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Judul',
                    style: TextStyle(fontSize: 12.0),
                    textAlign: TextAlign.start,
                  ),
                  TextFormField(
                    initialValue: particularData.nama,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Silahkan Masukan Judul' : null,
                    onChanged: (val) {
                      print('Nama change to $val');
                      setState(() => _currentNama = val);
                      print('curent nama now is $_currentNama');
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //Description
                  Text(
                    'Deskripsi',
                    style: TextStyle(fontSize: 12.0),
                    textAlign: TextAlign.start,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    initialValue: particularData.descriptions,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Silahkan Masukan deskripsi' : null,
                    onChanged: (val) =>
                        setState(() => _currentDescription = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //Price
                  Text(
                    'Harga',
                    style: TextStyle(fontSize: 12.0),
                    textAlign: TextAlign.start,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: particularData.price.toString(),
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Silahkan Masukan harga' : null,
                    onChanged: (val) =>
                        setState(() => _currentPrice = val as num),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //TimeBorrowDay
                  Text(
                    'Lama hari peminjaman',
                    style: TextStyle(fontSize: 12.0),
                    textAlign: TextAlign.start,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: particularData.timeBorrowDay.toString(),
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty
                        ? 'Silahkan Masukan lama hari peminjaman'
                        : null,
                    onChanged: (val) =>
                        setState(() => _currentTimeBorrowDay = val as int),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SwitchListTile.adaptive(
                      secondary: Icon(Icons.lightbulb_outline),
                      title: Text('Tersedia? '),
                      value: sparse
                          ? _currentAvailable
                          : particularData.isAvailable,
                      onChanged: (value) {
                        setState(() {
                          print('Change to $value');
                          _currentAvailable = value;
                        });
                      }),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        getUserID();

                        if (_formKey.currentState.validate()) {
                          await DatabaseService(
                            uid: whichIDWasIt,
                          ).updateRentalData(
                            name: _currentNama ?? particularData.nama,
                            descriptions: _currentDescription ??
                                particularData.descriptions,
                            imager: _currentImager ?? particularData.imager,
                            price: _currentPrice ?? particularData.price,
                            timeBorrowDay: _currentTimeBorrowDay ??
                                particularData.timeBorrowDay,
                            userId: userID,
                            isAvailable:
                                _currentAvailable ?? particularData.isAvailable,
                          );

                          Navigator.pop(context);
                          sparse = false;
                        } else {}
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

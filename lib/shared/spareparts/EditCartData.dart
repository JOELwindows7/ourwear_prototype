//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:ourwearprototype/models/Renter.dart';
import 'package:ourwearprototype/models/user.dart';
import 'package:ourwearprototype/services/auth.dart';
import 'package:ourwearprototype/services/database.dart';
import 'package:ourwearprototype/shared/loading.dart';
import 'package:ourwearprototype/shared/reusable/AnUserID.dart';
import 'package:provider/provider.dart';

/*
https://pub.dev/packages/flutter_spinbox
https://api.flutter.dev/flutter/widgets/Visibility-class.html 
https://stackoverflow.com/questions/44489804/show-hide-widgets-in-flutter-programmatically
https://api.flutter.dev/flutter/material/showDatePicker.html
https://mundanecode.com/posts/how-to-use-datepicker-in-flutter/
https://api.flutter.dev/flutter/intl/DateFormat-class.html
https://medium.com/@prafullkumar77/flutter-format-a-date-with-locale-using-dart-c6fa400c8a53
https://stackoverflow.com/questions/50758072/date-time-format-in-flutter-dd-mm-yyyy-hhmm
https://api.flutter.dev/flutter/intl/DateFormat-class.html
https://medium.com/flutteropen/flutter-widgets-13-dropdownbutton-d21e9c226f04
https://api.flutter.dev/flutter/material/DropdownButton/selectedItemBuilder.html
https://api.flutter.dev/flutter/intl/DateFormat-class.html
https://medium.com/flutteropen/flutter-widgets-13-dropdownbutton-d21e9c226f04
https://stackoverflow.com/questions/44489804/show-hide-widgets-in-flutter-programmatically
https://api.flutter.dev/flutter/widgets/AnimatedCrossFade-class.html
https://stackoverflow.com/questions/59698125/type-int-is-not-a-subtype-of-type-double-of-function-result
https://pub.dev/packages/flutter_spinbox#-readme-tab-
*/

class EditCartAhDoesntWork extends StatelessWidget {
  final String itemID;
  final bool isAddNew;

  EditCartAhDoesntWork({this.isAddNew, this.itemID});
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: EditCartData(
        isAddNew: isAddNew,
        itemID: itemID,
      ),
    );
  }
}

class EditCartData extends StatefulWidget {
  final String itemID;
  final bool isAddNew;
  EditCartData({this.isAddNew = false, this.itemID});

  @override
  _EditCartDataState createState() =>
      _EditCartDataState(isAddNew: isAddNew, itemID: itemID);
}

class _EditCartDataState extends State<EditCartData> {
  final bool isAddNew;
  final String itemID;
  _EditCartDataState({this.isAddNew = false, this.itemID});

  final _formKey = GlobalKey<FormState>();
  bool sparse = false;

  //CartItem currentCartItem = CartItem();
  double currentQuantity = 0.0;
  DateTime currentBorrowFrom;
  DateTime currentBorrowTo;
  int currentExecuteWhen;
  double currentTimeBorrowDay = 0.0;

  //final dateFormat = DateFormat.yMMMd("en-US");

  String sayBorrowFrom = "";
  String sayBorrowTo = "";
  bool executeAnytime = false;
  bool executeLater = false;
  final List<String> sayExecuteWhen = [
    'Sekarang & selesai kapanpun',
    'Tanggal Tertentu',
    'Sekarang selama beberapa hari'
  ];

  // https://mundanecode.com/posts/how-to-use-datepicker-in-flutter/
  Future<void> _selectCurrentDate(BuildContext context,
      {bool whichEnds = false}) async {
    final DateTime d = await showDatePicker(
      context: context,
      initialDate: whichEnds ? currentBorrowFrom : DateTime.now(),
      firstDate: whichEnds ? currentBorrowFrom : DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (d != null) if (whichEnds) {
      setState(() {
        currentBorrowTo = d;
        sayBorrowTo = new DateFormat('EEEE, d MMM yyyy').format(d);
      });
    } else {
      setState(() {
        currentBorrowFrom = d;
        sayBorrowFrom = new DateFormat('EEEE, d MMM yyyy').format(d);
      });
    }
  }

  String userID;
  AnUserID anUserID = AnUserID();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future getUserID() async {
    FirebaseUser user = await _auth.currentUser();
    String id = user.uid;
    userID = id;
    //userID = anUserID.whatUserID();
  }

  void checkExecution() {
    switch (currentExecuteWhen) {
      case 0: //Now
        setState(() {
          executeAnytime = false;
          executeLater = false;
        });

        break;
      case 1: //Specific Date
        setState(() {
          executeAnytime = false;
          executeLater = true;
        });

        break;
      case 2: //Anytime
        setState(() {
          executeAnytime = true;
          executeLater = true;
        });
        break;
      default:
        break;
    }
  }

  void initExecution() {
    switch (currentExecuteWhen) {
      case 0: //Now
        executeAnytime = false;
        executeLater = false;
        break;
      case 1: //Specific Date
        executeAnytime = false;
        executeLater = true;

        break;
      case 2: //Anytime
        executeAnytime = true;
        executeLater = true;
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    getUserID();
    checkExecution();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<CartItem>(
      stream:
          DatabaseService(uid: userID, subID: itemID).particularCartItemData,
      builder: (context, snapshot) {
        CartItem anItemCart = snapshot.data;
        print('for edit $anItemCart which is $itemID');
        print('for cart belongs to $userID');
        if (snapshot.hasData) {
          if (!sparse) {
            //TODO what to sparse
            print(
                'quantity ${anItemCart.quantity} , timeBorrowDay ${anItemCart.timeBorrowDay}');
            currentQuantity = anItemCart.quantity.toDouble();
            currentTimeBorrowDay = anItemCart.timeBorrowDay.toDouble();
            currentBorrowFrom = anItemCart.borrowFrom.toDate();
            currentBorrowTo = anItemCart.borrowTo.toDate();
            currentExecuteWhen = anItemCart.executeWhen;
            print('was execute when ${anItemCart.executeWhen}');
            sayBorrowFrom =
                DateFormat('EEEE, d MMM yyyy').format(currentBorrowFrom);
            sayBorrowTo =
                DateFormat('EEEE, d MMM yyyy').format(currentBorrowTo);

            initExecution();
            sparse = true;
          }

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SpinBox(
                  value: currentQuantity,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  onChanged: (value) {
                    currentQuantity = value;
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                DropdownButton<int>(
                    value: currentExecuteWhen,
                    onChanged: (value) {
                      setState(() {
                        currentExecuteWhen = value;
                        checkExecution();
                        print('Set Execution at $value');
                      });
                    },
                    items: [
                      DropdownMenuItem(
                          value: 0, child: Text(sayExecuteWhen.elementAt(0))),
                      DropdownMenuItem(
                          value: 1, child: Text(sayExecuteWhen.elementAt(1))),
                      DropdownMenuItem(
                          value: 2, child: Text(sayExecuteWhen.elementAt(2))),
                    ]),
                SizedBox(
                  height: 24.0,
                ),
                Visibility(
                  visible: executeLater,
                  child: Visibility(
                    visible: !executeAnytime,
                    child: Column(
                      children: <Widget>[
                        RaisedButton.icon(
                            onPressed: () {
                              _selectCurrentDate(context, whichEnds: false);
                            },
                            icon: Icon(Icons.calendar_today),
                            label: Text('Dari Tanggal $sayBorrowFrom')),
                        RaisedButton.icon(
                            onPressed: () {
                              _selectCurrentDate(context, whichEnds: true);
                            },
                            icon: Icon(Icons.calendar_today),
                            label: Text('Ke Tanggal $sayBorrowTo')),
                      ],
                    ),
                    replacement: Column(
                      children: <Widget>[
                        SpinBox(
                          value: currentTimeBorrowDay,
                          decoration:
                              InputDecoration(labelText: 'Berapa hari?'),
                          onChanged: (value) {
                            currentTimeBorrowDay = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  replacement: SizedBox(
                    height: 24.0,
                  ),
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          getUserID();

                          if (_formKey.currentState.validate()) {
                            DatabaseService(subID: itemID, uid: userID)
                                .updateCartItemDataMore(
                              quantity: currentQuantity.toInt() ??
                                  anItemCart.quantity,
                              borrowFrom:
                                  Timestamp.fromDate(currentBorrowFrom) ??
                                      anItemCart.borrowFrom,
                              borrowTo: Timestamp.fromDate(currentBorrowTo) ??
                                  anItemCart.borrowTo,
                              checkoutThis: anItemCart.checkoutThis,
                              executeWhen:
                                  currentExecuteWhen ?? anItemCart.executeWhen,
                              itemId: anItemCart.itemUid,
                              itemName: anItemCart.itemName,
                              rentalReferencePath: anItemCart.rentalReference,
                              timeBorrowDay: currentTimeBorrowDay.toInt() ??
                                  anItemCart.timeBorrowDay,
                            );
                            Navigator.pop(context);
                            sparse = false;
                          } else {}
                        }),
                  ],
                )
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

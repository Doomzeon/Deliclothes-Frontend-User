import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonAddToOrder extends StatefulWidget {
  final int idUser;
  final ClothesData clothe;

  const ButtonAddToOrder({Key key, this.idUser, this.clothe}) : super(key: key);
  @override
  _ButtonAddToOrderState createState() => _ButtonAddToOrderState();
}

class _ButtonAddToOrderState extends State<ButtonAddToOrder> {
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Chiudi"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Conferma azione"),
      content: Text("Il vestito e' stato aggiunto al carello"),
      actions: [cancelButton],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var stateUser = context.select((UserBloc cb) => cb.state);
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        GestureDetector(
          onTap: () => {
            if (stateUser is UserLoginSuccess)
              {
                BlocProvider.of<UserBloc>(context)
                    .add(UserAddOrder(widget.idUser, widget.clothe)),
                showAlertDialog(context)
              }
          },
          child: Container(
              width: size.width,
              height: 70,
              child: Stack(children: [
                Positioned(
                  top: 5,
                  left: size.width * 0.20,
                  child: Container(
                    decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(40)),
                    width: 240,
                    height: 45,
                    child: Center(
                      child: Text('Add to orders',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              fontFamily: 'AvenirLight')),
                    ),
                  ),
                ),
              ])),
        )
      ],
    );
  }
}

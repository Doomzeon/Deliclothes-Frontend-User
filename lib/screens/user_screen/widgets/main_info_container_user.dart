import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/models/user_info.dart';
import 'package:deliclothes_flutter/screens/home/home_new.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/drop_down_container.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../constant.dart';

class MainInfoContainerUser extends StatefulWidget {
  final UserInfo userData;
  final int idUser;
  const MainInfoContainerUser({
    Key key,
    this.userData, this.idUser,
  }) : super(key: key);

  @override
  _MainInfoContainerUserState createState() => _MainInfoContainerUserState();
}

class _MainInfoContainerUserState extends State<MainInfoContainerUser> {

    String _name, _surname, _residence , _codeCountry;
    int _phoneNumber;

    setName(String value){
      this._name = value;
    }
    setSurname(String value){
      this._surname = value;
    }
    setResidence(String value){
      this._residence = value;
    }
    setPgoneNumber(int value){
      this._phoneNumber = value;
    }

    saveDataUser(){
      print('s');

      BlocProvider.of<UserBloc>(context)
                .add(UserChangeMainInfo(widget.idUser, this._name, this._surname, this._residence, this._phoneNumber, this._codeCountry));

    }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    

    return Row(
      children: [
        Container(
          //padding: EdgeInsets.all(50),
          width: size.width,
          height: 460,
          //color: Colors.orange,
          child: Column(children: [
            HeaderContainer(size: size),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormContainer(
                  widthContainer: size.width *0.50 - 25.0,
                  initialValue: widget.userData.name,
                  icon: Icons.person_outlined,
                  callbackFunction: setName,
                ),
                TextFormContainer(
                  widthContainer: size.width *0.50- 25.0,
                  initialValue: widget.userData.surname,
                  icon: Icons.person_outlined,
                  callbackFunction: setSurname,
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropDownContainer(widthContainer: size.width - 50),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormContainer(
                  widthContainer: size.width - 50,
                  initialValue: widget.userData.phoneNumber.toString(),
                  icon: Icons.phone_enabled_outlined,
                  callbackFunction: setPgoneNumber,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormContainer(
                  callbackFunction: setResidence,
                    widthContainer: size.width - 50,
                    initialValue: widget.userData.residence,
                    icon: Icons.map_outlined),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap:()=> {this.saveDataUser()},
                  child: Container(
                    margin: EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 20.0,
                              color: Colors.grey[400],
                              offset: Offset(0, 0))
                        ],
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(40)),
                    width: 180,
                    height: 45,
                    child: Center(
                      child: Text(AppLocalizations.of(context).settings_page_my_account_button_save,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              fontFamily: 'AppleBraille')),
                    ),
                  ),
                )
              ],
            ),
          ]),
        )
      ],
    );
  }
}

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        margin: EdgeInsets.only(top: 50, left: 20),
        //color: Colors.green,
        child: IconButton(
          icon: SvgPicture.asset('assets/icons/left-arrow.svg',
              width: 20, color: kTextColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: 50, left: size.width * 0.15),
          child: Text(
            AppLocalizations.of(context).settings_page_my_account_title,
            style: TextStyle(
                color: kTextColor, fontSize: 18.0, fontFamily: 'AvenirLight'),
          ))
    ]);
  }
}

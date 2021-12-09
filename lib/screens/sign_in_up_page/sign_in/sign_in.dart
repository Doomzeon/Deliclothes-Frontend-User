import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/main.dart';
import 'package:deliclothes_flutter/screens/home/home_new.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in/widgets/procced_buttons_sign.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
       
          if (state is UserNotLoggedIn || state is UserLoginInitialState|| state is UserLoginFailed) {
            return SignInContainer();
          } else if(state is UserLoginInProgress){
            return SpinnerContainer(size);
          } else {
            
                    return Container(
                        child: Column(children: [
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(top: size.height * 0.30),
                              width: size.width,
                              child: Center(
                                  child:
                                      Text('Something wrong with the server.'))),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => {
                   setState(()=>
                          BlocProvider.of<UserBloc>(context)
                              .add((UserLoginInitialState()))
                        )},
                        child: Container(
                            margin: EdgeInsets.only(top: 15),
                            width: size.width,
                            height: 70,
                            child: Stack(children: [
                              Positioned(
                                top: 5,
                                left: size.width * 0.29,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius:
                                          BorderRadius.circular(40)),
                                  width: 180,
                                  height: 45,
                                  child: Center(
                                    child: Text('Retry',
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
                  )
                ]));
      }
    },
    );}
  
}

class SignInContainer extends StatefulWidget {
  const SignInContainer({
    Key key,
  }) : super(key: key);

  @override
  _SignInContainerState createState() => _SignInContainerState();
}

class _SignInContainerState extends State<SignInContainer> {
  String _email, _password;

  _setEmail(String value) {
    setState(() {
      this._email = value;
      print('Email is : ' + this._email);
    });
  }

  _setPassword(String value) {
    setState(() {
      this._password = value;
      print('Password is : ' + this._password);
    });
  }

  _proccedLogin() {
    BlocProvider.of<UserBloc>(context)
        .add(UserLogin(this._email, this._password));
  }

  validatorEmail(String value){
    print(value);
    if (!(value.contains("@")) || value == '')
      return "Email e' invalida";
    else
      return null;
  }

  validatorPassword(String value){
    if ( value == '')
      return "Password e' invalida";
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.50,
        width: size.width,
        child: Column(
          children: [
            ContainerTextFormField(
                size: size,
                hintText: AppLocalizations.of(context).sign_in_up_input_mail,
                iconTextForm: Icons.person_outlined,
                passwordTextForm: false,
                calbbackOnTap: this._setEmail,
                validatorCallback: this.validatorEmail),
            ContainerTextFormField(
                size: size,
                validatorCallback: this.validatorPassword,
                hintText: AppLocalizations.of(context).sign_in_up_input_password,
                iconTextForm: Icons.lock_outlined,
                passwordTextForm: true,
                calbbackOnTap: this._setPassword),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProccedButtonSignContainer(
                    textButton: AppLocalizations.of(context).sign_in_button_text_loggin,
                    colorButton: kSecondaryColor,
                    callbackFunction: this._proccedLogin),
                ProccedButtonSignContainer(
                  textButton: AppLocalizations.of(context).sign_in_up_button_text_loggin_after,
                  colorButton: kRedColor,
                  callbackFunction: () => {onPressedNavItem(3)},
                ),
              ],
            )
          ],
        ));
  }
}

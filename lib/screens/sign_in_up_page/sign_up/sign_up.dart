import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/main.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in/widgets/procced_buttons_sign.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in/widgets/text_form_field.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_up/sign_up_complete_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password, _confPass;

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

  _setConfPass(String value) {
    setState(() {
      this._confPass = value;
      print('Conf pass is : ' + this._confPass);
    });
  }

  validateEmail(String value) {
    if (!(value.contains('@')))
      return 'Email invalida';
    else
      return null;
  }

  validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    print('asd');
    print(regExp.hasMatch(value));
    if (regExp.hasMatch(value))
      return null;
    else
      return 'Passowrd deve contenere 1 lettera maiuscola, carattere speciale e un numero';
  }

  String validateConfirmPassword(String value) {
    print('Conf pass is : ' + this._confPass.toString());
    print('Password is : ' + this._password);
    print(this._password==this._confPass.toString());
    if (this._password == this._confPass)
      return null;
    else
      return 'Passowrd non sono uguali';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.60,
        width: size.width,
        child: Column(children: [
          ContainerTextFormField(
            size: size,
            hintText: AppLocalizations.of(context).sign_in_up_input_mail,
            iconTextForm: Icons.person_outlined,
            passwordTextForm: false,
            calbbackOnTap: this._setEmail,
            validatorCallback: this.validateEmail,
          ),
          ContainerTextFormField(
              size: size,
              hintText: AppLocalizations.of(context).sign_in_up_input_password,
              iconTextForm: Icons.lock_outlined,
              passwordTextForm: true,
              calbbackOnTap: this._setPassword,
              validatorCallback: this.validatePassword),
          ContainerTextFormField(
              size: size,
              hintText: AppLocalizations.of(context).sign_up_input_confimr_password,
              iconTextForm: Icons.lock_outlined,
              passwordTextForm: true,
              calbbackOnTap: this._setConfPass,
              validatorCallback: this.validateConfirmPassword),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProccedButtonSignContainer(
                  textButton: AppLocalizations.of(context).sign_up_button_text_next,
                  colorButton: kSecondaryColor,
                  callbackFunction: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SignUpCompleteProfile(
                                    email: this._email,
                                    password: this._password)))
                      }),
              ProccedButtonSignContainer(
                textButton: AppLocalizations.of(context).sign_in_up_button_text_loggin_after,
                colorButton: kRedColor,
                callbackFunction: () => {onPressedNavItem(3)},
              ),
            ],
          )
        ]));
  }
}

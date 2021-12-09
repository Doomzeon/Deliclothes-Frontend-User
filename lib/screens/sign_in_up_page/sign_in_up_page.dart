import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/main.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in/sign_in.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in_container.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_up/sign_up.dart';
import 'package:deliclothes_flutter/screens/weclome_page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingInUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SingInUpPageState();
  }
}


class SingInUpPageState extends State<SingInUpPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: Colors.white,
        child: Column(children: [
          Container(
            width: size.width,
            height: size.height,
            child: Stack(children: [
              Positioned(
                child: Container(
                    width: size.width,
                    height: size.height * 0.50,
                    color: kPrimaryColor,
                    child: CustomPaint(
                        painter: BNBCustomPainter(),
                        child: Column(children: [
                          Container(
                              width: size.width,
                              height: size.height * 0.50,
                              //color: Colors.green,
                              child: Stack(children: [
                                Positioned(
                                    top: 55,
                                    left: 0,
                                    child: Container(
                                      height: 50,
                                      width: size.width,
                                      //color: Colors.orange,
                                      child: Center(
                                        child: Text('Deliclothes',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 35,
                                                fontFamily: 'AvenirLight')),
                                      ),
                                    )),
                                Positioned(
                                  left: 0,
                                  top: 130,
                                  child: Container(
                                      width: size.width,
                                      child: Text(
                                          AppLocalizations.of(context).sign_in_up_main_page_title,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              fontFamily: 'AvenirLight'))),
                                ),
                                
                              ]))
                        ]))),
              ),

            Positioned(
                                  left: 0,
                                  bottom: 45,
                                  child: Container(
                                    width: size.width,
                                    height: size.height * 0.70,
                                    //color: Colors.orange,
                                    child: SignInUpContainerOld(),
                                  ),
                                )
            ]),
          )
        ]));
    //SignInUpContainer()
  }
}

///NEW 
class  SignInUpContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  SignInUpContainerState();
  } 
}

class SignInUpContainerState extends State<SignInUpContainer>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
  }

}

////// OLD 


class SignInUpContainerOld extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignInUpContainerStateOld();
  }
}

class SignInUpContainerStateOld extends State<SignInUpContainerOld> {
  var choiceChoosen = 'sign_in';

  changeSection(container) {
    choiceChoosen = container;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: [
      Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
          GestureDetector(
            onTap: () => {changeSection('sign_in')},
            child: Container(
              margin: EdgeInsets.only(left: 90, top: 20),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: choiceChoosen == 'sign_in'
                          ? BorderSide(width: 1, color: kSecondaryColor)
                          : BorderSide(
                              width: 1, color: Colors.transparent))),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Sign In',
                    style: TextStyle(
                        color: choiceChoosen == 'sign_in'
                            ? kSecondaryColor
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        fontFamily: 'AvenirLight')),
              ),
            ),
          ),
        ],
      ),
      Column(
        children: [
          GestureDetector(
            onTap: () => {changeSection('sign_up')},
            child: Container(
              margin: EdgeInsets.only(right: 90, top: 20),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: choiceChoosen == 'sign_up'
                          ? BorderSide(width: 1, color: kSecondaryColor)
                          : BorderSide(
                              width: 1, color: Colors.transparent))),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text('Sign Up',
                    style: TextStyle(
                        color: choiceChoosen == 'sign_up'
                            ? kSecondaryColor
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        fontFamily: 'AvenirLight')),
              ),
            ),
          ),
        ],
      )
    ],
      ),
      choiceChoosen == 'sign_in' ? SignIn() : SignUp()
    ]);
  }
}

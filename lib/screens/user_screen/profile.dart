import 'package:deliclothes_flutter/components/clothes_list_horizontal.dart';
import 'package:deliclothes_flutter/components/custom_bottom_navigation.dart';
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/logic/secure/local_storage.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:deliclothes_flutter/models/credit_card.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in_up_page.dart';
import 'package:deliclothes_flutter/screens/user_screen/account_info.dart';
import 'package:deliclothes_flutter/screens/user_screen/orders.dart';
import 'package:deliclothes_flutter/screens/user_screen/return_clothes.dart';
import 'package:deliclothes_flutter/screens/user_screen/settings.dart';
import 'package:deliclothes_flutter/screens/weclome_page/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserNotLoggedIn) {
          return Expanded(
                    child: SingleChildScrollView(child: SingInUpPage()));
        } else if (state is UserLoginSuccess) {
          return SingleChildScrollView(
                      child: Container(
              color: Colors.white,
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff9BBBD6),
                        Color(0xff6FA7D6),
                        Color(0xff599DD6),
                        Color(0xff388ED6)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                  ),
                  height: 160,
                  width: size.width,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      width: size.width - 100,
                      child: Center(
                        child: Text('Impostazioni',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'AvenirLight')),
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                        'Invita 10 amici e riceverai 20% di \nsconto sul prossimo acquisto (10 rimasti)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kTextColor,
                            fontSize: 16.0,
                            fontFamily: 'AvenirLight')),
                  ),
                ),
                SizedBox(height: 20),
                SettingsOptionContainer(
                    icon: 'assets/icons/user_edit.svg',
                    text: 'Mio account',
                    goToPage: () => {
                      
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: BlocProvider.of<UserBloc>(context),
                                        child: AccountInfo(userId:state.userId),
                                      )))

                        }),
                SettingsOptionContainer(
                    icon: 'assets/icons/settings.svg', text: 'Impostazioni',
                    goToPage: () => {
                      
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: BlocProvider.of<UserBloc>(context),
                                        child: Settings(),
                                      )))
                                      
                        }),
                SettingsOptionContainer(
                    icon: 'assets/icons/history.svg', text: "Tutti ordini",
                    goToPage: () => {
                      
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: BlocProvider.of<UserBloc>(context),
                                        child: Orders(userId:state.userId),
                                      )))
                                      
                        }),
                SettingsOptionContainer(
                    icon: 'assets/icons/exchange.svg',
                    text: 'Restituisci vestito/i',
                    goToPage: ()=>{
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: BlocProvider.of<UserBloc>(context),
                                        child: ReturnClothes(userId:state.userId),
                                      )))
                    },),
                SettingsOptionContainer(
                    icon: 'assets/icons/support.svg', text: 'Supporto'),
                SettingsOptionContainer(
                    icon: 'assets/icons/information.svg', text: 'Logout', goToPage: ()=>{
                      LocalStorageSecure.logout(),
                      BlocProvider.of<UserBloc>(context).add(UserLogout()),
                      setState(()=>{}),

                    }),
              ]),
            ),
          );
        }
      },
    );
  }
}

class SettingsOptionContainer extends StatelessWidget {
  final String icon, text;
  final Function goToPage;
  const SettingsOptionContainer({
    Key key,
    this.icon,
    this.text,
    this.goToPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: FlatButton(
            padding: EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            color: Color(0xfff5f6f9),
            onPressed: () => {goToPage()},
            child: Row(
              children: [
                SvgPicture.asset(icon, width: 22, color: kSecondaryColor),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(text,
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          fontFamily: 'AvenirLight')),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[600],
                )
              ],
            ),
          )),
    );
  }
}

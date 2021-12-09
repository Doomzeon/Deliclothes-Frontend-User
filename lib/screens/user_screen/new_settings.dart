import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/logic/secure/local_storage.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in_up_page.dart';
import 'package:deliclothes_flutter/screens/user_screen/account_info.dart';
import 'package:deliclothes_flutter/screens/user_screen/new_orders.dart';
import 'package:deliclothes_flutter/screens/user_screen/orders.dart';
import 'package:deliclothes_flutter/screens/user_screen/return_clothes.dart';
import 'package:deliclothes_flutter/screens/user_screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPageMain extends StatefulWidget {
  @override
  _SettingsPageMainState createState() => _SettingsPageMainState();
}

class _SettingsPageMainState extends State<SettingsPageMain> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              if (state is UserNotLoggedIn) {
                return Expanded(
                    child: SingleChildScrollView(child: SingInUpPage()));
              } else if (state is UserLoginSuccess) {
                return Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.15),
                    child: Row(
                      children: [
                        ContainerUserSettings(
                          size: size,
                          text: AppLocalizations.of(context).settings_page_my_account_title,
                          marginDir: EdgeInsets.only(left: size.width * 0.05),
                          iconPath: 'assets/icons/user_edit.svg',
                          callbackFunc: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<UserBloc>(
                                              context),
                                          child:
                                              AccountInfo(userId: state.userId),
                                        )))
                          },
                        ),
                        ContainerUserSettings(
                          size: size,
                          text: AppLocalizations.of(context).settings_page_settings,
                          marginDir: EdgeInsets.only(left: size.width * 0.10),
                          iconPath: 'assets/icons/settings.svg',
                          callbackFunc: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<UserBloc>(
                                              context),
                                          child: Settings(),
                                        )))
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.03),
                    child: Row(
                      children: [
                        ContainerUserSettings(
                          size: size,
                          text: AppLocalizations.of(context).settings_page_allorders,
                          marginDir: EdgeInsets.only(left: size.width * 0.05),
                          iconPath: 'assets/icons/history.svg',
                          callbackFunc: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<UserBloc>(
                                              context),
                                          child: OrdersPage(idUser: state.userId),
                                        )))
                          },
                        ),
                        ContainerUserSettings(
                          size: size,
                          text: AppLocalizations.of(context).settings_page_make_return,
                          marginDir: EdgeInsets.only(left: size.width * 0.10),
                          iconPath: 'assets/icons/exchange.svg',
                          callbackFunc: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<UserBloc>(
                                              context),
                                          child: ReturnClothes(
                                              userId: state.userId),
                                        )))
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.03),
                    child: Row(
                      children: [
                        ContainerUserSettings(
                          size: size,
                          text: AppLocalizations.of(context).settings_page_support,
                          marginDir: EdgeInsets.only(left: size.width * 0.05),
                          iconPath: 'assets/icons/support.svg',
                          callbackFunc: () => {},
                        ),
                        ContainerUserSettings(
                            size: size,
                            text: AppLocalizations.of(context).settings_page_logout,
                            marginDir: EdgeInsets.only(left: size.width * 0.10),
                            iconPath: 'assets/icons/information.svg',
                            callbackFunc: () => {
                                  LocalStorageSecure.logout(),
                                  BlocProvider.of<UserBloc>(context)
                                      .add(UserLogout()),
                                  setState(() => {}),
                                }),
                      ],
                    ),
                  ),
                ]);
              } else{
                print(state);
                return Container();
              }
            })));
  }
}

class ContainerUserSettings extends StatelessWidget {
  final String text, iconPath;
  final EdgeInsetsGeometry marginDir;
  final Function callbackFunc;

  const ContainerUserSettings({
    Key key,
    @required this.size,
    this.text,
    this.iconPath,
    this.marginDir,
    this.callbackFunc,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {callbackFunc()},
      child: Container(
        decoration: BoxDecoration(

                      boxShadow: [
                        BoxShadow(
                            blurRadius: 15.0,
                            color: Colors.grey[400],
                            offset: Offset(0, 0))
                      ],
            color: Colors.grey[50], borderRadius: BorderRadius.circular(40)),
        padding: EdgeInsets.only(top: 150 / 3),
        margin: marginDir,
        width: size.width * 0.40,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath, width: 22, color: kTextColor),
            SizedBox(height: 10),
            Expanded(
              child: Text(text,
                  style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      fontFamily: 'AvenirLight')),
            ),
          ],
        ),
      ),
    );
  }
}

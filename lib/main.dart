import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:deliclothes_flutter/components/bottom_navigation_bar.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/clothes_bloc.dart';
import 'package:deliclothes_flutter/logic/secure/local_storage.dart';
import 'package:deliclothes_flutter/screens/all_clothes/clothes.dart';
import 'package:deliclothes_flutter/screens/all_clothes/clothes_new.dart';
import 'package:deliclothes_flutter/screens/bag_screen/bag.dart';
import 'package:deliclothes_flutter/screens/home/home_new.dart';
import 'package:deliclothes_flutter/screens/liked_clothes/liked_clothes.dart';
import 'package:deliclothes_flutter/screens/liked_clothes/liked_clothes_new.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in_up_page.dart';
import 'package:deliclothes_flutter/screens/user_screen/new_settings.dart';
import 'package:deliclothes_flutter/screens/user_screen/profile.dart';
import 'package:deliclothes_flutter/logic/server/clothes_api.dart';
import 'package:deliclothes_flutter/screens/weclome_page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:deliclothes_flutter/logic/bloc/states/clothes_states.dart';
import 'components/custom_bottom_navigation.dart';
import 'constant.dart';
import 'logic/cubit/type_clothes_filter_page/choice_cubit.dart';
import 'models/user.dart';
import 'screens/filter-clothes-type_screen/filter_clothes_type_page.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';

void main() {
  runApp(MyApp());
}

int _selectedPage = 0;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _user, jwt;
  int _idUser;

  void initState() {
    print('asd');
    init();
  }

  Future init() async {
    _user = await LocalStorageSecure.readUser();
    print(_user.runtimeType);
    this._idUser = int.parse(_user);
    print(_idUser);
    if (this._idUser != null) {
      print('i am here');
      onPressedNavItem(3);
    }
  }

  @override
  Widget build(BuildContext context) {
    //ClothesApi().getHomePagePostersInfo();
    return MultiBlocProvider(
        providers: [
          BlocProvider<ChoiceTypeClothe>(
            create: (BuildContext context) => ChoiceTypeClothe(),
          ),
          BlocProvider<UserBloc>(
            create: (BuildContext context) => UserBloc(this._idUser != null
                ? UserLoginSuccess(this._idUser)
                : UserNotLoggedIn()),
          ),
          BlocProvider<ChoiceCubit>(
            create: (BuildContext context) => ChoiceCubit(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''), // English, no country code
            const Locale('it', ''), // Spanish, no country code
          ],
          localeResolutionCallback: (locale, supportedLocales){
            for (var supportedLocale in supportedLocales){
              if(supportedLocale.languageCode == locale.languageCode){
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          title: 'Deliclothes',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          //onGenerateRoute: _appRouter.onGenerateRoute,
          home: InitialPoint(),
        ));
  }
}

PageController _pageController = new PageController();

void onPressedNavItem(int pageSelected) {
  _pageController.jumpToPage(pageSelected);
}

class InitialPoint extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InitialPointState();
  }
}

class InitialPointState extends State<InitialPoint> {
  
  void _onPageChanged(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
    WelcomePageScreenInfoCustomized(
        img: 'assets/images/1.png',
        title: AppLocalizations.of(context).welcome_page_1_title,
        description:AppLocalizations.of(context).welcome_page_1_description,
        nextPage: 1),
    WelcomePageScreenInfoCustomized(
        img: 'assets/images/2.png',
        title: AppLocalizations.of(context).welcome_page_2_title,
        description: AppLocalizations.of(context).welcome_page_2_description,
        nextPage: 2),
    SingInUpPage(),
    Home(),
    ClothesLiked(),
    FilterTypeClothesPage(),
    Clothes(),
    //ClothesList(),
    SettingsPageMain(),
    //ProfileScreen(),
    BagScreen()
  ];
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    print(_selectedPage);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: _selectedPage >= 3
          ? CustomBottomNavigationBar(size: size, selectedPage: _selectedPage)
          : null,
    );
  }
}

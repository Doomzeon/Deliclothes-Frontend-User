import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliclothes_flutter/components/clothes_container.dart';
//import 'package:deliclothes_flutter/components/clothes_list_horisontal.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/clothes_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/clothes_event.dart';
import 'package:deliclothes_flutter/logic/bloc/states/clothes_states.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/choice_cubit.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/cubit_state.dart';
import 'package:deliclothes_flutter/main.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:deliclothes_flutter/screens/all_clothes/clothes.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant.dart';

class ClothesListLiked extends StatefulWidget {
  const ClothesListLiked({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClothesListLikedState();
  }
}

class ClothesListLikedState extends State<ClothesListLiked> {
  List<ClothesData> clothes = new List<ClothesData>();
  int _userId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return BlocProvider(
      create: (context) => ClothesBloc(ClothesInitialState()),
      child: Container(
        color: Colors.white,
        child: Column(children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserNotLoggedIn) {
                return Container();
              }else{
              return HeaderAllClothesLiked(size: size);
              }
            },
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserNotLoggedIn) {
                return Expanded(
                    child: SingleChildScrollView(child: SingInUpPage()));
              } else if (state is UserLoginSuccess) {
                this._userId = state.userId;
                return BlocBuilder<ClothesBloc, ClothesState>(
                  builder: (context, state) {
                    //if(context.select((UserState userState) => userState) is UserLoginSuccess)
                    if (state is ClothesInitialState) {
                      
                          return Container();
                    } else if (state is ClothesInitialState ||
                        state is ClothesLoadInProgress) {
                      return Container(
                        width: size.width,
                        height: 310,
                        child: SpinKitWanderingCubes(
                            color: kBackgroundHeaderColor, size: 50.0),
                      );
                    } else if (state is ClothesLoadedSuccess) {
                      return Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            for (var i = 0; i < state.clothes.length; i += 2)
                              ClotheContainerRow(
                                  clothesData: i + 2 <= state.clothes.length
                                      ? state.clothes.sublist(i, i + 2)
                                      : state.clothes.sublist(i, i + 1)),
                          ]),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }
            },
          )
        ]),
      ),
    );
  }
}

class HeaderAllClothesLiked extends StatelessWidget {
  const HeaderAllClothesLiked({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      ),
      height: 130,
      width: size.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          width: size.width - 100,
          child: Center(
            child: Text('You ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'AvenirLight')),
          ),
        ),
      ]),
    );
  }
}

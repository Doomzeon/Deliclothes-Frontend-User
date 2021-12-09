import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/clothes_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/clothes_event.dart';
import 'package:deliclothes_flutter/logic/bloc/states/clothes_states.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/screens/all_clothes/clothes.dart';
import 'package:deliclothes_flutter/screens/home/home_new.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClothesLiked extends StatefulWidget {
  @override
  _ClothesLikedState createState() => _ClothesLikedState();
}

class _ClothesLikedState extends State<ClothesLiked> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return BlocProvider(
      create: (context) => ClothesBloc(ClothesInitialState()),
      child: Container(
          color: Colors.white,
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, stateUser) {
              if (stateUser is UserLoginSuccess) {
                return Column(children: [
                  HeaderAllClothesLiked(size: size),
                  BlocConsumer<ClothesBloc, ClothesState>(
                    listener: (context, state) {},
                    builder: (context, stateClothes) {
                      if (stateClothes is ClothesInitialState) {
                        BlocProvider.of<ClothesBloc>(context)
                            .add(ClothesRequestLiked(stateUser.userId, AppLocalizations.of(context).localeName));
                        return Container();
                      } else if (stateClothes is ClothesLoadInProgress) {
                        return SpinnerContainer(size);
                      } else if (stateClothes is ClothesLoadedSuccess) {
                        return Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(children: [
                              for (var i = 0;
                                  i < stateClothes.clothes.length;
                                  i += 2)
                                ClotheContainerRow(
                                    clothesData: i + 2 <=
                                            stateClothes.clothes.length
                                        ? stateClothes.clothes.sublist(i, i + 2)
                                        : stateClothes.clothes
                                            .sublist(i, i + 1)),
                            ]),
                          ),
                        );
                      } else if (stateClothes is ClothesLoadedFailure) {
                        return Container(
                            child: Column(children: [
                          Row(
                            children: [
                              Container(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.30),
                                  width: size.width,
                                  child: Center(
                                      child: Text(
                                          'Something wrong with the server.'))),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  BlocProvider.of<ClothesBloc>(context).add(
                                      ClothesRequestLiked(stateUser.userId, AppLocalizations.of(context).localeName))
                                },
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
                                                    fontFamily:
                                                        'AvenirLight')),
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
                  )
                ]);
              } else {
                
                return Expanded(
                    child: SingleChildScrollView(child: SingInUpPage()));
              }
            },
          )),
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
        color: kPrimaryColor,
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
            child: Text(AppLocalizations.of(context).clothes_liked_page_title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'AlBayan')),
          ),
        ),
      ]),
    );
  }
}

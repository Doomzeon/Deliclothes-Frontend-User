import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliclothes_flutter/components/clothes_container.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/clothes_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/main_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/clothes_event.dart';
import 'package:deliclothes_flutter/logic/bloc/states/clothes_states.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/choice_cubit.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/cubit_state.dart';
import 'package:deliclothes_flutter/main.dart';
import 'package:deliclothes_flutter/models/clothes.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constant.dart';

class ClothesList extends StatefulWidget {
  const ClothesList({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClothesListState();
  }
}

class ClothesListState extends State<ClothesList> {
  String filter;
  List<ClothesData> clothes;
  TextEditingController searchTextController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    searchTextController.addListener(() {
      print(searchTextController.text);
      filter = searchTextController.text;
      /*this.clothes = this
          .clothes
          .where((u) =>
              (u.getBrandName().toLowerCase().contains(filter.toLowerCase())))
          .toList();*/
      print(this.clothes);
      setState(() {
        print(filter);
      });
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int id_user=0;
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(children: [
          HeaderAllClothes(size: size),
          //this.clothes!=null?ClothesRowFilterContainer(searchTextController: searchTextController):Container(),
          BlocProvider(
            create: (context) => ClothesBloc(ClothesInitialState()),
            child: BlocConsumer<ClothesBloc, ClothesState>(
                listener: (context, state) {
              // TODO: implement listener
            }, builder: (context, state) {
              if (state is ClothesInitialState) {
                final choice =
                    context.select((ChoiceCubit cb) => cb.state.choice);
                final type = context
                    .select((ChoiceTypeClothe cd) => cd.state.clotheType);

                
                var stateUser = context.select((UserBloc cb) => cb.state);
                print('State use =>' + stateUser.toString());
                
                if (stateUser is UserLoginSuccess) {
                  id_user = stateUser.userId;
                }
                BlocProvider.of<ClothesBloc>(context)
                    .add(ClothesRequestByGenderAndType(choice, type, id_user, AppLocalizations.of(context).localeName));
              }
              if (state is ClothesInitialState ||
                  state is ClothesLoadInProgress) {
                return Container(
                  width: size.width,
                  height: 500,
                  child: Stack(children: [
                    Positioned(
                      top: size.height * 0.35,
                      left: size.width * 0.45,
                      child: SpinKitWanderingCubes(
                          color: kBackgroundHeaderColor, size: 50.0),
                    ),
                  ]),
                );
              }
              if (state is ClothesLoadedSuccess) {
                print(state.clothes);
                //this.clothes = state.clothes;
                print(filter);
                if (filter != '' && filter != null) {
                  /*print('wow');
                  this.clothes = state.clothes
                      .where((u) => u
                          .getTitle()
                          .toLowerCase()
                          .contains(filter.toLowerCase()))
                      .toList();*/
                }
                //print(this.clothes.length);
                //if(this.clothes.length%2==1){
                //        this.clothes.removeAt(this.clothes.length-1);}
                return Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    /*child: Column(children: [
                      ClothesRowFilterContainer(
                          searchTextController: searchTextController),
                      for (var i = 0; i < this.clothes.length; i += 2)
                        ClotheContainerRow(
                            clothesData: i + 2 <= this.clothes.length
                                ? this.clothes.sublist(i, i + 2)
                                : this.clothes.sublist(i, i + 1)),
                    ])*/
                  ),
                );
              }else{
                return Container();
              }
            }),
          )
        ]),
      ),
    );
  }
}

class ClothesRowFilterContainer extends StatelessWidget {
  final TextEditingController searchTextController;

  const ClothesRowFilterContainer({
    Key key,
    this.searchTextController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 80,
      width: size.width,
      child: Stack(children: [
        Positioned(
          top: 3,
          left: size.width * 0.07,
          child: Container(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300,
                  height: 45,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 20.0,
                            color: Colors.grey[400],
                            offset: Offset(0, 0))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  padding: EdgeInsets.only(left: 0, bottom: 5),
                  child: TextField(
                    controller: searchTextController,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 13.0,
                        fontFamily: 'AvenirLight'),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                        hintText: "Enter name of brand/clothe",
                        hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11.0,
                            fontFamily: 'AvenirLight'),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                    //padding: EdgeInsets.all(5),
                    child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/filter.svg',
                    width: 25,
                    color: Colors.grey[500],
                  ),
                  onPressed: () {},
                ))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class ClotheContainerRow extends StatefulWidget {
  final List<ClothesPoster> clothesData;

  const ClotheContainerRow({Key key, this.clothesData}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createStateRETURN
    return ClotheContainerRowState(this.clothesData);
  }
}

class ClotheContainerRowState extends State<ClotheContainerRow> {
  final List<ClothesPoster> clothesData;
  ClotheContainerRowState(this.clothesData);

  @override
  Widget build(BuildContext context) {
    print('asd');
    print(clothesData);
    {}
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < this.clothesData.length; i += 1)
          ClotheInfoContainerComponent(clothe: this.clothesData[i]),
        if (this.clothesData.length % 2 == 1)
          Container(
            width: 175,
            height: 265,
          )
      ],
    );
  }
}

class HeaderAllClothes extends StatelessWidget {
  const HeaderAllClothes({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChoiceCubit, ChoiceState>(
      listener: (context, state) {},
      builder: (context, state) {
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
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          height: 130,
          width: size.width,
          child: Row(children: [
            Container(
              padding: EdgeInsets.only(top: 30),
              child: IconButton(
                icon: SvgPicture.asset('assets/icons/left-arrow.svg',
                    width: 20, color: Colors.white),
                onPressed: () {
                  onPressedNavItem(5);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              width: size.width - 100,
              child: Center(
                child: Text(state.choice,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'AvenirLight')),
              ),
            ),
          ]),
        );
      },
    );
  }
}

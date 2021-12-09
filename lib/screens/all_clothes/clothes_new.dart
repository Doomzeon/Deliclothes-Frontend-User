import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/clothes_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/clothes_event.dart';
import 'package:deliclothes_flutter/logic/bloc/states/clothes_states.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/choice_cubit.dart';
import 'package:deliclothes_flutter/models/clothes.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:deliclothes_flutter/screens/all_clothes/widgets/clothe_container_row.dart';
//import 'package:deliclothes_flutter/screens/all_clothes/clothes.dart';
import 'package:deliclothes_flutter/screens/all_clothes/widgets/header_container.dart';
import 'package:deliclothes_flutter/screens/all_clothes/widgets/search_form_container.dart';
import 'package:deliclothes_flutter/screens/home/home_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Clothes extends StatefulWidget {
  @override
  _ClothesState createState() => _ClothesState();
}

class _ClothesState extends State<Clothes> {
  List<ClothesData> _clothes;

  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Container(
            color: Colors.white,
            child: Column(children: [
              HeaderAllClothesT(size: size),
              BlocProvider(
                create: (context) => ClothesBloc(ClothesInitialState()),
                child: BlocConsumer<ClothesBloc, ClothesState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ClothesInitialState) {
                      final _choice =
                          context.select((ChoiceCubit cb) => cb.state.choice);
                      final _type = context
                          .select((ChoiceTypeClothe cd) => cd.state.clotheType);
                      var _stateUser =
                          context.select((UserBloc cb) => cb.state);
                      if (_stateUser is UserLoginSuccess) {
                        BlocProvider.of<ClothesBloc>(context).add(
                            ClothesRequestByGenderAndType(
                                _choice, _type, _stateUser.userId, AppLocalizations.of(context).localeName));
                      } else {
                        BlocProvider.of<ClothesBloc>(context).add(
                            ClothesRequestByGenderAndType(_choice, _type, 0, AppLocalizations.of(context).localeName));
                      }
                      return Container();
                    } else if (state is ClothesLoadInProgress) {
                      return SpinnerContainer(size);
                    } else if (state is ClothesLoadedSuccess) {
                      return ClothesLogicVisualizationFiltering(
                          clothes: state.clothes,
                          clothesInitial: state.clothes);
                    } else {
                      final _choice =
                          context.select((ChoiceCubit cb) => cb.state.choice);
                      final _type = context
                          .select((ChoiceTypeClothe cd) => cd.state.clotheType);
                      var _stateUser =
                          context.select((UserBloc cb) => cb.state);
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
                                if (_stateUser is UserLoginSuccess)
                                  {
                                    BlocProvider.of<ClothesBloc>(context).add(
                                        ClothesRequestByGenderAndType(
                                            _choice, _type, _stateUser.userId, AppLocalizations.of(context).localeName ))
                                  }
                                else
                                  {
                                    BlocProvider.of<ClothesBloc>(context).add(
                                        ClothesRequestByGenderAndType(
                                            _choice, _type, 0, AppLocalizations.of(context).localeName))
                                  }
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
                ),
              )
            ])));
  }
}

class ClothesLogicVisualizationFiltering extends StatefulWidget {
  final List<ClothesPoster> clothesInitial;
  List<ClothesPoster> clothes;

  ClothesLogicVisualizationFiltering(
      {Key key, this.clothesInitial, this.clothes})
      : super(key: key);

  @override
  _ClothesLogicVisualizationFilteringState createState() =>
      _ClothesLogicVisualizationFilteringState();
}

class _ClothesLogicVisualizationFilteringState
    extends State<ClothesLogicVisualizationFiltering> {
  callbackFilter(String filterValue) {
    print(filterValue);
    print((widget.clothesInitial.where(
        (u) => u.title.toLowerCase().contains(filterValue.toLowerCase()))));
    widget.clothes = widget.clothesInitial
        .where((u) => u.title.toLowerCase().contains(filterValue.toLowerCase()))
        .toList();
    print(widget.clothes);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          /*FilterClothesTextField(
            callbackFilter: this.callbackFilter,
          ),*/
          for (var i = 0; i < widget.clothes.length; i += 2)
            ClotheContainerRow(
                clothesData: i + 2 <= this.widget.clothes.length
                    ? this.widget.clothes.sublist(i, i + 2)
                    : this.widget.clothes.sublist(i, i + 1)),
        ]),
      ),
    );
  }
}

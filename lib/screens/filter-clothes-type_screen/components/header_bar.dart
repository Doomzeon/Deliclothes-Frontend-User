
import 'package:deliclothes_flutter/logic/bloc/blocs/main_bloc.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/choice_cubit.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.22,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)),
          gradient: LinearGradient(
                                  colors: [
                                    Color(0xff9BBBD6),
                                    Color(0xff6FA7D6),
                                    Color(0xff599DD6),
                                    Color(0xff388ED6)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )),
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ScreenTitle(), TypeGenderClothes(size: size)],
        ),
      ),
    );
  }
}

class TypeGenderClothes extends StatefulWidget {
  final size;

  const TypeGenderClothes({Key key, this.size}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TypeGenderClothesState(this.size);
  }
}

class TypeGenderClothesState extends State<TypeGenderClothes> {
  final size;
  final _bloc = FilterHeaderGenderClothesBloc();

  TypeGenderClothesState(this.size);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
                //color: kPrimaryColor
                ),
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.04),
              child: BlocBuilder<ChoiceCubit, ChoiceState>(
                  builder: (context, state) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          BlocProvider.of<ChoiceCubit>(context).chooseMan(),
                      child: Container(
                        decoration: BoxDecoration(
                            border: getBorder('Man', state.choice.toString())), //TODO change logic
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Text(AppLocalizations.of(context).clothes_list_1_page_gender_man,
                              style: TextStyle(
                                  color: getColorChoiceSelected(
                                      'Man', state.choice.toString()),
                                  fontSize: 15.0,
                                  fontFamily: 'AvenirLight')),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          BlocProvider.of<ChoiceCubit>(context).chooseWoman(),
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                getBorder('Woman', state.choice.toString())),
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Text(AppLocalizations.of(context).clothes_list_1_page_gender_woman,
                              style: TextStyle(
                                  color: getColorChoiceSelected(
                                      'Woman', state.choice.toString()),
                                  fontSize: 16.0,
                                  fontFamily: 'AvenirLight')),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          BlocProvider.of<ChoiceCubit>(context).chooseChild(),
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                getBorder('Bambini', state.choice.toString())),
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Text(AppLocalizations.of(context).clothes_list_1_page_gender_child,
                              style: TextStyle(
                                  color: getColorChoiceSelected(
                                      'Child', state.choice.toString()),
                                  fontSize: 15.0,
                                  fontFamily: 'AvenirLight')),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ))
      ],
    );
  }

  Border getBorder(text, choiceSelected) {
    if (choiceSelected == text) {
      return new Border(bottom: BorderSide(width: 1, color: kSecondaryColor));
    } else {
      return Border(bottom: BorderSide(width: 1, color: Colors.transparent));
    }
  }

  Color getColorChoiceSelected(text, choiceSelected) {
    if (choiceSelected == text) {
      return kSecondaryColor;
    } else {
      return Colors.white;
    }
  }
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              //color: kPrimaryColor
              ),
          child: Text(
            AppLocalizations.of(context).clothes_list_1_page_title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'AvenirLight'),
          ),
        ),
      ],
    );
  }
}

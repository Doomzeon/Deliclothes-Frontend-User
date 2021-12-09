
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/choice_cubit.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/cubit_state.dart';
import 'package:deliclothes_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HeaderAllClothesT extends StatelessWidget {
  const HeaderAllClothesT({Key key, @required this.size}) : super(key: key);

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
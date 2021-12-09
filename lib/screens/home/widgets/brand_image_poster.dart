
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/choice_cubit.dart';
import 'package:deliclothes_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BranImageDescription extends StatelessWidget {
  final String image, text;
  const BranImageDescription({
    Key key,
    @required this.size,
    this.image,
    this.text,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 45,
                right: 10,
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/information.svg',
                    width: 35,
                    color: kSecondaryColor,
                  ),
                  onPressed: () {
                    BlocProvider.of<ChoiceCubit>(context).chooseMan();
                    BlocProvider.of<ChoiceTypeClothe>(context)
                        .setTypeClothe('SpecialPrice');
                    onPressedNavItem(6);
                  },
                ),
              ),
              Positioned(
                  bottom: 110,
                  left: 10,
                  child: Text(text,
                      style: TextStyle(
                          color: kSecondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          fontFamily: 'AvenirLight'))),
            ],
          ),
        )
      ],
    );
  }
}

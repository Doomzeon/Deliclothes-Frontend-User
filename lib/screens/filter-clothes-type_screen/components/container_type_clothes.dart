
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/choice_cubit.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/cubit_state.dart';
import 'package:deliclothes_flutter/screens/all_clothes/clothes.dart';
import 'package:flutter/material.dart';
import 'package:deliclothes_flutter/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ContainerTypeClothes extends StatelessWidget {
  final String image;
  final String text;
  const ContainerTypeClothes({
    Key key,
    this.image,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChoiceTypeClothe, TypeClotheState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: ()=>{
            BlocProvider.of<ChoiceTypeClothe>(context).setTypeClothe(text),
            
            onPressedNavItem(6)
          },
              child: Container(
              margin: EdgeInsets.only(top: 25),
              height: 180,
              width: 150,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey)],
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
      
    
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.white),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  letterSpacing: 8,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AvenirLight'),
            ),
          )),
    );
      });}}
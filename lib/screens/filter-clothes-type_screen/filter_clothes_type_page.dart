import 'package:deliclothes_flutter/components/custom_bottom_navigation.dart';
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/choice_cubit.dart';
import 'package:deliclothes_flutter/screens/filter-clothes-type_screen/components/type_container_clothes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'components/header_bar.dart';

class FilterTypeClothesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return BodyV2(); //Body()
    //bottomNavigationBar: CustomBottomNavigation(size: size));
  }
}

class BodyV2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          HeaderBar(size: size),
          TypeContainerBody(size: size),
        ],
      ),
    );
  }
}

//flutter clean && flutter run -d 000

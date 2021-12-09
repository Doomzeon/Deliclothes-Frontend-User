import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliclothes_flutter/components/clothes_container.dart';
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/models/clothes.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:deliclothes_flutter/main.dart';

class ClothesListHorizontal extends StatefulWidget{
  

  final Size size;
  final List<ClothesPoster> clothes;

  const ClothesListHorizontal({Key key, this.size, this.clothes}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClothesListHorizontalState();
  }

}

class ClothesListHorizontalState extends State<ClothesListHorizontal> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.size.width,
        height: 310,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < widget.clothes.length; i++)
                Container(
                    margin: EdgeInsets.only(left: 15),
                    child:
                        ClotheInfoContainerComponent(clothe: widget.clothes[i]))
            ],
          ),
        ));
  }
}
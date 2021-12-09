

import 'package:deliclothes_flutter/components/clothes_container.dart';
import 'package:deliclothes_flutter/models/clothes.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:flutter/material.dart';

class ClotheContainerRow extends StatefulWidget{
  final List<ClothesPoster> clothesData;

  const ClotheContainerRow({Key key, this.clothesData}) : super(key: key);
  @override
  _ClotheContainerRowState createState() => _ClotheContainerRowState();
}

class _ClotheContainerRowState extends State<ClotheContainerRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < widget.clothesData.length; i += 1)
          ClotheInfoContainerComponent(clothe: widget.clothesData[i]),
        if (widget.clothesData.length % 2 == 1)
          Container(
            width: 175,
            height: 265,
          )
      ],
    );
  }
}
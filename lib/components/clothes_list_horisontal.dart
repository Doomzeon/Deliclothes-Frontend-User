import 'package:deliclothes_flutter/components/clothes_container.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:flutter/material.dart';

class ClotheContainerRow extends StatefulWidget {
  final List<ClothesData> clothesData;

  const ClotheContainerRow({Key key, this.clothesData}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createStateRETURN 
    return ClotheContainerRowState(this.clothesData);
  }

}


class ClotheContainerRowState extends State<ClotheContainerRow> {
  final List<ClothesData> clothesData;

  ClotheContainerRowState(this.clothesData);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
         // for (var i = 0; i < this.clothesData.length; i += 1)
         // ClotheInfoContainerComponent(clothe:this.clothesData[i])
      ],
    );
  }
}
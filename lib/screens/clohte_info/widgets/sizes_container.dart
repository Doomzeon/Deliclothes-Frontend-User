import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:flutter/material.dart';

class SizesContainer extends StatefulWidget {
  final ClothesData clothe;

  const SizesContainer({Key key, this.clothe}) : super(key: key);
  @override
  _SizesContainerState createState() => _SizesContainerState();
}

class _SizesContainerState extends State<SizesContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var i = 0; i < widget.clothe.getSizes().length; i++)
          GestureDetector(
            onTap: () => {
              widget.clothe
                  .setSizeSelected(widget.clothe.getSizes()[i].toString()),
              setState(() => {})
            },
            child: Container(
              decoration: BoxDecoration(
                  color: widget.clothe.getSizeSelected() ==
                          widget.clothe.getSizes()[i]
                      ? kSecondaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              margin: i == 0
                  ? EdgeInsets.only(left: 30, top: 15)
                  : EdgeInsets.only(left: 10, top: 15),
              width: 30,
              height: 30,
              child: Center(
                child: Text(widget.clothe.getSizes()[i].toString(),
                    style: TextStyle(
                        color: widget.clothe.getSizeSelected() ==
                                widget.clothe.getSizes()[i]
                            ? Colors.white
                            : kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        fontFamily: 'AvenirLight')),
              ),
            ),
          )
      ],
    );
  }
}

import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/models/order_info_clothes.dart';
import 'package:flutter/material.dart';

class ClotheReturnRowCheckbox extends StatefulWidget {
  final OrderInfoClothes clothe;
  final Function callBackFunction;

  const ClotheReturnRowCheckbox({Key key, this.clothe, this.callBackFunction})
      : super(key: key);
  @override
  _ClotheReturnRowCheckboxState createState() =>
      _ClotheReturnRowCheckboxState();
}

class _ClotheReturnRowCheckboxState extends State<ClotheReturnRowCheckbox> {
  var _selectedItem = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Container(
        margin: EdgeInsets.only(top: 20),
        width: 120,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(35)),
          image: DecorationImage(
            image: NetworkImage(widget.clothe.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: 20),
          width: size.width - 150,
          height: 130,
          child: Stack(children: [
            Positioned(
                top: 1,
                right: 5,
                child: Checkbox(
                  value: this._selectedItem,
                  onChanged: (value) => {
                    setState(() => {
                          this._selectedItem = value,
                          widget.callBackFunction(value, widget.clothe)
                        })
                  },
                )),
            Positioned(
                top: 25,
                left: 5,
                child: Text(widget.clothe.title.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontFamily: 'AvenirLight'))),
            Positioned(
                bottom: 20,
                left: 10,
                child: Text(
                    (widget.clothe.cost * widget.clothe.qunatity).toString() +
                        ' €',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'AvenirLight'))),
            Positioned(
                top: 50,
                right: 35,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Center(
                    child: Text(widget.clothe.size.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontFamily: 'AvenirLight')),
                  ),
                )),
            Positioned(
                bottom: 10,
                right: 35,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 20.0,
                            color: Colors.grey[400],
                            offset: Offset(0, 0))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Center(
                    child: Text(widget.clothe.qunatity.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: 'AvenirLight')),
                  ),
                ))
          ]))
    ]);
  }
}

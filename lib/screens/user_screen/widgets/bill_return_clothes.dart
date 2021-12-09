
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/models/order_info_clothes.dart';
import 'package:flutter/material.dart';

class BillReturnClothes extends StatefulWidget {
  final List<OrderInfoClothes> clothes;
  final Function setAmount;

  const BillReturnClothes({
    Key key, this.clothes, this.setAmount,
  }) : super(key: key);

  @override
  _BillReturnClothesState createState() => _BillReturnClothesState();
}

class _BillReturnClothesState extends State<BillReturnClothes> {
  String calculateTot(val) {
    double t = val;
    print(widget.clothes.length);
    for (var i = 0; i < widget.clothes.length; i++) {
      t += widget.clothes[i].cost * widget.clothes[i].qunatity;
      print(t);
    }
    widget.setAmount(t);
    return t.toString();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 150,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10, left: 30),
                  child: Text('Scontrino',
                      style: TextStyle(
                          color: kTextColor,
                          //fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          fontFamily: 'AvenirLight'))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10, left: 30),
                  child: Text('Costo consegna ',
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 15.0,
                          fontFamily: 'AvenirLight'))),
              Container(
                  padding: EdgeInsets.only(top: 10, right: 10),
                  child: Text('3 € ',
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 15.0,
                          fontFamily: 'AvenirLight')))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10, left: 30),
                  child: Text('Costo di vestiti da restituire',
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 15.0,
                          fontFamily: 'AvenirLight'))),
              Container(
                  padding: EdgeInsets.only(top: 10, right: 10),
                  child: Text(this.calculateTot(0.0) + ' € ',
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 15.0,
                          fontFamily: 'AvenirLight')))
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 10, left: 10, top: 10),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        style: BorderStyle.solid,
                        width: 1,
                        color: kTextColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Text('Totale ',
                        style: TextStyle(
                            color: kTextColor,
                            fontSize: 15.0,
                            fontFamily: 'AvenirLight'))),
                Container(
                    padding: EdgeInsets.only(top: 10, right: 0),
                    child: Text('3 € ',
                        style: TextStyle(
                            color: kTextColor,
                            fontSize: 15.0,
                            fontFamily: 'AvenirLight')))
              ],
            ),
          )
        ],
      ),
    );
  }
}
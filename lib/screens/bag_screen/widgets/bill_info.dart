

import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/models/ClotheBagModel.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingBillInfo extends StatefulWidget{
  final List<ClothesBag> clothes;
  final Function setAmount;

  const ShoppingBillInfo({Key key, this.clothes, this.setAmount}) : super(key: key);
  @override
  _ShoppingBillInfoState createState() => _ShoppingBillInfoState();
}

class _ShoppingBillInfoState extends State<ShoppingBillInfo> {
  String calculateTot(val) {
    double t = val;
    print(widget.clothes.length);
    for (var i = 0; i < widget.clothes.length; i++) {
      t += widget.clothes[i].price * widget.clothes[i].quantity;
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
                  child: Text(AppLocalizations.of(context).checkout_page_bill_title,
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
                  child: Text(AppLocalizations.of(context).checkout_page_cost_delivery_text,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 15.0,
                          fontFamily: 'AvenirLight'))),
              Container(
                  padding: EdgeInsets.only(top: 10, right: 10),
                  child: Text('3.50 € ',
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
                  child: Text(AppLocalizations.of(context).checkout_page_cost_clothes_text,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10, left: 30),
                  child: Text(AppLocalizations.of(context).checkout_page_discount_text,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 15.0,
                          fontFamily: 'AvenirLight'))),
              Container(
                  padding: EdgeInsets.only(top: 10, right: 10),
                  child: Text(' 0% ',
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
                    child: Text(AppLocalizations.of(context).checkout_page_bill_tot_text,
                        style: TextStyle(
                            color: kTextColor,
                            fontSize: 15.0,
                            fontFamily: 'AvenirLight'))),
                Container(
                    padding: EdgeInsets.only(top: 10, right: 0),
                    child: Text(this.calculateTot(3.50) + '  € ',
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
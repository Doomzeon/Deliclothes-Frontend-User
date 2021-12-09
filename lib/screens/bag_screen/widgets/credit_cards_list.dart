

import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/models/cards_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreditCardsList extends StatefulWidget{
  final Function setCreditCard;
  final List<CardsInfo> cards;
  
  const CreditCardsList({Key key, this.setCreditCard, this.cards}) : super(key: key);
  @override
  _CreditCardsListState createState() => _CreditCardsListState();
}

class _CreditCardsListState extends State<CreditCardsList> {
  int groupValueCard = 1;
  var valueIn=1;

  @override
  Widget build(BuildContext context) {
    rebuildPaymentsContainer(value) {
      setState(() {
        this.groupValueCard = value;
      });
    }

    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 220,
      //color: Colors.orange,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, left: 30),
                child: Text(AppLocalizations.of(context).checkout_page_card_text,
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 18.0,
                        fontFamily: 'AvenirLight')),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...widget.cards.map((e) => CardInfoContainer(
                      cardCode: e.lastNum,
                      cardType: e.card_type == 'card'
                          ? 'assets/images/mastercard.png'
                          : 'assets/images/visa.png',
                      valueIn: e.idCard,
                      idCard:e.idCard,
                      groupValueCard: this.groupValueCard,
                      rebuildPaymentsContainer: rebuildPaymentsContainer,
                      setCreditCard: widget.setCreditCard,),),
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
    
  }
}

class CardInfoContainer extends StatefulWidget {
  final String cardType;
  final int valueIn, idCard;
  final int groupValueCard;
  final String cardCode;
  final setCreditCard;
  final rebuildPaymentsContainer;
  const CardInfoContainer({
    Key key,
    this.cardType,
    this.valueIn,
    this.groupValueCard,
    this.rebuildPaymentsContainer,
    this.cardCode,
    this.setCreditCard,
    this.idCard,
  }) : super(key: key);

  @override
  _CardInfoContainerState createState() => _CardInfoContainerState(
      this.valueIn,
      this.groupValueCard,
      this.cardType,
      this.rebuildPaymentsContainer,
      this.cardCode,
      this.setCreditCard,
      this.idCard);
}

class _CardInfoContainerState extends State<CardInfoContainer> {
  final int valueIn,idCard;
  int groupValueCard;
  final rebuildPaymentsContainer;
  final String cardType;
  final String cardCode;
  final setCreditCard;


  _CardInfoContainerState(
      this.valueIn,
      this.groupValueCard,
      this.cardType,
      this.rebuildPaymentsContainer,
      this.cardCode,
      this.setCreditCard,
      this.idCard);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('rebuild' + this.groupValueCard.toString());

    if (valueIn == this.groupValueCard) {
      this.setCreditCard(this.idCard);
    }
    return Container(
      width: 330,
      height: 70,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 20.0, color: Colors.grey[400], offset: Offset(0, 0))
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        // color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              // color: Colors.white,
            ),
            child: Image.asset(
              this.widget.cardType,
              width: 5,
              height: 5,
            ),
          ),
          Container(
            child: Text(
                '**** **** **** ' +
                    this.cardCode.substring(this.cardCode.length - 4),
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 15,
                    fontFamily: 'AvenirLight')),
          ),
          Container(
            child: Radio(
              onChanged: (value) => {
                setState(() => {
                      super.setState(() {
                        this.groupValueCard = value;
                        if (valueIn == this.groupValueCard) {
                          this.setCreditCard(this.idCard);
                        }
                        this.rebuildPaymentsContainer(value);
                      })
                    })
              },
              value: valueIn,
              groupValue: widget.groupValueCard,
            ),
          )
        ],
      ),
    );
  }
}
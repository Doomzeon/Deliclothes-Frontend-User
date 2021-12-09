import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/models/cards_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RowAllCardsInfoContainer extends StatefulWidget {
   List<CardsInfo> cards;
  final int idUser;
   RowAllCardsInfoContainer({
    Key key, this.cards, this.idUser,
  }) : super(key: key);

  @override
  _RowAllCardsInfoContainerState createState() =>
      _RowAllCardsInfoContainerState();
}

class _RowAllCardsInfoContainerState extends State<RowAllCardsInfoContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Container(
              width: size.width - 50,
              height: 250,
              //color: Colors.orange,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...widget.cards.map((e) => 
                    CreditCardBox(
                      cardNumber: e.lastNum,
                      cardType: e.card_type,
                      remove:() => {
                        BlocProvider.of<UserBloc>(context).add(
                            UserRemoveCard(e.idCard, widget.idUser)),
                            
                        widget.cards.removeWhere((element) => element.idCard==e.idCard),
                        setState(()=>{
                         super.setState(() {
                           
                         })
                          })
                      }
                    )
                    )
                    
                    ],
                ),
              )),
        ),
      ],
    );
  }
}

class CreditCardBox extends StatefulWidget {
  final String cardType, cardNumber; 
  final remove;
  //final CreditCard cardInfo;
  const CreditCardBox({
    Key key,
    //this.cardInfo,
    this.remove, this.cardType, this.cardNumber,
  }) : super(key: key);

  @override
  _CreditCardBoxState createState() => _CreditCardBoxState();
}

class _CreditCardBoxState extends State<CreditCardBox> {
  @override
  Widget build(BuildContext context) {
   /* */ 

    /* End modal */
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
              widget.cardType == 'visa'
                  ? 'assets/images/visa.png'
                  : 'assets/images/mastercard.png',
              width: 5,
              height: 5,
            ),
          ),
          Container(
            child: Text('**** **** ****  '+widget.cardNumber,
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 15,
                    fontFamily: 'AvenirLight')),
          ),
          GestureDetector(
            onTap: widget.remove,
            child: Container(
              child: Icon(
                Icons.delete,
                color: kTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}


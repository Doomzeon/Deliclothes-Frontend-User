import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/models/cards_info.dart';
import 'package:deliclothes_flutter/models/credit_card.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/row_credit_cards_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CreditCardsUserContainer extends StatefulWidget {
  List<CardsInfo> cards;
  final int idUser;

  CreditCardsUserContainer({Key key, this.cards, this.idUser})
      : super(key: key);
  @override
  _CreditCardsUserContainerState createState() =>
      _CreditCardsUserContainerState();
}

class _CreditCardsUserContainerState extends State<CreditCardsUserContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    addCard(CardsInfo data) {
      print(data);
      widget.cards.add(data);
      setState(() {});
    }

    showAlertDialogCreditCard(BuildContext context) {
      PaymentCard _paymentCard = new PaymentCard();

      // set up the buttons
      Widget cancelButton = FlatButton(
        child: Text(AppLocalizations.of(context).settings_page_my_account_close_card_modal_button),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      Widget confirmButton = FlatButton(
        child: Text(AppLocalizations.of(context).settings_page_my_account_confirm_card_modal_button),
        onPressed: () async {
          setState(() {
            //creditCardBox.add(CreditCardBox());
            BlocProvider.of<UserBloc>(context)
                .add(UserAddNewCard(_paymentCard, widget.idUser, addCard));
            ;
            // super.setState(() {widget.updatePar();});
          });
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(AppLocalizations.of(context).settings_page_my_account_add_card_modal_title),
        actions: [cancelButton, confirmButton],
        content: Container(
          width: size.width,
          height: 200,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      //margin: EdgeInsets.only(left: 40, top: 5),
                      width: size.width*0.65,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //card number start

                            TextFormField(
                                onChanged: (String value) {
                                  _paymentCard.number = value;
                                  print(_paymentCard.number);
                                  setState(() {});
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  new LengthLimitingTextInputFormatter(19),
                                  new CardNumberInputFormatter()
                                ],
                                validator:
                                    CardUtils.validateCardNumWithLuhnAlgorithm,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 13.0,
                                    fontFamily: 'AvenirLight'),
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context).input_card_number,
                                  hintStyle: TextStyle(
                                      color: kTextColor,
                                      fontSize: 11.0,
                                      fontFamily: 'AvenirLight'),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: kTextColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: kTextColor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: kTextColor),
                                  ),
                                )),
                            //card number end

                            //Data end start

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  width: 40,
                                  height: 40,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      List<int> expiryDate =
                                          CardUtils.getExpiryDate(value);
                                      _paymentCard.month = expiryDate[0];
                                      _paymentCard.year = expiryDate[1];
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(4),
                                      new CardMonthInputFormatter()
                                    ],
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontSize: 13.0,
                                        fontFamily: 'AppleBraille'),
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context).input_card_date,
                                      hintStyle: TextStyle(
                                          color: kTextColor,
                                          fontSize: 11.0,
                                          fontFamily: 'AppleBraille'),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: kTextColor),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: kTextColor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: kTextColor),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  width: 40,
                                  height: 40,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      _paymentCard.cvv = int.parse(value);
                                      print(_paymentCard.cvv);
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(4)
                                    ],
                                    validator: CardUtils.validateCVV,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontSize: 13.0,
                                        fontFamily: 'AppleBraille'),
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context).input_card_cvc,
                                      hintStyle: TextStyle(
                                          color: kTextColor,
                                          fontSize: 11.0,
                                          fontFamily: 'AppleBraille'),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: kTextColor),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: kTextColor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: kTextColor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            //Data end end
                            TextFormField(
                              onChanged: (String value) {
                                _paymentCard.owner = value;
                                print(_paymentCard.number);
                                setState(() {});
                              },
                              style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 13.0,
                                  fontFamily: 'AvenirLight'),
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context).input_card_owner,
                                hintStyle: TextStyle(
                                    color: kTextColor,
                                    fontSize: 11.0,
                                    fontFamily: 'AvenirLight'),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kTextColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kTextColor),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kTextColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Row(children: [
      Container(
        width: size.width,
        height: 430,
        //color: Colors.green,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20, left: size.width * 0.05),
                    child: Text(
                      AppLocalizations.of(context).settings_page_my_account_card_section_title,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 18.0,
                          fontFamily: 'AvenirLight'),
                    ))
              ],
            ),
            RowAllCardsInfoContainer(
              cards: widget.cards,
              idUser: widget.idUser,
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20.0,
                          color: Colors.grey[400],
                          offset: Offset(0, 0))
                    ], //Color(0xfff9de2e),
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => {showAlertDialogCreditCard(context)}))
          ],
        ),
      )
    ]);
  }
}

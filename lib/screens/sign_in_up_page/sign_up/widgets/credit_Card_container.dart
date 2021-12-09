import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/models/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreditCardRow extends StatefulWidget {
  final Function callBackFunctionNumberCard,
      callBackFunctionYear,
      callBackFunctionMonth,
      callBackFunctionCvv,
      callBackOwner;
  const CreditCardRow({
    Key key,
    this.callBackFunctionNumberCard,
    this.callBackFunctionYear,
    this.callBackFunctionMonth,
    this.callBackFunctionCvv,
    this.callBackOwner,
  }) : super(key: key);

  @override
  _CreditCardRowState createState() => _CreditCardRowState();
}

class _CreditCardRowState extends State<CreditCardRow> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 40, top: 5),
            width: size.width *0.80,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage('assets/images/card.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 30.0, color: kTextColor, offset: Offset(0, 0))
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        new LengthLimitingTextInputFormatter(19),
                        new CardNumberInputFormatter()
                      ],
                      validator: CardUtils.validateCardNumWithLuhnAlgorithm,
                      //controller: cardController,
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        // _paymentCard.number = value;
                        // print(_paymentCard.number);
                        setState(() {
                          widget.callBackFunctionNumberCard(value);
                        });
                      },
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                          fontFamily: 'AvenirLight'),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).input_card_number,
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 11.0,
                            fontFamily: 'AvenirLight'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new LengthLimitingTextInputFormatter(4),
                            new CardMonthInputFormatter()
                          ],
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            List<int> expiryDate =
                                CardUtils.getExpiryDate(value);
                            setState(() {
                              widget.callBackFunctionYear(expiryDate[1]);
                              widget.callBackFunctionMonth(expiryDate[0]);
                            });
                          },
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontFamily: 'AppleBraille'),
                          decoration: InputDecoration(
                            hintText:  AppLocalizations.of(context).input_card_date,
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 11.0,
                                fontFamily: 'AppleBraille'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        width: 40,
                        height: 40,
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new LengthLimitingTextInputFormatter(4)
                          ],
                          validator: CardUtils.validateCVV,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              widget.callBackFunctionCvv(int.parse(value));
                            });
                            //  _paymentCard.cvv =
                            //      int.parse(value);
                            //  print(_paymentCard.cvv);
                          },
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 13.0,
                              fontFamily: 'AppleBraille'),
                          decoration: InputDecoration(
                            hintText:  AppLocalizations.of(context).input_card_cvc,
                            hintStyle: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 11.0,
                                fontFamily: 'AppleBraille'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  //Data end end
                  TextFormField(
                    onChanged: (String value) {
                      //_paymentCard.owner = value;
                      //print(_paymentCard.number);
                      setState(() {
                        widget.callBackOwner(value);
                      });
                    },
                    style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 13.0,
                        fontFamily: 'AvenirLight'),
                    decoration: InputDecoration(
                      hintText:  AppLocalizations.of(context).input_card_owner,
                      hintStyle: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 11.0,
                          fontFamily: 'AvenirLight'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

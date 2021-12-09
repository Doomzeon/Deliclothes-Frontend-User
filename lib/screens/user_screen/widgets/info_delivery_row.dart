import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/models/order_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoDeliveryRow extends StatefulWidget {
  final String text, iconPath;

  const InfoDeliveryRow({
    Key key,
    this.text,
    this.iconPath,
  }) : super(key: key);

  @override
  _InfoDeliveryRowState createState() => _InfoDeliveryRowState();
}

class _InfoDeliveryRowState extends State<InfoDeliveryRow> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            //  color: Colors.orange,
            width: size.width * 0.105,
            height: size.width * 0.105,
            child: Container(
              //color: Colors.orange,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20.0,
                      color: Colors.grey[400],
                      offset: Offset(0, 0))
                ],
                borderRadius: BorderRadius.all(Radius.circular(35)),
              ),
              child: SvgPicture.asset(widget.iconPath, width: 25),
            ),
          ),
          Container(
            width: size.width * 0.7,
            height: size.width * 0.1,
            //  color: Colors.green,
            padding: EdgeInsets.only(left: 30, top: size.width * 0.03),
            child: Text(
              widget.text,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14.0,
                  fontFamily: 'AvenirLight'),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}

class InfoDeliveryRowCourier extends StatefulWidget {
  final String text, iconPath;

  const InfoDeliveryRowCourier({Key key, this.text, this.iconPath})
      : super(key: key);
  @override
  _InfoDeliveryRowCourierState createState() => _InfoDeliveryRowCourierState();
}

class _InfoDeliveryRowCourierState extends State<InfoDeliveryRowCourier> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            //  color: Colors.orange,
            width: size.width * 0.105,
            height: size.width * 0.105,
            child: Container(
              //color: Colors.orange,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20.0,
                      color: Colors.grey[400],
                      offset: Offset(0, 0))
                ],
                borderRadius: BorderRadius.all(Radius.circular(35)),
              ),
              child: SvgPicture.asset(widget.iconPath, width: 25),
            ),
          ),
          Container(
            width: size.width * 0.5,
            height: size.width * 0.1,
            //  color: Colors.green,
            padding: EdgeInsets.only(left: 30, top: size.width * 0.03),
            child: Text(
              widget.text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontFamily: 'AvenirLight'),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: size.width * 0.105,
            height: size.width * 0.105,
            child: GestureDetector(
              onTap: () => {
                print('calling'), 
                cutomLaunch("tel:+39 335 153 9690"),
                },
              child: Container(
                //color: Colors.orange,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 20.0,
                        color: Colors.grey[400],
                        offset: Offset(0, 0))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
                child: SvgPicture.asset(
                  'assets/icons/phone-call.svg',
                  width: 25,
                  color: kTextFilterTypeColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

cutomLaunch(command) async{
  if(await canLaunch(command)){
    await launch(command);
  } else{
    print('Errore $command');
  }

}
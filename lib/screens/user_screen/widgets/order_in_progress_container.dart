import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/models/order_info.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/info_delivery_row.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/map_rider_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderInProgressDeepInfo extends StatefulWidget {
  final OrderInfo order;

  const OrderInProgressDeepInfo({Key key, this.order}) : super(key: key);
  @override
  _OrderInProgressDeepInfoState createState() =>
      _OrderInProgressDeepInfoState();
}

class _OrderInProgressDeepInfoState extends State<OrderInProgressDeepInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: [
          MapRiderContainer(size: size),
          InfoDeliveryRow(
      iconPath: 'assets/icons/history.svg',
      text: AppLocalizations.of(context).settings_page_allorders_order_in_progress_time_text +
        widget.order.endTime +
        ' ' +
        widget.order.day,
          ),
          InfoDeliveryRow(
      iconPath: 'assets/icons/location.svg',
      text: widget.order.streetDelivery,
          ),
          InfoDeliveryRowCourier(
      iconPath: 'assets/icons/delivery-courier.svg',
      text: AppLocalizations.of(context).settings_page_allorders_order_in_progress_call_courier_text,
          ),
          Row(
      children: [
      GestureDetector(
        onTap: () => {Navigator.pop(context)},
        child: Container(
            margin: EdgeInsets.only(top: 15),
            width: size.width,
            height: 70,
            child: Stack(children: [
              Positioned(
                top: 5,
                left: size.width * 0.29,
                child: Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(40)),
                  width: 180,
                  height: 45,
                  child: Center(
                    child: Text(AppLocalizations.of(context).settings_page_allorders_order_in_progress_back_button,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            fontFamily: 'AvenirLight')),
                  ),
                ),
              ),
            ])),
      )
      ],
          )
          /*Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      IconButton(
      icon: SvgPicture.asset('assets/icons/left-arrow.svg',
        width: 20, color: kTextColor),
      onPressed: () {
      Navigator.pop(context);
      },
          )
          ],)*/
        ]),
    );
  }
}

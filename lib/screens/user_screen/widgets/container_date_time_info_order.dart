
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/models/order_info.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/order_deep_info.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/order_in_progress_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContainerDateTimeInfoOrdersDelivery extends StatefulWidget {
  final String day, timeEnd;
  final double check;
  final String courierPhone;
  final int orderId;
  final OrderInfo order;
  final Size size;

  const ContainerDateTimeInfoOrdersDelivery({
    Key key,
    @required this.size,
    this.day,
    this.timeEnd,
    this.check,
    this.orderId, this.courierPhone, this.order,
  }) : super(key: key);


  @override
  _ContainerDateTimeInfoOrdersDeliveryState createState() =>
      _ContainerDateTimeInfoOrdersDeliveryState();
}

class _ContainerDateTimeInfoOrdersDeliveryState
    extends State<ContainerDateTimeInfoOrdersDelivery> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            //padding: EdgeInsets.only(top:15),
            width: widget.size.width * 0.30,
            height: 100,
            //color: Colors.green,
            child: Text(widget.day == null ? '' : widget.day,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: 'AvenirLight')),
          ),
          GestureDetector(
            onTap: () => {
              
        if (widget.order.status == 1 ||
            widget.order.status == 3)
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<UserBloc>(context),
                          child: OrderInProgressDeepInfo(order:widget.order),
                        )))
        else
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<UserBloc>(context),
                          child: OrderDeepInfo(orderId:widget.order.idOrder,amount: widget.order.amount,),
                        )))
          }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: widget.order.status == 1 ||
            widget.order.status == 3?Color(0xffEEEEF5):kTextColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              padding: EdgeInsets.only(top: widget.size.width * 0.05),
              width: widget.size.width * 0.70,
              height: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text('#' + widget.orderId.toString(),
                            style: TextStyle(
                                color: widget.order.status == 1 ||
            widget.order.status == 3?Color(0xff505165):Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                fontFamily: 'AvenirLight')),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 25),
                        child: Row(
                          children: [
                            Icon(Icons.av_timer_outlined,
                                color: widget.order.status == 1 ||
            widget.order.status == 3?Color(0xff505165):Colors.white),
                            Text(widget.timeEnd,
                                style: TextStyle(
                                    color: widget.order.status == 1 ||
            widget.order.status == 3?Color(0xff505165):Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                    fontFamily: 'AvenirLight')),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, right: 15),
                        child: Text(widget.check.toString()+' €',
                            style: TextStyle(
                                color: widget.order.status == 1 ||
            widget.order.status == 3?Color(0xff505165):Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                fontFamily: 'AvenirLight')),
                      )
                    ],
                  )
                ],
              ),
              // color: Colors.orange,
            ),
          )
        ],
      ),
    );
  }
}

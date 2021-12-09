import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/models/order_info.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/order_deep_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_in_progress_container.dart';

class OrderContainer extends StatefulWidget {
  final OrderInfo order;
  const OrderContainer({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  _OrderContainerState createState() => _OrderContainerState();
}

class _OrderContainerState extends State<OrderContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => {
        if (widget.order.status.toString() == 'SEARCHING_COURIER' ||
            widget.order.status.toString() == 'DELIVERY_IN_PROGRESS')
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            width: size.width - 50,
            height: 110,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 20.0,
                  color:
                      widget.order.status.toString() == 'SEARCHING_COURIER' ||
                              widget.order.status.toString() ==
                                  'DELIVERY_IN_PROGRESS'
                          ? kTextFilterTypeColor
                          : kTextColor,
                  offset: Offset(0, 0))
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('#' + widget.order.idOrder.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontFamily: 'AvenirLight'))),
                  Container(
                      padding: EdgeInsets.only(right: 20, top: 10),
                      child: Text(
                          widget.order.status.toString() ==
                                      'SEARCHING_COURIER' ||
                                  widget.order.status.toString() ==
                                      'DELIVERY_IN_PROGRESS'
                              ? 'Consegna in corso'
                              : 'Consegnato',
                          style: TextStyle(
                              color: widget.order.status.toString() ==
                                          'SEARCHING_COURIER' ||
                                      widget.order.status.toString() ==
                                          'DELIVERY_IN_PROGRESS'
                                  ? kTextFilterTypeColor
                                  : Colors.black,
                              fontSize: 15.0,
                              fontFamily: 'AvenirLight')))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('widget.order.street.toString()',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontFamily: 'AvenirLight'))),
                  Container(
                      padding: EdgeInsets.only(right: 20, top: 10),
                      child: Text(widget.order.city.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontFamily: 'AvenirLight')))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('widget.order.hour.toString()',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontFamily: 'AvenirLight'))),
                  Container(
                      padding: EdgeInsets.only(right: 20, top: 10),
                      child: Text(widget.order.day.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontFamily: 'AvenirLight')))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('widget.order.quantity.toString()' + ' vestiti',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontFamily: 'AvenirLight'))),
                  Container(
                      padding: EdgeInsets.only(right: 20, top: 10),
                      child: Text(
                          'Totale: ' + widget.order.amount.toString() + ' €',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontFamily: 'AvenirLight')))
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}

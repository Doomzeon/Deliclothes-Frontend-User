import 'package:deliclothes_flutter/models/order_info.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/container_date_time_info_order.dart';
import 'package:flutter/material.dart';

class MonthOrdersContainer extends StatefulWidget {
  final List<ArrayOrders> orders;
  final int idUser;

  const MonthOrdersContainer({Key key, this.orders, this.idUser})
      : super(key: key);
  @override
  _MonthOrdersContainerState createState() => _MonthOrdersContainerState();
}

class _MonthOrdersContainerState extends State<MonthOrdersContainer> {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(children: [
        ...widget.orders.map((e) => Container(
              child: Column(
                children: [
                  MonthDeliveryRow(size: size, month: e.orders[0].month),
                  ...e.orders.map((d) => ContainerDateTimeInfoOrdersDelivery(
                          courierPhone: d.courierPhone,
                          size: size,
                          day: d.day,
                          orderId: d.idOrder,
                          timeEnd: d.endTime,
                          check: d.amount,
                          order: d,
                        )
                  )
                ],
              ),
            ))
      ]),
    );
  }
}

class MonthDeliveryRow extends StatelessWidget {
  const MonthDeliveryRow({
    Key key,
    @required this.size,
    this.month,
  }) : super(key: key);

  final Size size;
  final String month;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: EdgeInsets.only(
                top: size.width * 0.05, left: size.width * 0.04),
            child: Text(month,
                style: TextStyle(
                    color: Color(0xff505165),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: 'AvenirLight')))
      ],
    );
  }
}

import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:equatable/equatable.dart';

class ArrayOrders extends Equatable {

  final List<OrderInfo> orders;

  ArrayOrders(this.orders);

  static ArrayOrders fromJson(dynamic data) {
    print(data);
    List<OrderInfo> orders = List<OrderInfo>.from(
      data.map((e)=>
        OrderInfo.fromJson(e)
      )
    );
    return ArrayOrders(orders);
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}


class OrderInfo extends Equatable {
  OrderInfo(this.status, this.idOrder, this.cap, this.endTime, this.date, this.month, this.streetDelivery, this.city, this.day, this.courierPhone, this.amount, this.quantity);

  

  @override
  // TODO: implement props
  //List<Object> get props => throw UnimplementedError();
  
  final int status, idOrder, cap, quantity;
  final double amount;
  final String  endTime, date, month, streetDelivery, city, day, courierPhone;
  //final List<ClothesData> clothes;

  static OrderInfo fromJson(dynamic data) {
    
    OrderInfo a = OrderInfo(
        data['status'] as int,
        data['id_order'] as int,
        data['cap'] as int,
        data['end_time'] as String,
        data['date'] as String,
        data['month'] as String,
        data['street_delivery'] as String,
        data['city'] as String,
        data['day'] as String,
        data['courier_phone'] as String,
        data['amount'] as double,
        data['quantity'] as int
        );
        print(a);
        return a;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}

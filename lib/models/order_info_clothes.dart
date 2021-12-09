

import 'package:equatable/equatable.dart';

class OrderInfoClothes extends Equatable{
  OrderInfoClothes(this.idClothe, this.image, this.title, this.size, this.brand, this.qunatity, this.cost, this.orderId);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  final String image, title, size, brand;
  final int qunatity,idClothe;
  final double cost;
  final int orderId;




  static OrderInfoClothes fromJson(dynamic data) {
    print(data['id'].runtimeType);
    return OrderInfoClothes(
      data['id'] as int,
      data['firstImage'] as String,
      data['title'] as String,
      data['size'] as String,
      data['brand'] as String,
      data['quantity'] as int,
      data['cost'] as double,
      data['id_order']==null?null:data['id_order'] as int
    );
  }

}
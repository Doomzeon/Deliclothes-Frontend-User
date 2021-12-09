


import 'package:equatable/equatable.dart';

class ClothesPoster extends Equatable{

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  String brand, title, img, id;
  bool liked;
  double price, oldPrice;
  //int discountPercentage
  ClothesPoster(this.brand, this.title, this.liked, this.price, this.img, this.id, this.oldPrice);


  static ClothesPoster fromJson(dynamic data){
    return ClothesPoster(
      data['brand'] as String,
      data['title'] as String,
      data['liked'] as bool,
      data['price'] as double,
      data['img'] as String,
      data['id'] as String,
      data['old_price'] as double
    );
  }

}
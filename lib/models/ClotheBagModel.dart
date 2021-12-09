import 'package:equatable/equatable.dart';

class ClothesBag extends Equatable {
  ClothesBag(
      this.brand, this.title, this.img, this.id, this.quantity, this.price, this.sizeSelected);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

   String brand, title,id, img, sizeSelected;
   int  quantity;
   double price;

  int setQuantity(int q){
    this.quantity = q;
  }

  static ClothesBag fromJson(dynamic data) {
    return ClothesBag(
        data['brand'] as String,
        data['title'] as String,
        data['img'] as String,
        data['id'] as String,
        data['quantity'] as int,
        data['price'] as double,
        data['size'] as String);
  }
}

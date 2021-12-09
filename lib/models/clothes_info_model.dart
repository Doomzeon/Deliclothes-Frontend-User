import 'package:equatable/equatable.dart';

class ClothesData extends Equatable{
  String _title, _description, _type, _imageFirst, _brandName, _oldPrice, _sizeSelected ;
  int  _id, _discountPercentage, _quantity;
  List<String> _sizes, _images;
  List<String> _otherImages;
  List<ClothesData> _otherColors;
  bool _liked;
  List<ColorsOBJ> _colors;
  double _price;
  

  ClothesData(this._id, this._title, this._description, this._type, this._imageFirst,
      this._brandName, this._price, this._liked, this._oldPrice, this._discountPercentage, this._colors, this._images, this._sizes, this._sizeSelected, this._quantity);//,this._otherImages);//, this._otherColors, this._sizes, );

  double getPrice() {
    return _price;
  }

  String setSizeSelected(String size){
    this._sizeSelected = size;
  }

  int setQuantity(int newQuan){
    this._quantity = newQuan;
  }

  String getTitle() {
    return _title;
  }
  String getOldPrice() {
    return _oldPrice;
  }

  String getDescription() {
    return _description;
  }
  String getSizeSelected(){
    return _sizeSelected;
  }
  String getType() {
    return _type;
  }

  String getImageFirst() {
    return _imageFirst;
  }

  List<String> getOtherImages() {
    return _otherImages;
  }

  String getBrandName() {
    return _brandName;
  }

  List<ClothesData> getOtherColors() {
    return _otherColors;
  }

  List<String> getSizes() {
    return _sizes;
  }
  List getColors(){
    return _colors;
  }

  List getImages(){
    return _images;
  }

  bool isLiked(){
    return _liked;
  }

  int getId(){
    return _id;
  }
  int getDiscountPercentage(){
    return _discountPercentage;
  }
  int getQuantity(){
    return _quantity;
  }



  void setLiked(bool value){
    _liked = value;
  }

  static ClothesData fromJson(dynamic data){
    print('data');
    return  ClothesData(
      data['id_product'] as int,
      data['title'] as String,
      data['description']as String,
      data['type']as String,
      data['image_poster']as String,
      data['brand_name']as String,
      data['price']as double,
      data['user_liked'] as bool,
      data['old_price'] as String,
      data['discountPercentage'] as int,
      List<ColorsOBJ>.from(data['colors'].map((d)=> ColorsOBJ.fromJson(d))),
      List<String>.from(data['images']),
      List<String>.from(data['sizes']),
      data['size_selected']==''?data['sizes'][0]:data['size_selected'] as String,
      data['quantity'] as int
            
            //data['sizes'].cast<String>()
          );
        }
      
        /*static List<ClothesData> fetchAll() {
            return [
                  ClothesData('T-SHIRT BASIC SCOLLO A V', 'JOIN LIFE Care for fiber: 100% cotone organico. Cotone coltivato utilizzando fertilizzanti e pesticidi naturali Inoltre, nella sua coltivazione non vengono utilizzate sementi  geneticamente modificate, aiutando a conservare la biodiversità  dei semi e la fertilità del terreno.', 'New In', 'assets/images/t-shirt-1.jpg', 'Zara', 17, true),
                  ClothesData('T-SHIRT BASIC SCOLLO A V', 'JOIN LIFE Care for fiber: 100% cotone organico. Cotone coltivato utilizzando fertilizzanti e pesticidi naturali Inoltre, nella sua coltivazione non vengono utilizzate sementi  geneticamente modificate, aiutando a conservare la biodiversità  dei semi e la fertilità del terreno.', 'New In', 'assets/images/t-shirt-1.jpg', 'Zara', 17, true),
                  ClothesData('T-SHIRT BASIC SCOLLO A V', 'JOIN LIFE Care for fiber: 100% cotone organico. Cotone coltivato utilizzando fertilizzanti e pesticidi naturali Inoltre, nella sua coltivazione non vengono utilizzate sementi  geneticamente modificate, aiutando a conservare la biodiversità  dei semi e la fertilità del terreno.', 'New In', 'assets/images/t-shirt-1.jpg', 'Zara', 17, true),
                  ClothesData('T-SHIRT BASIC SCOLLO A V', 'JOIN LIFE Care for fiber: 100% cotone organico. Cotone coltivato utilizzando fertilizzanti e pesticidi naturali Inoltre, nella sua coltivazione non vengono utilizzate sementi  geneticamente modificate, aiutando a conservare la biodiversità  dei semi e la fertilità del terreno.', 'New In', 'assets/images/t-shirt-1.jpg', 'Zara', 17, true),
                  ClothesData('T-SHIRT BASIC SCOLLO A V', 'JOIN LIFE Care for fiber: 100% cotone organico. Cotone coltivato utilizzando fertilizzanti e pesticidi naturali Inoltre, nella sua coltivazione non vengono utilizzate sementi  geneticamente modificate, aiutando a conservare la biodiversità  dei semi e la fertilità del terreno.', 'New In', 'assets/images/t-shirt-1.jpg', 'Zara', 17, false),
                  ClothesData('T-SHIRT BASIC SCOLLO A V', 'JOIN LIFE Care for fiber: 100% cotone organico. Cotone coltivato utilizzando fertilizzanti e pesticidi naturali Inoltre, nella sua coltivazione non vengono utilizzate sementi  geneticamente modificate, aiutando a conservare la biodiversità  dei semi e la fertilità del terreno.', 'New In', 'assets/images/t-shirt-1.jpg', 'Zara', 17, false),
                  ClothesData('T-SHIRT BASIC SCOLLO A V', 'JOIN LIFE Care for fiber: 100% cotone organico. Cotone coltivato utilizzando fertilizzanti e pesticidi naturali Inoltre, nella sua coltivazione non vengono utilizzate sementi  geneticamente modificate, aiutando a conservare la biodiversità  dei semi e la fertilità del terreno.', 'New In', 'assets/images/t-shirt-1.jpg', 'Zara', 17, false),
                  ClothesData('T-SHIRT BASIC SCOLLO A V', 'JOIN LIFE Care for fiber: 100% cotone organico. Cotone coltivato utilizzando fertilizzanti e pesticidi naturali Inoltre, nella sua coltivazione non vengono utilizzate sementi  geneticamente modificate, aiutando a conservare la biodiversità  dei semi e la fertilità del terreno.', 'New In', 'assets/images/t-shirt-1.jpg', 'Zara', 17, false),
            ];
        }*/
      
        @override
        // TODO: implement props
        List<Object> get props => [];
      
      }
      
      class ColorsOBJ {
        String color_hex;
        String image_poster;
        ColorsOBJ(this.color_hex,this.image_poster);
        
  static ColorsOBJ fromJson(dynamic data){
    print(data);
    return  ColorsOBJ(data['color_hex'] as String,data['image_poster'] as String);
    }

}

import 'package:equatable/equatable.dart';

class PostersHomePage extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  String _brand, _description, _imagePoster;

  PostersHomePage(this._brand, this._description, this._imagePoster);

  String getBrand(){
    return this._brand;
  }
  String getDescription(){
    return this._description;
  }
  String getImg(){
    return this._imagePoster;
  }

  static PostersHomePage fromJson(dynamic data){
    print(data);
    return  PostersHomePage(
      data['brand'] as String,
      data['description']as String,
      data['img']as String
    );
  }

}
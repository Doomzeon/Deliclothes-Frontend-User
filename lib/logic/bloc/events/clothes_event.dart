
import 'package:equatable/equatable.dart';


abstract class ClothesEvent extends Equatable{
  const ClothesEvent();
}

class ClothesRequestedByBrand extends ClothesEvent {
  final String _brand;

  ClothesRequestedByBrand(this._brand);
  @override
  // TODO: implement props
  List<Object> get props => [_brand];

}

class ClothesRequestLiked extends ClothesEvent {
  final int idUser;
  final String language;

  ClothesRequestLiked(this.idUser, this.language);
  @override
  // TODO: implement props
  List<Object> get props => [idUser];

}

class ClothesRequestByGenderAndType extends ClothesEvent {
  final String gender;
  final String typeClothes;
  final int id_user;
  final String language;

  ClothesRequestByGenderAndType(this.gender, this.typeClothes, this.id_user, this.language);
  @override
  // TODO: implement props
  List<Object> get props => [gender,typeClothes];

}

class ClothesRequestedByBrandAndType extends ClothesEvent {
  final String brand;
  final String typeClothes;
  final int id_user;

  ClothesRequestedByBrandAndType(this.brand, this.typeClothes, this.id_user);
  @override
  // TODO: implement props
  List<Object> get props => [brand,typeClothes, id_user];

}

class ClothesRequestedHomePagePosters extends ClothesEvent {

  ClothesRequestedHomePagePosters();
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class ClothesUsernameDislikeClothe extends ClothesEvent {
  final String username;
  final String clotheCode;

  ClothesUsernameDislikeClothe(this.username, this.clotheCode);
  @override
  // TODO: implement props
  List<Object> get props => [clotheCode, username];

}

class ClothesUsernameLikeClothe extends ClothesEvent {
  final String username;
  final String clotheCode;

  ClothesUsernameLikeClothe(this.username, this.clotheCode);
  @override
  // TODO: implement props
  List<Object> get props => [clotheCode, username];

}


class ClothesRequestedSimilar extends ClothesEvent {
  final int productId, idUser;
  final String brand;
  final String language;

  ClothesRequestedSimilar(this.productId, this.brand, this.idUser, this.language);
  @override
  // TODO: implement props
  List<Object> get props => [productId, brand];

}
class ClothesRequestedRecomended extends ClothesEvent {
  final int productId, idUser;
  final String brand;
  final String language;

  ClothesRequestedRecomended(this.productId, this.brand, this.idUser, this.language);
  @override
  // TODO: implement props
  List<Object> get props => [productId];

}


class ClothesInTheBag extends ClothesEvent{
  final String  jwt, language;
  final int id_user;

  ClothesInTheBag(this.id_user, this.jwt, this.language);
  @override
  // TODO: implement props
  List<Object> get props => [id_user, jwt];

}

class ClotheSelectInfo extends ClothesEvent{
  final String brand, id, language;
  final int idUser;

  ClotheSelectInfo(this.brand, this.id, this.idUser, this.language);
  @override
  // TODO: implement props
  List<Object> get props => [idUser, brand, id];

}



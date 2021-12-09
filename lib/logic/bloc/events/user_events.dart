import 'package:deliclothes_flutter/models/ClotheBagModel.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:deliclothes_flutter/models/confirm_order.dart';
import 'package:deliclothes_flutter/models/credit_card.dart';
import 'package:deliclothes_flutter/models/order_info_clothes.dart';
import 'package:deliclothes_flutter/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLogin extends UserEvent {
  final String username, password;

  UserLogin(this.username, this.password);
  @override
  // TODO: implement props
  List<Object> get props => [username, password];
}
class UserLoginInitialState extends UserEvent{
  UserLoginInitialState();
  @override
  // TODO: implement props
  List<Object> get props => [];

} 

class UserLogout extends UserEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UserRegister extends UserEvent {
  //final String username, password, streetName, country, cardNumber, cardTitle, cardDateEnd, cardOwner;
  //final int cvc, streetNumber, zipCode;
  final User user;
  UserRegister(this.user);
  //UserRegister(this.username, this.password, this.streetName, this.country, this.cardNumber, this.cardTitle, this.cardDateEnd, this.cardOwner, this.cvc, this.streetNumber, this.zipCode);
  @override
  // TODO: implement props
  //List<Object> get props => [cvc, streetNumber, zipCode,username, password, streetName, country, cardNumber, cardTitle, cardDateEnd, cardOwner];
  List<Object> get props => [user];
}


class UserLikedClothe extends UserEvent{
  final String   clotheId;
  final int id_user;

  UserLikedClothe(this.id_user, this.clotheId);
  @override
  // TODO: implement props
  List<Object> get props => [id_user, clotheId];

}
class UserDislikedClothe extends UserEvent{
  final String   clotheId;
  final int id_user;

  UserDislikedClothe(this.id_user, this.clotheId);
  @override
  // TODO: implement props
  List<Object> get props => [id_user, clotheId];

}


class UserAddOrder extends UserEvent{
  final ClothesData clothe;
  final int id_user;

  UserAddOrder(this.id_user, this.clothe); //TODO add size of clothe
  @override
  // TODO: implement props
  List<Object> get props => [id_user, clothe];

}

class UserProccedPayment extends UserEvent{
  final int idUser;
  final List<ClothesBag> orders;

  UserProccedPayment(this.idUser, this.orders);

  @override
  // TODO: implement props
  List<Object> get props => [idUser, orders];
}

class UserAddQuantityClothe extends UserEvent{
  final int id_user;
  final String id_clothe;

  UserAddQuantityClothe(this.id_clothe, this.id_user);

  @override
  // TODO: implement props
  List<Object> get props => [id_user, id_user];
}

class UserRemoveQuantityClothe extends UserEvent{
  final int id_user;
  final String id_clothe;

  UserRemoveQuantityClothe(this.id_clothe, this.id_user);

  @override
  // TODO: implement props
  List<Object> get props => [id_user, id_user];
}

class UserConfirmOrder extends UserEvent{
  final int idUser;
  final List<ClothesBag> clothesBag;
  final ConfirmOrder orderData;
  final String directions;

  UserConfirmOrder(this.idUser, this.clothesBag, this.orderData, this.directions);

  @override
  // TODO: implement props
  List<Object> get props => [idUser, clothesBag, orderData];

}

class UserAddNewCard extends UserEvent{
  final PaymentCard card;
  final int id_user;
  final addCard;

  UserAddNewCard(this.card, this.id_user,this.addCard);

  @override
  // TODO: implement props
  List<Object> get props => [card];
}

class UserRemoveCard extends UserEvent{
  final int id_user, id_card;

  UserRemoveCard(this.id_card,this.id_user,);

  @override
  // TODO: implement props
  List<Object> get props => [id_user, id_card];
}

class GetInfoUser extends UserEvent{
  final int idUser;

  GetInfoUser(this.idUser);
  @override
  // TODO: implement props
  List<Object> get props => [idUser];

}

class GetCardsUser extends UserEvent{
  final int idUser;

  GetCardsUser(this.idUser);
  @override
  // TODO: implement props
  List<Object> get props => [idUser];

}

class UserChangeName extends UserEvent{
  final int idUser;
  final String name;

  UserChangeName(this.idUser,this.name);
  @override
  // TODO: implement props
  List<Object> get props => [idUser, name];

}
class UserChangeSurname extends UserEvent{
  final int idUser;
  final String surname;

  UserChangeSurname(this.idUser,this.surname);
  @override
  // TODO: implement props
  List<Object> get props => [idUser, surname];

}
class UserChangeResidence extends UserEvent{
  final int idUser;
  final String residence;

  UserChangeResidence(this.idUser,this.residence);
  @override
  // TODO: implement props
  List<Object> get props => [idUser, residence];

}
class UserChangePhoneNumber extends UserEvent{
  final int idUser;
  final String phoneNumber;

  UserChangePhoneNumber(this.idUser,this.phoneNumber);
  @override
  // TODO: implement props
  List<Object> get props => [idUser, phoneNumber];

}

class UserSelectOrders extends UserEvent{
  final int idUser;

  UserSelectOrders(this.idUser);
  @override
  // TODO: implement props
  List<Object> get props => [idUser];
}

class UserGetInfoOrderDone extends UserEvent{
  final int idOrder;

  UserGetInfoOrderDone(this.idOrder);
  @override
  // TODO: implement props
  List<Object> get props => [idOrder];

}


class UserGetAllClothesToReturn extends UserEvent{
  final int idUser;

  UserGetAllClothesToReturn(this.idUser);
  @override
  // TODO: implement props
  List<Object> get props => [idUser];

}


class UserGetHourDateInitialOfReturningClothes extends UserEvent{
  final int idUser;
  final List<OrderInfoClothes> clothes;

  UserGetHourDateInitialOfReturningClothes(this.idUser, this.clothes);


  @override
  // TODO: implement props
  List<Object> get props => [idUser, clothes];

}


class UserConfirmOrderReturnClothes extends UserEvent{
  final int idUser;
  final List<OrderInfoClothes> clothes;
  final ConfirmOrder orderData;

  UserConfirmOrderReturnClothes(this.idUser, this.clothes, this.orderData);

  @override
  // TODO: implement props
  List<Object> get props => [idUser, clothes, orderData];

}

class UserChangeMainInfo extends UserEvent{
  final int idUser;
  final String name, surname, residence;
  final int phoneNumber;
  final String countryCode;

  UserChangeMainInfo(this.idUser, this.name, this.surname, this.residence, this.phoneNumber, this.countryCode);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
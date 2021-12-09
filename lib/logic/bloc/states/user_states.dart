import 'package:deliclothes_flutter/models/cards_info.dart';
import 'package:deliclothes_flutter/models/delivery_hour_date.dart';
import 'package:deliclothes_flutter/models/order_info.dart';
import 'package:deliclothes_flutter/models/order_info_clothes.dart';
import 'package:deliclothes_flutter/models/user.dart';
import 'package:deliclothes_flutter/models/user_info.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoginInProgress extends UserState {}

class UserNotLoggedIn extends UserState {}

class UserLoginSuccess extends UserState {
  final int userId;
  final bool loggedIn = false;
  UserLoginSuccess(this.userId);

  @override
  List<Object> get props => [userId];
}

class UserLoginFailed extends UserState {
  UserLoginFailed();

  @override
  List<Object> get props => [];
}

class UserRegisterInProgress extends UserState {}

class UserRegisterSuccess extends UserState {
  final User userData;
  final bool loggedIn = false;
  UserRegisterSuccess(this.userData);

  @override
  List<Object> get props => [userData];
}

class UserRegisterFailed extends UserState {
  final String messageError;
  UserRegisterFailed(this.messageError);

  @override
  List<Object> get props => [messageError];
}

class UserRegistrationInProgress extends UserState {}

class UserProccedPaymentLoadInProggres extends UserState {}

class UserProccedPaymentHouresDeliveryLoadedeSuccess extends UserState {
  final DeliveryHourDate hourInitialDelivery;
  UserProccedPaymentHouresDeliveryLoadedeSuccess(this.hourInitialDelivery);

  @override
  List<Object> get props => [hourInitialDelivery];
}

class UserProccedInitialPoint extends UserState {}

class UserAddQuantityCotheIntialState extends UserState {}

class UserAddQuantityCotheLoadInProgress extends UserState {}

class UserAddQuantityCotheSuccess extends UserState {}

class UserAddQuantityCotheFailed extends UserState {}

class UserRemoveQuantityCotheIntialState extends UserState {}

class UserRemoveQuantityCotheLoadInProgress extends UserState {}

class UserRemoveQuantityCotheSuccess extends UserState {}

class UserRemoveQuantityCotheFailed extends UserState {}

class UserConfirmOrderedInitialState extends UserState {}

class UserConfirmOrderedLoadInProgress extends UserState {}

class UserConfirmOrderedLoadedSucess extends UserState {}

class UserConfirmOrderedFailed extends UserState {}

class UserGetInformationInitialState extends UserState {}


class UserGetInformationLoadedFailure extends UserState{}
class UserGetInformationLoadedSuccess extends UserState {
  final UserInfo userData;

  UserGetInformationLoadedSuccess(this.userData);

  @override
  List<Object> get props => [userData];
}

class UserGetCardsInformationInitialState extends UserState {}

class UserGetCardsInformationLoadedSuccess extends UserState {
  final List<CardsInfo> cards;

  UserGetCardsInformationLoadedSuccess(this.cards);

  @override
  List<Object> get props => [cards];
}

class UserSelectOrdersInitialState extends UserState {}

class UserSelectOrdersLoadInProgress extends UserState {}
class UserSelectOrdersLoadFailure extends UserState{}
class UserSelectOrdersLoadedSuccess extends UserState {
  final List<ArrayOrders> orders;

  UserSelectOrdersLoadedSuccess(this.orders);
  @override
  List<Object> get props => [orders];
}

class UserSelectOrderInfoDoneInitialState extends UserState {}

class UserSelectOrderInfoDoneLoadInProgress extends UserState {}

class UserSelectOrderInfoDoneLoadedSuccess extends UserState {
  final List<OrderInfoClothes> clothes;

  UserSelectOrderInfoDoneLoadedSuccess(this.clothes);
  @override
  List<Object> get props => [clothes];
}
class UserSelectClothesToReturnDoneLoadFailure extends UserState{}
class UserSelectClothesToReturnInfoDoneInitialState extends UserState {}

class UserSelectClothesToReturnDoneLoadInProgress extends UserState {}

class UserSelectClothesToReturnDoneLoadedSuccess extends UserState {
  final List<OrderInfoClothes> clothes;

  UserSelectClothesToReturnDoneLoadedSuccess(this.clothes);
  @override
  List<Object> get props => [clothes];
}

class UserGetHourDateInitialOfReturningInitialState extends UserState {}

class UserGetHourDateInitialOfReturningLoadInProgress extends UserState {}

class UserGetHourDateInitialOfReturningLoadedSuccess extends UserState {
  final DeliveryHourDate hourInitialDelivery;

  UserGetHourDateInitialOfReturningLoadedSuccess(this.hourInitialDelivery);

  @override
  List<Object> get props => [hourInitialDelivery];
}

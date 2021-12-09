import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/logic/secure/local_storage.dart';
import 'package:deliclothes_flutter/logic/server/user_api.dart';
import 'package:deliclothes_flutter/models/cards_info.dart';
import 'package:deliclothes_flutter/models/delivery_hour_date.dart';
import 'package:deliclothes_flutter/models/order_info.dart';
import 'package:deliclothes_flutter/models/order_info_clothes.dart';
import 'package:deliclothes_flutter/models/user.dart';
import 'package:deliclothes_flutter/models/user_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(UserState initialState) : super(initialState);

  @override
  Stream<UserState> mapEventToState(event) async* {
    // TODO: implement mapEventToState
    if (event is UserLogin) {
      yield UserLoginInProgress();
      try {
        int _idUser = await UserApi().userLogin(event.password, event.username);
        LocalStorageSecure.setUser(_idUser);
        yield UserLoginSuccess(_idUser);
        onPressedNavItem(3);
      } catch (e) {
        print('An errore ocurring while executing sign in of user=>' +
            e.toString());
        yield UserLoginFailed();
      }
    } else if (event is UserRegister) {
      yield UserRegisterInProgress();
      try {
        final int _idUser = await UserApi().userRegister(event.user);
        LocalStorageSecure.setUser(_idUser);
        yield UserLoginSuccess(_idUser);
      } catch (e) {
        print('ERROR=>' + e.toString());
        yield UserRegisterFailed(e);
      }
    } else if (event is UserLikedClothe) {
      try {
        final String res = await UserApi()
            .userLikedClothe(event.id_user, event.clotheId);
      } catch (e) {
        print('ERROR=>' + e.toString());
        // yield UserRegisterFailed(e);
      }
    } else if (event is UserDislikedClothe) {
      try {
        final String res = await UserApi()
            .userDislikedClothe(event.id_user, event.clotheId);
      } catch (e) {
        print('ERROR=> ' + e.toString());
        //yield UserRegisterFailed(e);
      }
    } else if (event is UserAddOrder) {
      try {
        final String res = await UserApi().userAddOrder(
            event.id_user, event.clothe);
      } catch (e) {
        print('ERROR=>' + e.toString());
        //yield UserRegisterFailed(e);
      }
    } else if (event is UserProccedPayment) {
      yield UserProccedPaymentLoadInProggres();
      try {
        final DeliveryHourDate res = await UserApi()
            .calculateHoursOfDelivery(event.orders, event.idUser);
        print(res);
        yield UserProccedPaymentHouresDeliveryLoadedeSuccess(res);
      } catch (e) {
        print('excpetion');
        print(e);
        yield UserProccedInitialPoint();
      }
    } else if (event is UserAddQuantityClothe) {
      try {
        final String res =
            await UserApi().addQauntityClothe(event.id_clothe, event.id_user);
        print(res);
      } catch (e) {
        print('excpetion');
        print(e);
      }
    } else if (event is UserRemoveQuantityClothe) {
      try {
        final String res = await UserApi()
            .removeQauntityClothe(event.id_clothe, event.id_user);
        print(res);
      } catch (e) {
        print('excpetion');
        print(e);
      }
    } else if (event is UserConfirmOrder) {
      yield UserConfirmOrderedLoadInProgress();
      try {
        final String res = await UserApi()
            .confrimOrder(event.clothesBag, event.idUser, event.orderData, event.directions);
        print(res);
        yield UserConfirmOrderedLoadedSucess();
      } catch (e) {
        print('excpetion');
        print(e);
      }
    } else if (event is UserLogout) {
      yield UserNotLoggedIn();
    } else if (event is UserAddNewCard) {
      final String res =
          await UserApi().addNewCard(event.card, event.id_user, event.addCard);
      print(res);
    } else if (event is UserRemoveCard) {
      final String res =
          await UserApi().removeCard(event.id_card, event.id_user);
      // yield (UserLoginSuccess(res));

    } else if (event is GetInfoUser) {
      try {
        final UserInfo res = await UserApi().getInfoUser(event.idUser);
        print(res);
        yield UserGetInformationLoadedSuccess(res);
      } catch (e) {
        print('excpetion');
        print(e);
        yield UserGetInformationLoadedFailure();
      }
    } else if (event is GetCardsUser) {
      try {
        final List<CardsInfo> res = await UserApi().getCardsUser(event.idUser);
        print(res);
        yield UserGetCardsInformationLoadedSuccess(res);
      } catch (e) {
        print('excpetion');
        print(e);
      }
    } else if (event is UserChangeName) {
      try {
        final String res = await UserApi().changeName(event.idUser, event.name);
        print(res);
      } catch (e) {
        print('excpetion');
        print(e);
      }
    } else if (event is UserChangeSurname) {
      try {
        final String res =
            await UserApi().changeSurname(event.idUser, event.surname);
        print(res);
      } catch (e) {
        print('excpetion');
        print(e);
      }
    } else if (event is UserChangeResidence) {
      try {
        final String res =
            await UserApi().changeResidence(event.idUser, event.residence);
        print(res);
      } catch (e) {
        print('excpetion');
        print(e);
      }
    } else if (event is UserChangePhoneNumber) {
      try {
        final String res =
            await UserApi().changePhone(event.idUser, event.phoneNumber);
        print(res);
      } catch (e) {
        print('excpetion');
        print(e);
      }
    } else if(event is UserSelectOrders){
      try {
            yield UserSelectOrdersLoadInProgress();
        final List<ArrayOrders> res =
            await UserApi().selectOrders(event.idUser);
            yield UserSelectOrdersLoadedSuccess(res);
      } catch (e) {
        print('excpetion');
        print(e);
        yield UserSelectOrdersLoadFailure();
      }

    }else if(event is UserGetInfoOrderDone){
      try {
            yield UserSelectOrderInfoDoneLoadInProgress();
        final List<OrderInfoClothes> res =
            await UserApi().selectOrderClothes(event.idOrder);
            yield UserSelectOrderInfoDoneLoadedSuccess(res);
      } catch (e) {
        print('excpetion');
        print(e);
      }

    }else if(event is UserGetAllClothesToReturn){
      try {
            yield UserSelectClothesToReturnDoneLoadInProgress();
        final List<OrderInfoClothes> res =
            await UserApi().selectClothesToReturn(event.idUser);
            yield UserSelectClothesToReturnDoneLoadedSuccess(res);
      } catch (e) {
        print('excpetion');
        print(e);
        yield UserSelectClothesToReturnDoneLoadFailure();
      }

    }else if(event is UserGetHourDateInitialOfReturningClothes){
      try {
            yield UserGetHourDateInitialOfReturningLoadInProgress();
        final DeliveryHourDate res =
            await UserApi().calculateHoursOfDeliveryReturnClothes(event.clothes, event.idUser);
            yield UserGetHourDateInitialOfReturningLoadedSuccess(res);
      } catch (e) {
        print('excpetion');
        print(e);
        yield UserGetHourDateInitialOfReturningInitialState();
      }
    }else if(event is UserConfirmOrderReturnClothes){
      yield UserConfirmOrderedLoadInProgress();
      try {
        final String res = await UserApi()
            .confrimOrderReturn(event.clothes, event.idUser, event.orderData);
        print(res);
        yield UserConfirmOrderedLoadedSucess();
      } catch (e) {
        print('excpetion');
        print(e);
      }

    } else if (event is UserChangeMainInfo){
      try {
        final String res = await UserApi()
            .changeMainInfoUser(event.idUser, event.name, event.surname, event.residence, event.countryCode, event.phoneNumber);
        print(res);
        //yield UserConfirmOrderedLoadedSucess();
      } catch (e) {
        print('excpetion');
        print(e);
      }
    }
  }
}

import 'package:deliclothes_flutter/logic/secure/local_storage.dart';
import 'package:deliclothes_flutter/main.dart';
import 'package:deliclothes_flutter/models/ClotheBagModel.dart';
import 'package:deliclothes_flutter/models/cards_info.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:deliclothes_flutter/models/confirm_order.dart';
import 'package:deliclothes_flutter/models/credit_card.dart';
import 'package:deliclothes_flutter/models/delivery_hour_date.dart';
import 'package:deliclothes_flutter/models/order_info.dart';
import 'package:deliclothes_flutter/models/order_info_clothes.dart';
import 'package:deliclothes_flutter/models/user.dart';
import 'package:deliclothes_flutter/models/user_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  final String baseUrl = 'http://localhost:8080/';

  Future<int> userLogin(String password, String email) async {
    print(password);
    print('Executing loggin of the user');
    final result = await http.Client().post(baseUrl + 'api_v1/user/login',
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'payload': {'password': password, 'email': email}
        }));
    if (result.statusCode != 200) throw (Exception());
    int _idUser = json.decode(result.body)['payload']['user_id'];
    print('User logged in with id: ' + _idUser.toString());
    return _idUser;
  }

  Future<int> userRegister(User user) async {
    print(user);
    print('Executing register of the user');
    final result = await http.Client().post(baseUrl + 'api_v1/user/register',
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "payload": {
            'email': user.email,
            'name': user.name,
            'surname': user.surname,
            'residence': user.street,
            'id_city': 0,
            'city': user.city,
            'phone_number': user.phone_number,
            'country': 'IT',
            'language': 'Italiano',
            'country_code': user.phone_code,
            'zip_code': user.zip_code,
            'password': user.password,
            'gender':user.gender.toLowerCase(),
            'credit_card': {
              'title': 'Card',
              'card_number': user.card.number,
              'expiration_month': user.card.month,
              'expiration_year': user.card.year,
              'cvc': user.card.cvv,
              'card_type': 'card',
              'owner': user.card.owner
            }
          }
        }));
    if (result.statusCode != 201) throw (Exception());
    int _idUser = json.decode(result.body)['payload']['user_id'];
    print('User logged in with id: ' + _idUser.toString());

    return _idUser;
  }

  Future<String> userLikedClothe(int id_user, String clotheId) async {
    print('Executing register of the user');
    final result = await http.Client().post(baseUrl + 'api_v1/user/like_clothe',
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "payload": {
            'id_user': id_user,
            'id_clothe': clotheId,
            "brand": 'Zara' //Change it
          }
        }));
    if (result.statusCode != 200) throw (Exception());
    print('Liked clothe with success');
    return '(result.body)';
  }

  Future<String> userDislikedClothe(int idUser, String clotheId) async {
    print('Executing register of the user');
    final result = await http.Client().delete(
      baseUrl +
          'api_v1/user/dislike_clothe/' +
          clotheId +
          '/' +
          idUser.toString(),
    );
    if (result.statusCode != 200) throw (Exception());

    return '(result.body)';
  }

  Future<String> userAddOrder(int id_user, ClothesData clothe) async {
    print('Insering clothe inside the bag');
    final result =
        await http.Client().post(baseUrl + 'api_v1/user/add_clothe_to_the_bag',
            headers: {"Content-Type": "application/json"},
            body: json.encode({
              "payload": {
                'id_clothe': clothe.getId().toString(),
                'brand': clothe.getBrandName(),
                'id_user': id_user,
                'size': clothe.getSizeSelected(),
                'id_size': '',
                'quantity': 1,
                'returned': false
              }
            }));
    if (result.statusCode != 201) throw (Exception());
    print('Inserted with success clothe inside the bag');
    return '(result.body)';
  }

  Future<DeliveryHourDate> calculateHoursOfDelivery(
      List<ClothesBag> orders, int idUser) async {
    try {
      print('contacting');
      var result = await http.Client()
          .get(baseUrl + 'api_v1/dir/order_get_times_unavailable/'+idUser.toString(),
              headers: {"Content-Type": "application/json"},
              );
      print(result.body);
      print(result);

      if (result.statusCode != 200) throw (Exception());
      final JSONDecoded = json.decode(result.body);
      return DeliveryHourDate.fromJson(JSONDecoded['payload']);
    } catch (e) {
      print('Errore');
      print(e);
      throw (Exception());
    }
  }

  Future<DeliveryHourDate> calculateHoursOfDeliveryReturnClothes(
      List<OrderInfoClothes> orders, int idUser) async {
        try{
    print('contacting');
    final result = await http.Client()
        .post(baseUrl + 'api_v1/user/get_hour_initial_delivery',
            headers: {"Content-Type": "application/json"},
            body: json.encode({
              "payload": {'idUser': idUser, 'orders': 'json.encode(orders)'}
            }));
    print(result.statusCode);
    //if (result.statusCode != 200) throw (Exception());
    final JSONDecoded = json.decode(result.body);
    return DeliveryHourDate.fromJson(JSONDecoded['payload']);
    } catch (e) {
      print('Errore');
      print(e);
      throw (Exception());
    }
  }

  Future<String> addQauntityClothe(String id_clothe, int id_user) async {
    print('Executing addQauntityClothe ');
    final result = await http.Client().put(
        baseUrl +
            'api_v1/user/' +
            id_user.toString() +
            '/add_quantity/' +
            id_clothe,
        headers: {"Content-Type": "application/json"});
    if (result.statusCode != 200) throw (Exception());
    print('Added quantity clothe');
    return '(result.body)';
  }

  Future<String> removeQauntityClothe(String id_clothe, int id_user) async {
    print('Executing addQauntityClothe ');
    final result = await http.Client().put(
        baseUrl +
            'api_v1/user/' +
            id_user.toString() +
            '/remove_quantity/' +
            id_clothe,
        headers: {"Content-Type": "application/json"});
    if (result.statusCode != 200) throw (Exception());
    print('Removed quantity clothe');
    return '(result.body)';
  }

  Future<String> confrimOrder(
      List<ClothesBag> clothes, int idUser, ConfirmOrder orderData, String directions) async {
    print(clothes);
    print('confirmation order');
    final result =
        await http.Client().post(baseUrl + 'api_v1/user/procced_order',
            headers: {"Content-Type": "application/json"},
            body: json.encode({
              "payload": {
                "amount": orderData.amount,
                "id_user": idUser,
                "hour_delivery": orderData.hourDelivery,
                "day_delivery": orderData.dayDelivery.toString(),
                "street_delivery": orderData.streetName,
                "city": orderData.city,
                "zip_code": orderData.zipCode,
                "credit_card_id": orderData.creditCardId,
                "clothes_dict": [
                  ...clothes.map((e) => {
                        'id': int.parse(e.id),
                        'quantity': e.quantity,
                        'size': e.sizeSelected,
                        'brand': e.brand,
                        'cost': e.price,
                        'firstImage': e.img,
                        'title': e.title,
                        'returned': false
                      })
                ],
                "directions":directions
              }
            }));
    if (result.statusCode != 200) throw (Exception());
    final JSONDecoded = json.decode(result.body);
    return 'res';
  }

  Future<String> confrimOrderReturn(List<OrderInfoClothes> clothes, int idUser,
      ConfirmOrder orderData) async {
    print(clothes);
    print('confirmation order');
    final result =
        await http.Client().post(baseUrl + 'api_v1/user/procced_order_return',
            headers: {"Content-Type": "application/json"},
            body: json.encode({
              "payload": {
                "amount": 3,
                "id_user": idUser,
                "hour_delivery": orderData.hourDelivery,
                "day_delivery": orderData.dayDelivery,
                "street_delivery": orderData.streetName,
                "city": orderData.city,
                "credit_card_id": orderData.creditCardId,
                "zip_code": orderData.zipCode,
                "clothes_dict": [
                  ...clothes.map((e) => {
                        'id': e.idClothe,
                        'quantity': e.qunatity,
                        'size': e.size,
                        'brand': e.brand,
                        'cost': e.cost,
                        'firstImage': e.image,
                        'title': e.title,
                        'id_order': e.orderId
                      })
                ],
              }
            }));
    if (result.statusCode != 200) throw (Exception());
    final JSONDecoded = json.decode(result.body);
    return 'res';
  }

  Future<String> addNewCard(PaymentCard card, int id_user, callback) async {
    print('Executing addNewCard ');
    final result = await http.Client()
        .post(baseUrl + 'api_v1/user/' + id_user.toString() + '/add_new_card',
            headers: {"Content-Type": "application/json"},
            body: json.encode({
              "payload": {
                'credit_card': {
                  'title': 'card',
                  'card_number': card.number,
                  'expiration_month': card.month,
                  'expiration_year': card.year,
                  'cvc': card.cvv,
                  'card_type': 'card',
                  'owner': card.owner
                }
              }
            }));
    if (result.statusCode != 200) throw (Exception());
    print('addNewCard');
    final JSONDecoded = json.decode(result.body);
    CardsInfo cardRes = CardsInfo.fromJson(JSONDecoded['payload']);
    print(cardRes);
    callback(cardRes);
    print('Added new user in local storate!');
    return 'userData';
  }

  Future<String> removeCard(int id_card, int id_user) async {
    print('Executing removeCard ');
    final result = await http.Client().delete(
      baseUrl +
          'api_v1/user/' +
          id_user.toString() +
          '/remove_card/' +
          id_card.toString(),
    );
    if (result.statusCode != 200) throw (Exception());
    print('Removed card ');
    return 'userData';
  }

  Future<UserInfo> getInfoUser(int idUser) async {
    print('Executing getinfo user ');
    final result = await http.Client().get(
        baseUrl + 'api_v1/user/' + idUser.toString() + '/get_info',
        headers: {"Content-Type": "application/json"});
    if (result.statusCode != 200) throw (Exception());
    print('Got info of user');
    return parseResponseUserInfoMain(result.body);
  }

  Future<List<OrderInfoClothes>> selectOrderClothes(int idOrder) async {
    print('Executing getinfo user ');
    final result = await http.Client().get(
        baseUrl + 'api_v1/user/' + idOrder.toString() + '/get_clothes_order',
        headers: {"Content-Type": "application/json"});
    if (result.statusCode != 200) throw (Exception());
    print('Got info of user');
    return parseOrderClothesInfo(result.body);
  }

  Future<List<OrderInfoClothes>> selectClothesToReturn(int idUser) async {
    print('Executing getinfo user ');
    final result = await http.Client().get(
        baseUrl + 'api_v1/user/' + idUser.toString() + '/get_clothes_to_return',
        headers: {"Content-Type": "application/json"});
    if (result.statusCode != 200) throw (Exception());
    print('Got info of user');
    return parseOrderClothesInfo(result.body);
  }

  List<OrderInfoClothes> parseOrderClothesInfo(data) {
    final JSONDecoded = json.decode(data);
    print(JSONDecoded['payload']);
    List<OrderInfoClothes> orders = List<OrderInfoClothes>.from(
        JSONDecoded['payload'].map((data) => OrderInfoClothes.fromJson(data)));
    print(orders);
    return orders;
  }

  UserInfo parseResponseUserInfoMain(data) {
    final JSONDecoded = json.decode(data);
    return UserInfo.fromJson(JSONDecoded['payload']);
  }

  Future<List<CardsInfo>> getCardsUser(int idUser) async {
    print('Executing getinfo user ');
    final result = await http.Client().get(
        baseUrl + 'api_v1/user/' + idUser.toString() + '/get_cards',
        headers: {"Content-Type": "application/json"});
    if (result.statusCode != 200) throw (Exception());
    print('Got info of cards');
    return parseResponseUserCardsInfo(result.body);
  }

  Future<List<ArrayOrders>> selectOrders(int idUser) async {
    print('Executing getinfo user ');
    final result = await http.Client().get(
        baseUrl + 'api_v1/user/' + idUser.toString() + '/get_orders',
        headers: {"Content-Type": "application/json"});
    if (result.statusCode != 200) throw (Exception());
    print('Got info of orders');
    return parseOrderInfo(result.body);
  }

  List<ArrayOrders> parseOrderInfo(data) {
    final JSONDecoded = json.decode(data);
    print(JSONDecoded['payload']);
    List<ArrayOrders> orders = List<ArrayOrders>.from(
        JSONDecoded['payload'].map((dat) => ArrayOrders.fromJson(dat)));
    print(orders);
    return orders;
  }

  List<CardsInfo> parseResponseUserCardsInfo(data) {
    final JSONDecoded = json.decode(data);
    //final JSONListPayload = json.decode(JSONDecoded['payload']);
    print(JSONDecoded['payload']);
    List<CardsInfo> cards = List<CardsInfo>.from(
        JSONDecoded['payload'].map((data) => CardsInfo.fromJson(data)));
    return cards;
  }

  Future<String> changeName(int idUser, String name) async {
    print('Executing changeName ');
    final result = await http.Client().put(
        baseUrl + 'api_v1/user/' + idUser.toString() + '/modify_name/' + name,
        headers: {"Content-Type": "application/json"});
    if (result.statusCode != 200) throw (Exception());
    print('Added quantity clothe');
    return 'OK';
  }

  Future<String> changeSurname(int idUser, String surname) async {
    print('Executing changeSurname ');
    final result = await http.Client().put(
        baseUrl +
            'api_v1/user/' +
            idUser.toString() +
            '/modify_surname/' +
            surname,
        headers: {"Content-Type": "application/json"});
    if (result.statusCode != 200) throw (Exception());
    print('Added quantity clothe');
    return 'OK';
  }

  Future<String> changeResidence(int idUser, String residence) async {
    print('Executing changeResidence ');
    final result = await http.Client().put(
        baseUrl +
            'api_v1/user/' +
            idUser.toString() +
            '/modify_residence/' +
            residence,
        headers: {"Content-Type": "application/json"});
    if (result.statusCode != 200) throw (Exception());
    print('Added quantity clothe');
    return 'OK';
  }

  Future<String> changePhone(int idUser, String phone) async {
    print('Executing phone ');
    final result = await http.Client().put(
        baseUrl + 'api_v1/user/' + idUser.toString() + '/modify_phone/' + phone,
        headers: {"Content-Type": "application/json"});
    if (result.statusCode != 200) throw (Exception());
    print('Added quantity clothe');
    return 'OK';
  }

  Future<String> changeMainInfoUser(int idUser, String name, String surname,
      String residence, String countryCode, int phoneNumber) async {
    print('Executing phone ');
    final result = await http.Client().put(
        baseUrl + 'api_v1/user/' + idUser.toString() + '/modify_main_info_user',
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'payload': {
            'id': idUser,
            'name': name,
            'surname': surname,
            'residence': residence,
            'phone': {'phone': phoneNumber, 'code': countryCode}
          }
        }));
    if (result.statusCode != 200) throw (Exception());
    print('Added quantity clothe');
    return 'OK';
  }
}

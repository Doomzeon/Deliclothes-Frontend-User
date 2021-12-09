import 'package:deliclothes_flutter/models/credit_card.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class User extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

  String email,
  gender,
      name,
      surname,
      street,
      phone_code,
      city,
      language,
      customer_id,
      password;
  CreditCard card = new CreditCard();
  int id_city, phone_number, zip_code, id;

  User();

  String getEmail() {
    return this.email;
  }


  String getName() {
    return this.name;
  }

}

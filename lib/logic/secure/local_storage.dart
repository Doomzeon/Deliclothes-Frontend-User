import 'dart:convert';

import 'package:deliclothes_flutter/models/credit_card.dart';
import 'package:deliclothes_flutter/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:deliclothes_flutter/main.dart';

class LocalStorageSecure {
  static final _secure_storage = FlutterSecureStorage();

  static Future setJWT(String jwt) async {
    await _secure_storage.write(key: 'jwt', value: jwt);
  }

  static Future setUser(dynamic data) async {
    await _secure_storage.write(key: 'user', value: data.toString());
    print('Inserted with success id user ');
  }

  static Future<String> readUser() async {
    print(await _secure_storage.read(key: 'user'));
    return await _secure_storage.read(key: 'user');
  }

  static Future<String> readJWT() async {
    print(await _secure_storage.read(key: 'jwt'));
    return await _secure_storage.read(key: 'jwt');
  }

  static Future logout() async {
    print('removing');
    await _secure_storage.delete(key: 'user');
    print(await _secure_storage.read(key: 'user'));
  }

}

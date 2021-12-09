import 'package:deliclothes_flutter/models/ClotheBagModel.dart';
import 'package:deliclothes_flutter/models/clothes.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:deliclothes_flutter/models/posters.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//TODO add custom exceptions
//TODO add return statment of flase or true in case of 200/404/500

class ClothesApi {
  final String baseUrl = 'http://localhost:8080/';

  Future<List<ClothesPoster>> getClothesLikedByUser(int userId, String language) async {
    print('Contacting server to select liked clothes of the user');
    final result = await http.Client()
        .get(baseUrl + 'api_v1/user/' + userId.toString() + '/liked_clothes/'+language);
    if (result.statusCode != 200) throw (Exception());
    print('Selected with success clothes liked of the user');
    return parsedJSONClothesPosters(result.body);
  }

  Future<List<ClothesPoster>> getClothesByGenderAndType(
      String gender, String typeClothes, String language,
      [int id_user]) async {
    print((id_user != null ? id_user.toString() : '0'));
    print('Contacting');
    final result = await http.Client().get(baseUrl +
        'api_v1/clothes/' +
        gender.toLowerCase().toString() +
        '/select/zara/' +
        typeClothes.toLowerCase().toString() +
        '/' +
        (id_user != null ? id_user.toString() : 'None') + '/'+language+
        '?size=10&offset=0');
    if (result.statusCode != 200) throw (Exception());

    return parsedJSONClothesPosters(result.body);
  }

  Future<List<ClothesData>> getClothesByBrandAndType(
      String brand, String typeClothes,
      [int id_user]) async {
    print('Contacting');
    final result = await http.Client().get(baseUrl +
        'api_v1/clothes/' +
        brand.toLowerCase().toString() +
        '/get/' +
        typeClothes.toLowerCase().toString() +
        '/' +
        id_user.toString() +
        '?size=10&offset=0');
    if (result.statusCode != 200) throw (Exception());

    return parsedJSONClothesDataNew(result.body);
  }

  Future<List<PostersHomePage>> getHomePagePosters() async {
    print('Contacting');
    final result = await http.Client()
        .get(baseUrl + 'api_v1/clothes/home_page_posters?size=10&offset=0');
    if (result.statusCode != 200) throw (Exception());

    return parsedJSONHomePagePosters(result.body);
  }

  Future<bool> deleteClotheLiked(String username, String clotheCode) async {
    print('Contacting');
    final result = await http.Client().delete(baseUrl +
        'api_v1/clothes/' +
        username.toLowerCase().toString() +
        '/' +
        clotheCode.toLowerCase().toString() +
        '/dislike');
    if (result.statusCode != 200) throw (Exception());

    return true; //parsedJSONClothesDataNew(result.body);
  }

  Future<bool> postClotheLike(String username, String clotheCode) async {
    print('Contacting');
    final result = await http.Client().post(
        baseUrl +
            'api_v1/clothes/' +
            username.toLowerCase().toString() +
            '/like',
        body: {
          "payload": {"clothe_code": clotheCode}
        });
    if (result.statusCode != 200) throw (Exception());

    return true;
  }

  Future<List<ClothesPoster>> getClothesSimilar(int productId, String brand, int idUser, String language) async {
    print('Contacting');
    final result = await http.Client().get(baseUrl +
        'api_v1/clothes/'+brand+'/' +
        productId.toString() +
        '/select_similar/'+idUser.toString()+'/'+language);
    if (result.statusCode != 200) throw (Exception());

    return parsedJSONClothesPosters(result.body);
  }

  Future<List<ClothesPoster>> getClothesRecomended(int productId, String brand, int idUser, String language) async {
    print('Contacting');
    final result = await http.Client().get(baseUrl +
        'api_v1/clothes/'+brand+'/' +
        productId.toString() +
        '/select_recomended/' +idUser.toString()+'/'+language);
    if (result.statusCode != 200) throw (Exception());

    return parsedJSONClothesPosters(result.body);
  }

  Future<List<ClothesBag>> getClothesInTheBag(int _id_user, String jwt, String language) async {
    print('Contacting');
    final result = await http.Client().get(
        baseUrl + 'api_v1/user/' + _id_user.toString() + '/clothes_in_the_bag/'+language);
    if (result.statusCode != 200) throw (Exception());
    return parsedJSONClothesBag(result.body);
  }

  List<ClothesData> parsedJSONClothesDataNew(clothesJson) {
    print(clothesJson);
    final JSONDecoded = json.decode(clothesJson);
    print(JSONDecoded['payload']);

    List<ClothesData> clothes = List<ClothesData>.from(
        JSONDecoded['payload'].map((data) => ClothesData.fromJson(data)));

    return clothes;
  }

  List<ClothesPoster> parsedJSONClothesPosters(clothesJson) {
    print('clothesJson');
    final JSONDecoded = json.decode(clothesJson);
    print(JSONDecoded['payload']);

    List<ClothesPoster> clothes = List<ClothesPoster>.from(
        JSONDecoded['payload'].map((data) => ClothesPoster.fromJson(data)));
    return clothes;
  }

  List<ClothesBag> parsedJSONClothesBag(clothesJson) {
    print('clothes');
    final JSONDecoded = json.decode(clothesJson);
    print(JSONDecoded['payload']);
    List<ClothesBag> clothes = List<ClothesBag>.from(
        JSONDecoded['payload'].map((data) => ClothesBag.fromJson(data)));
    print('clothes');
    return clothes;
  }

  List<PostersHomePage> parsedJSONHomePagePosters(postersJson) {
    final JSONDecoded = json.decode(postersJson);
    print(JSONDecoded['payload']);
    List<PostersHomePage> posters = List<PostersHomePage>.from(
        JSONDecoded['payload'].map((data) => PostersHomePage.fromJson(data)));
    return posters;
  }

  Future<ClothesData> getClotheInfo(
      String brand, String id, int idUser, String language) async {
    final result = await http.Client().get(baseUrl +
        'api_v1/clothe/' +
        id +
        '/' +
        brand +
        '/' +
        idUser.toString()+'/'+language);
    if (result.statusCode != 200) throw (Exception());

    return parseJsonClotheInfo(result.body);
  }


ClothesData parseJsonClotheInfo(res) {
    final JSONDecoded = json.decode(res);
     ClothesData clothe = ClothesData.fromJson(JSONDecoded['payload']);
    return clothe;
  }


}

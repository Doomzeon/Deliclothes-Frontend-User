import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  UserInfo(this.name, this.surname, this.phoneNumber, this.residence, this.idCity, this.city, this.zipCode);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  final String name, surname, residence, city;
  final int idCity, zipCode, phoneNumber;

  static UserInfo fromJson(dynamic data){
    return UserInfo(
      data['name'] as String,
      data['surname'] as String,
      data['phone_number'] as int,
      data['residence'] as String,
      data['id_city'] as int,
      data['city'] as String,
      data['zip_code'] as int
    );
  }

  

}

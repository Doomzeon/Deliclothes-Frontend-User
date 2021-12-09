


import 'package:equatable/equatable.dart';

class CardsInfo extends Equatable {
  CardsInfo(this.lastNum, this.idCard,this.card_type);


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  final String lastNum,card_type;
  final int idCard;

  static CardsInfo fromJson(dynamic data){
    return CardsInfo(
      data['last_num'] as String,
      data['id_card'] as int,
      data['card_type'] as String
    );
  }

  

}

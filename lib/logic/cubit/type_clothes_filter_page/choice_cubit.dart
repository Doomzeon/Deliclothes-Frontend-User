


import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoiceCubit extends Cubit<ChoiceState>{
  ChoiceCubit(): super(ChoiceState(choice: 'Woman'));

  void chooseMan() => emit(ChoiceState(choice: 'Man'));

  void chooseWoman() => emit(ChoiceState(choice: 'Woman'));

  void chooseChild() => emit(ChoiceState(choice: 'Child'));


}

class ChoiceTypeClothe extends Cubit<TypeClotheState>{
  ChoiceTypeClothe(): super(TypeClotheState(clotheType:''));

  void setTypeClothe(clotheType){
    emit(TypeClotheState(clotheType:clotheType));

}
}
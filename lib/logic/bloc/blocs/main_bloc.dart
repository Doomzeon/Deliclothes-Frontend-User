import 'dart:async';
import 'package:deliclothes_flutter/logic/bloc/events/type_header_clothes_events.dart';
import 'package:deliclothes_flutter/models/clothe_types.dart';


class FilterHeaderGenderClothesBloc {
  String _filterChoice = 'Woman';

  final _genderFilterStateController = StreamController<String>();
  StreamSink<String> get _inFilterChoice => _genderFilterStateController.sink;

  Stream<String> get choice => _genderFilterStateController.stream;

  final _choidGenderFilterEvent = StreamController<TypeHeaderGenderClothesEvent>();

  Sink<TypeHeaderGenderClothesEvent> get filterChoiceEventSink =>_choidGenderFilterEvent.sink;

  FilterHeaderGenderClothesBloc(){
    _choidGenderFilterEvent.stream.listen(_mapEventToStream);
  }

  void _mapEventToStream(TypeHeaderGenderClothesEvent event){
    if (event is WomanHeaderFilterEvent){
      print('Choose Woman');
      _filterChoice = 'Woman';
      
    } else if  (event is ManHeaderFilterEvent){
      print('Choose Man');
      _filterChoice = 'Man';
    } else {
      print('Child');
      _filterChoice = 'Child';
    }
    _inFilterChoice.add(_filterChoice);
  }

  String get_Choice(){
    return _filterChoice;
  }

  void dispose(){
    _genderFilterStateController.close();
    _choidGenderFilterEvent.close();
  }
}


class TypeClotheBloc {
  String _filterChoice;

  final _genderFilterStateController = StreamController<String>();
  StreamSink<String> get _inFilterChoice => _genderFilterStateController.sink;

  Stream<String> get choice => _genderFilterStateController.stream;

  final _choidGenderFilterEvent = StreamController<TypeClotheEvent>();

  Sink<TypeClotheEvent> get filterChoiceEventSink =>_choidGenderFilterEvent.sink;

  TypeClotheBloc(){
    _choidGenderFilterEvent.stream.listen(_mapEventToStream);
  }

  void _mapEventToStream(TypeClotheEvent event){
    print('im here');
    print(filterChoiceEventSink);
    if (event is ChooseTypeClotheEvent){
      print('choice'+choice.toString());
      _filterChoice = choice.toString();
      
    } 
    _inFilterChoice.add(_filterChoice);
  }

  String get_Choice(){
    print(_filterChoice);
    return _filterChoice;
  }

  void dispose(){
    _genderFilterStateController.close();
    _choidGenderFilterEvent.close();
  }
}
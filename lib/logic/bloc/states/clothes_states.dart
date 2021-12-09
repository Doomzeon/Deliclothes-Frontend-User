import 'package:deliclothes_flutter/models/ClotheBagModel.dart';
import 'package:deliclothes_flutter/models/clothes.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:deliclothes_flutter/models/posters.dart';
import 'package:equatable/equatable.dart';

abstract class ClothesState extends Equatable {
  const ClothesState();

  @override
  List<Object> get props => [];
}

class ClothesInitialState extends ClothesState {}

class ClothesLoadInProgress extends ClothesState {}

class ClothesLoadedSuccess extends ClothesState {
  final List<ClothesPoster> clothes;

  ClothesLoadedSuccess(this.clothes);

  @override
  List<Object> get props => [clothes];
}

class ClothesDislikedSuccess extends ClothesState {
  final bool statusCall;

  ClothesDislikedSuccess(this.statusCall);

  @override
  List<Object> get props => [statusCall];
}

class ClothesLikedSuccess extends ClothesState {
  final bool statusCall;

  ClothesLikedSuccess(this.statusCall);

  @override
  List<Object> get props => [statusCall];
}

class ClothesLoadedFailure extends ClothesState {}

class ClotheshomePagePostersSuccess extends ClothesState {
  final List<PostersHomePage> posters;

  ClotheshomePagePostersSuccess(this.posters);

  @override
  List<Object> get props => [posters];
}

class ClotheshomePagePostersInitialState extends ClothesState {}

class ClotheshomePagePostersLoadInProgress extends ClothesState {}

class ClotheshomePagePostersLoadedFailure extends ClothesState {}

class ClothesSimilarLoadedSuccess extends ClothesState{
  final List<ClothesPoster> clothes;

  ClothesSimilarLoadedSuccess(this.clothes);

  @override
  List<Object> get props => [clothes];

}
class ClothesSimilarLoadedFailure extends ClothesState {}
class ClothesSimilarnitialState extends ClothesState {}
class ClothesSimilarLoadInProgress extends ClothesState {}

class ClothesRecomendedLoadedSuccess extends ClothesState{
  final List<ClothesPoster> clothes;

  ClothesRecomendedLoadedSuccess(this.clothes);

  @override
  List<Object> get props => [clothes];

}
class ClothesRecomendeLoadedFailure extends ClothesState {}
class ClothesRecomendeInitialState extends ClothesState {}
class ClothesRecomendeLoadInProgress extends ClothesState {}


class ClothesInTheBagLoadedSuccess extends ClothesState{
  final List<ClothesBag> clothes;

  ClothesInTheBagLoadedSuccess(this.clothes);

  @override
  List<Object> get props => [clothes];

}
class ClothesInTheBagLoadedFailure extends ClothesState {}
class ClothesInTheBagInitialState extends ClothesState {}
class ClothesInTheBagLoadInProgress extends ClothesState {}


class ClothesInfoLoadedFailure extends ClothesState{}
class ClothesInfoInitialState extends ClothesState {}
class ClothesInfoLoadInProgress extends ClothesState {}
class ClothesInfoLoadedSuccess extends ClothesState{
  final ClothesData clothe;

  ClothesInfoLoadedSuccess(this.clothe);

  @override
  List<Object> get props => [clothe];

}
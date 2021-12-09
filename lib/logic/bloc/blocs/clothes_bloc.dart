import 'dart:async';
import 'package:deliclothes_flutter/logic/bloc/events/clothes_event.dart';
import 'package:deliclothes_flutter/logic/bloc/states/clothes_states.dart';
import 'package:deliclothes_flutter/logic/server/clothes_api.dart';
import 'package:deliclothes_flutter/models/ClotheBagModel.dart';
import 'package:deliclothes_flutter/models/clothes.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:deliclothes_flutter/models/posters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClothesBloc extends Bloc<ClothesEvent, ClothesState> {
  ClothesBloc(ClothesState initialState) : super(initialState);

  @override
  Stream<ClothesState> mapEventToState(ClothesEvent event) async* {
    print('Event: ' + event.toString());
    if (event is ClothesRequestByGenderAndType) {
      yield ClothesLoadInProgress();
      try {

          List<ClothesPoster> clothes;
        if(event.id_user == 0){
         clothes = await ClothesApi()
            .getClothesByGenderAndType(event.gender, event.typeClothes, event.language);
        }else{

        clothes = await ClothesApi()
            .getClothesByGenderAndType(event.gender, event.typeClothes, event.language, event.id_user);
        }


        yield ClothesLoadedSuccess(clothes);
      } catch (e) {
        print('ERROR=>' + e.toString());
        yield ClothesLoadedFailure();
      }
    } else if (event is ClothesRequestLiked) {
      yield ClothesLoadInProgress();
      try {
        final List<ClothesPoster> clothes =
            await ClothesApi().getClothesLikedByUser(event.idUser, event.language);

        yield ClothesLoadedSuccess(clothes);
      } catch (e) {
        print('An errore occured while selecting clothes liekd of the user =>' + e.toString());
        yield ClothesLoadedFailure();
      }
    } else if (event is ClothesRequestedByBrandAndType) {
      yield ClothesLoadInProgress();
      try {
         List<ClothesData> clothes;
        if(event.id_user == 0){
         clothes = await ClothesApi()
            .getClothesByBrandAndType(event.brand, event.typeClothes);
        }else{

        clothes = await ClothesApi()
            .getClothesByBrandAndType(event.brand, event.typeClothes, event.id_user);
        }

        //yield ClothesLoadedSuccess(clothes);
      } catch (e) {
        print('ERROR=>' + e.toString());
        yield ClothesLoadedFailure();
      }
    } else if (event is ClothesUsernameDislikeClothe) {
      yield ClothesLoadInProgress();
      try {
        final bool statusCall = await ClothesApi()
            .deleteClotheLiked(event.username, event.clotheCode);
        yield ClothesDislikedSuccess(statusCall);
      } catch (e) {
        print('ERROR=>' + e.toString());
        yield ClothesLoadedFailure();
      }
    } else if (event is ClothesUsernameLikeClothe) {
      yield ClothesLoadInProgress();
      try {
        final bool statusCall =
            await ClothesApi().postClotheLike(event.username, event.clotheCode);
        yield ClothesDislikedSuccess(statusCall);
      } catch (e) {
        print('ERROR=>' + e.toString());
        yield ClothesLoadedFailure();
      }
    } else if (event is ClothesRequestedHomePagePosters) {
      yield ClothesLoadInProgress();
      try {
        final List<PostersHomePage> homePagePosters =
            await ClothesApi().getHomePagePosters();
        yield ClotheshomePagePostersSuccess(homePagePosters);
      } catch (e) {
        print('ERROR=>' + e.toString());
        yield ClothesLoadedFailure();
      }
    } else if (event is ClothesRequestedSimilar) {
      yield ClothesSimilarLoadInProgress();
      try {
        final List<ClothesPoster> clothes =
            await ClothesApi().getClothesSimilar(event.productId, event.brand, event.idUser, event.language);
        yield ClothesSimilarLoadedSuccess(clothes);
      } catch (e) {
        print('ERROR=>' + e.toString());
        yield ClothesSimilarLoadedFailure();
      }
    }
     else if(event is ClothesRequestedRecomended){
      yield ClothesRecomendeLoadInProgress();
      try {
        final List<ClothesPoster> clothes = await ClothesApi()
            .getClothesRecomended(event.productId, event.brand, event.idUser, event.language);
        yield ClothesRecomendedLoadedSuccess(clothes);
      } catch (e) {
        print('ERROR=>' + e.toString());
        yield ClothesRecomendeLoadedFailure();
      }
    } else if (event is ClothesInTheBag) {
      yield ClothesInTheBagLoadInProgress();
      try{
        final List<ClothesBag> clothes = await ClothesApi().getClothesInTheBag(event.id_user, event.jwt, event.language);
        yield(ClothesInTheBagLoadedSuccess(clothes));
      } catch(e){
        print(e);
        yield ClothesInTheBagLoadedFailure();
      }
    } else if(event is ClotheSelectInfo){
      yield ClothesInfoLoadInProgress();
      try{
        final ClothesData clothes = await ClothesApi().getClotheInfo(event.brand, event.id,event.idUser, event.language );
        yield(ClothesInfoLoadedSuccess(clothes));
      } catch(e){
        print(e);
        yield ClothesInTheBagLoadedFailure();
      }
    }
  }
}

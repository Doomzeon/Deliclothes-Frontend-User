import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/clothes_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/clothes_event.dart';
import 'package:deliclothes_flutter/logic/bloc/states/clothes_states.dart';
import 'package:deliclothes_flutter/models/clothes.dart';
import 'package:deliclothes_flutter/screens/clohte_info/widgets/add_order_button.dart';
import 'package:deliclothes_flutter/screens/clohte_info/widgets/description_container.dart';
import 'package:deliclothes_flutter/screens/clohte_info/widgets/image_container_info_clothe.dart';
import 'package:deliclothes_flutter/screens/clohte_info/widgets/recomended_products_container.dart';
import 'package:deliclothes_flutter/screens/clohte_info/widgets/similar_products_container.dart';
import 'package:deliclothes_flutter/screens/clohte_info/widgets/sizes_container.dart';
import 'package:deliclothes_flutter/screens/clohte_info/widgets/title_clothe_container.dart';
import 'package:deliclothes_flutter/screens/clohte_info/widgets/title_container.dart';
import 'package:deliclothes_flutter/screens/home/home_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClotheInfo extends StatefulWidget {
  final ClothesPoster clothesPoster;
  final int idUser;

  const ClotheInfo({Key key, this.clothesPoster, this.idUser})
      : super(key: key);
  @override
  _ClotheInfoState createState() => _ClotheInfoState();
}

class _ClotheInfoState extends State<ClotheInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocProvider(
      create: (context) => ClothesBloc(ClothesInfoInitialState()),
      child: BlocConsumer<ClothesBloc, ClothesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ClothesInfoLoadInProgress) {
            return SpinnerContainer(size);
          } else if (state is ClothesInfoLoadedSuccess) {
            return Column(
              children: [
                Container(
                    child: Expanded(
                        child: SingleChildScrollView(
                            child: Column(children: [
                  ImageContainer(
                    
                    clothe: state.clothe,
                    idUser: widget.idUser,
                  ),
                  TitleConainer(title: state.clothe.getBrandName()),
                  TitleClothe(title: state.clothe.getTitle()),
                  DescriptionClothe(description: state.clothe.getDescription()),
                  TitleConainer(title: 'Price ' +state.clothe.getPrice().toString() + ' €'),
                  TitleConainer(title: 'Available sizes'),
                  SizesContainer(clothe: state.clothe),
                  SimilarProducts(
                    id: state.clothe.getId(),
                    brand: state.clothe.getBrandName(),
                    idUser: widget.idUser,
                  ),
                  RecomendedProducts(
                      id: state.clothe.getId(),
                      brand: state.clothe.getBrandName(),
                      idUser: widget.idUser),
                ])))),
                ButtonAddToOrder(idUser: widget.idUser, clothe: state.clothe)
              ],
            );
          } else if (state is ClothesInfoInitialState) {
            BlocProvider.of<ClothesBloc>(context).add(ClotheSelectInfo(
              widget.clothesPoster.brand,
              widget.clothesPoster.id,
              widget.idUser,
              AppLocalizations.of(context).localeName
            ));
          } else {
            return Container(
                child: Column(children: [
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: size.height * 0.30),
                      width: size.width,
                      child: Center(
                          child: Text('Something wrong with the server.'))),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => {
                      BlocProvider.of<ClothesBloc>(context)
                          .add(ClotheSelectInfo(
                        widget.clothesPoster.brand,
                        widget.clothesPoster.id,
                        widget.idUser,
                AppLocalizations.of(context).localeName
                      ))
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: size.width,
                        height: 70,
                        child: Stack(children: [
                          Positioned(
                            top: 5,
                            left: size.width * 0.29,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(40)),
                              width: 180,
                              height: 45,
                              child: Center(
                                child: Text('Retry',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0,
                                        fontFamily: 'AvenirLight')),
                              ),
                            ),
                          ),
                        ])),
                  )
                ],
              )
            ]));
          }
        },
      ),
    ));
  }
}

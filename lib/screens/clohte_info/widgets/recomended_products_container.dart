

import 'package:deliclothes_flutter/components/clothes_list_horizontal.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/clothes_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/clothes_event.dart';
import 'package:deliclothes_flutter/logic/bloc/states/clothes_states.dart';
import 'package:deliclothes_flutter/screens/clohte_info/widgets/title_clothe_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../constant.dart';

class RecomendedProducts extends StatefulWidget{
  final int id;
  final String brand;
  final int idUser;
  const RecomendedProducts({Key key, this.id, this.brand, this.idUser}) : super(key: key);
  @override
  _RecomendedProductsState createState() => _RecomendedProductsState();
}

class _RecomendedProductsState extends State<RecomendedProducts> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ClothesBloc(ClothesRecomendeInitialState()),
      child: BlocConsumer<ClothesBloc, ClothesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ClothesRecomendeInitialState) {
            BlocProvider.of<ClothesBloc>(context)
                .add(ClothesRequestedRecomended(widget.id, widget.brand, widget.idUser, AppLocalizations.of(context).localeName));
          return Container();
          } else if (state is ClothesRecomendeLoadInProgress) {
            return Container(
              width: size.width,
              height: 200,
              child: SpinKitWanderingCubes(
                  color: kBackgroundHeaderColor, size: 50.0),
            );
          } else if (state is ClothesRecomendedLoadedSuccess) {
            if (state.clothes.length !=0)
              return Column(
                children: [
                  TitleConainer(title: 'Complete the look with'),
                  ClothesListHorizontal(size: size, clothes: state.clothes),
                ],
              );
            else
              return Container();
          }
        },
      ),
    );
  }
}
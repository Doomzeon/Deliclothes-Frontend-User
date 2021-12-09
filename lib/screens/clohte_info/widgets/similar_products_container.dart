import 'package:deliclothes_flutter/components/clothes_list_horizontal.dart';
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/clothes_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/clothes_event.dart';
import 'package:deliclothes_flutter/logic/bloc/states/clothes_states.dart';
import 'package:deliclothes_flutter/screens/clohte_info/widgets/title_clothe_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SimilarProducts extends StatefulWidget {
  final int id, idUser;
  final String brand;

  const SimilarProducts({Key key, this.id, this.brand, this.idUser}) : super(key: key);
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ClothesBloc(ClothesSimilarnitialState()),
      child: BlocConsumer<ClothesBloc, ClothesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ClothesSimilarnitialState) {
            BlocProvider.of<ClothesBloc>(context)
                .add(ClothesRequestedSimilar(widget.id, widget.brand,  widget.idUser, AppLocalizations.of(context).localeName));
                return Container();
          } else if (state is ClothesSimilarLoadInProgress) {
            return Container(
              width: size.width,
              height: 200,
              child: SpinKitWanderingCubes(
                  color: kBackgroundHeaderColor, size: 50.0),
            );
          } else if (state is ClothesSimilarLoadedSuccess) {
            if(state.clothes.length !=0)
            return Column(
              children: [
                  TitleConainer(title: 'Similiar products'),
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

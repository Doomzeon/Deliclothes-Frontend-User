import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/main_bloc.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/choice_cubit.dart';
import 'package:deliclothes_flutter/logic/cubit/type_clothes_filter_page/cubit_state.dart';
import 'package:deliclothes_flutter/models/clothe_types.dart';
import 'package:deliclothes_flutter/screens/filter-clothes-type_screen/components/container_type_clothes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeContainerBody extends StatefulWidget {
  final size;
  const TypeContainerBody({Key key, this.size}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    print('reloaded');
    return TypeContainerBodyState(size);
  }
}

class TypeContainerBodyState extends State<TypeContainerBody> {
  final size;
  List<ClothesType> clothesType;


  TypeContainerBodyState(this.size);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<ChoiceCubit, ChoiceState>(
      listener: (context, state) {
        print(state.choice.toString());
        this.clothesType = ClothesType.fetchAll(state.choice.toString());
      },
      builder: (context, state) {
        this.clothesType = ClothesType.fetchAll(state.choice.toString());
        return Container(
          child: Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 50),
              scrollDirection: Axis.vertical,
              child: Container(
                margin: EdgeInsets.only(bottom: 50),
                color: Colors.transparent,
                child: Column(children: <Widget>[
                  for (var i = 0; i < this.clothesType.length; i += 2)
                    RowContainersTypeClothes(
                        clothesType1: this.clothesType[i],
                        clothesType2: this.clothesType[i + 1])
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}

class RowContainersTypeClothes extends StatelessWidget {
  final ClothesType clothesType1;
  final ClothesType clothesType2;

  const RowContainersTypeClothes({
    Key key,
    this.clothesType1,
    this.clothesType2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ContainerTypeClothes(
            image: this.clothesType1.getImage(),
            text: this.clothesType1.getNameType()),
        ContainerTypeClothes(
            image: this.clothesType2.getImage(),
            text: this.clothesType2.getNameType())
      ],
    );
  }
}

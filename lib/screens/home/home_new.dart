import 'package:deliclothes_flutter/components/clothes_list_horizontal.dart';
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/clothes_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/clothes_event.dart';
import 'package:deliclothes_flutter/logic/bloc/states/clothes_states.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/models/posters.dart';
import 'package:deliclothes_flutter/screens/home/widgets/brand_image_poster.dart';
import 'package:deliclothes_flutter/screens/home/widgets/container_more_info_home.dart';
import 'package:deliclothes_flutter/screens/home/widgets/sub_title_more_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) =>
                ClothesBloc(ClotheshomePagePostersInitialState()),
            child: BlocConsumer<ClothesBloc, ClothesState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ClotheshomePagePostersInitialState) {
                  BlocProvider.of<ClothesBloc>(context)
                      .add(ClothesRequestedHomePagePosters());
                  return Container();
                } else if (state is ClotheshomePagePostersLoadInProgress) {
                  return SpinnerContainer(size);
                } else if (state is ClotheshomePagePostersSuccess) {
                  return HomeBodyPage(posters: state.posters);
                } else {
                  return Container(
                      child: Column(children: [
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: size.height * 0.30),
                            width: size.width,
                            child: Center(
                                child:
                                    Text('Something wrong with the server.'))),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => {
                            BlocProvider.of<ClothesBloc>(context)
                                .add(ClothesRequestedHomePagePosters())
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
                                        borderRadius:
                                            BorderRadius.circular(40)),
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
          ),
        ));
  }
}

Container SpinnerContainer(Size size) {
  return Container(
    width: size.width,
    height: 310,
    child: SpinKitWanderingCubes(color: kBackgroundHeaderColor, size: 50.0),
  );
}

class HomeBodyPage extends StatefulWidget {
  final List<PostersHomePage> posters;
  const HomeBodyPage({
    Key key,
    this.posters,
  }) : super(key: key);

  @override
  _HomeBodyPageState createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        BranImageDescription(
            size: size,
            image: widget.posters[0].getImg(),
            text: widget.posters[0].getDescription()),
        BlocProvider(
          create: (context) => ClothesBloc(ClothesInitialState()),
          child: BlocConsumer<ClothesBloc, ClothesState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ClothesInitialState) {
                var _stateUser = context.select((UserBloc cb) => cb.state);
                if (_stateUser is UserLoginSuccess) {
                  BlocProvider.of<ClothesBloc>(context).add(
                      ClothesRequestByGenderAndType(
                          'man',
                          'SpecialPrice',
                          _stateUser.userId,
                          AppLocalizations.of(context).localeName));
                } else {
                  BlocProvider.of<ClothesBloc>(context).add(
                      ClothesRequestByGenderAndType('man', 'SpecialPrice', 0,
                          AppLocalizations.of(context).localeName));
                }
                return Container();
              } else if (state is ClothesLoadInProgress) {
                return SpinnerContainer(size);
              } else if (state is ClothesLoadedSuccess) {
                return Column(
                  children: [
                    ContainerMoreInfoAboutSection(
                        title: AppLocalizations.of(context)
                            .home_page_sales_title_section),
                    SubtitleOfMoreInfo(
                        title: AppLocalizations.of(context)
                            .home_page_sales_title_2_section),
                    ClothesListHorizontal(size: size, clothes: state.clothes),
                  ],
                );
              } else if (state is ClothesLoadedFailure){
                return Container(
                  //margin: EdgeInsets.only(top:25),
                );
              }
            },
          ),
        ),
        BranImageDescription(
            size: size,
            image: widget.posters[1].getImg(),
            text: widget.posters[1].getDescription()),
      ],
    );
  }
}

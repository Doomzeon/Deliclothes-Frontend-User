import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliclothes_flutter/components/clothes_list_horizontal.dart';
import 'package:deliclothes_flutter/components/custom_bottom_navigation.dart';
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/clothes_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/clothes_event.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/clothes_states.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/models/ClotheBagModel.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:deliclothes_flutter/screens/bag_screen/screens/bag_second_screen.dart';
import 'package:deliclothes_flutter/screens/bag_screen/screens/checkout_new.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BagScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BagScreenStateNew();
  }
}

class BagScreenStateNew extends State<BagScreen> {
  List<ClothesData> clothesOrdered = new List<ClothesData>();
  String _jwt;

  updateParent() {
    setState(() {});
  }

  int _id_user;
  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = FlatButton(
        child: Text(AppLocalizations.of(context).settings_page_my_account_close_card_modal_button),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Ordine pagato con successo!"), //TODO
        content: Text("Adesso puoi tracciare il tuo ordine in tempo reale!"),//TODO
        actions: [cancelButton],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    // TODO: implement build
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<UserBloc, UserState>(builder: (context, state_user) {
      if (state_user is UserNotLoggedIn) {
        return Expanded(child: SingleChildScrollView(child: SingInUpPage()));
      } else if (state_user is UserLoginSuccess) {
        this._id_user = state_user.userId;
        return BlocProvider(
            create: (context) => ClothesBloc(ClothesInTheBagInitialState()),
            child: BlocConsumer<ClothesBloc, ClothesState>(
                listener: (context, state) {
              // TODO: implement listener
            }, builder: (context, state) {
              if (state is ClothesInTheBagInitialState) {
                BlocProvider.of<ClothesBloc>(context)
                    .add(ClothesInTheBag(this._id_user, this._jwt, AppLocalizations.of(context).localeName));
                return Container();
              } else if (state is ClothesInTheBagLoadInProgress) {
                return Container(
                  width: size.width,
                  height: 300,
                  child: SpinKitWanderingCubes(
                      color: kBackgroundHeaderColor, size: 50.0),
                );
              } else if (state is ClothesInTheBagLoadedSuccess) {
                return Container(
                    color: Colors.white,
                    child: Column(children: [
                      ContainerTitle(size: size),
                      Container(
                        width: size.width,
                        height: size.height - 130 - 90 - 50,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                              child: Column(
                            children: [
                              for (var i = 0; i < state.clothes.length; i++)
                                state.clothes[i].quantity > 0
                                    ? ClotheBageInfoContainer(
                                        clothe: state.clothes[i],
                                        id_user: this._id_user,
                                        updateParent: this.updateParent,
                                      )
                                    : Container()
                              //ClotheBageInfoContainer()
                            ],
                          )),
                        ),
                      ),
                      Container(
                        //color: Colors.orange,
                        height: 70,
                        width: 280,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: FlatButton(
                              padding: EdgeInsets.only(left: 25, right: 25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: kSecondaryColor, //Color(0xfff9de2e),
                              onPressed: () => {
                                if (state.clothes.length > 0)
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                              value: BlocProvider.of<UserBloc>(
                                                  context),
                                              child: CheckoutPage(
                                                idUser: this._id_user,
                                                clothes: state.clothes,
                                              ) //Checkout(user:state_user.userData, clothes: state.clothes,),
                                              ))).then((value) => setState(() {
                                        //showAlertDialog(context);
                                        BlocProvider.of<ClothesBloc>(context)
                                            .add(ClothesInTheBag(
                                                this._id_user, this._jwt, AppLocalizations.of(context).localeName));
                                      }))
                              },
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(right: 35),
                                      child: Icon(Icons.arrow_back_ios_outlined,
                                          color: Colors.white, size: 15)),
                                  Center(
                                    child: Text(AppLocalizations.of(context).bag_page_button_next_text,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            fontFamily: 'AvenirLight')),
                                  ),
                                ],
                              ),
                            )),
                      )
                    ]));
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
                    .add(ClothesInTheBag(this._id_user, this._jwt, AppLocalizations.of(context).localeName))
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
            }));
      } else {
        return Container();
      }
    });
  }
}

class ClotheBageInfoContainer extends StatefulWidget {
  final int id_user;

  final updateParent;
  final ClothesBag clothe;

  const ClotheBageInfoContainer({
    Key key,
    @required this.id_user,
    this.updateParent,
    this.clothe,
  }) : super(key: key);

  @override
  _ClotheBageInfoContainerState createState() => _ClotheBageInfoContainerState(
      this.id_user, this.updateParent, this.clothe);
}

class _ClotheBageInfoContainerState extends State<ClotheBageInfoContainer> {
  final int id_user;

  final updateParent;

  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text("Il vestito verra eliminato dal carello"),
    actions: [
      FlatButton(
        child: Text("Cancella"),
        onPressed: () {
          return null;
        },
      ),
      FlatButton(
        child: Text("Continua"),
        onPressed: () {},
      ),
    ],
  );

  final ClothesBag clothe;

  _ClotheBageInfoContainerState(this.id_user, this.updateParent, this.clothe);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = FlatButton(
        child: Text("Cancela"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = FlatButton(
        child: Text("Continua"),
        onPressed: () {
          Navigator.of(context).pop();
          BlocProvider.of<UserBloc>(context).add(UserRemoveQuantityClothe(
              this.clothe.id.toString(), this.id_user));
          this.clothe.setQuantity(this.clothe.quantity - 1);
          setState(() => {print('Updating'), updateParent()});
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Conferma azione"),
        content: Text("Il vestito verra eliminato dal cestino!"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Container(
        margin: EdgeInsets.only(top: 20),
        width: 120,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(35)),
          image: DecorationImage(
            image: NetworkImage(this.clothe.img),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: 20),
          width: size.width - 150,
          height: 130,
          child: Stack(children: [
            Positioned(
                top: 25,
                left: 5,
                child: Text(clothe.title.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontFamily: 'AvenirLight'))),
            Positioned(
                bottom: 20,
                left: 10,
                child: Text((clothe.price * clothe.quantity).toString() + ' €',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'AvenirLight'))),
            Positioned(
                top: 50,
                right: 35,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Center(
                    child: Text(clothe.sizeSelected.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontFamily: 'AvenirLight')),
                  ),
                )),
            Positioned(
                bottom: 2,
                right: 5,
                child: Container(
                  width: 90,
                  height: 50,
                  //color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () => {
                                this.clothe.quantity - 1 == 0
                                    ? showAlertDialog(context)
                                    : {
                                        BlocProvider.of<UserBloc>(context).add(
                                            UserRemoveQuantityClothe(
                                                this.clothe.id.toString(),
                                                this.id_user)),
                                        this.clothe.setQuantity(
                                            this.clothe.quantity - 1),
                                        setState(() =>
                                            {print('updating'), updateParent()})
                                      }
                              },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 18),
                            child: Icon(Icons.minimize_outlined, size: 25),
                          )),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 20.0,
                                  color: Colors.grey[400],
                                  offset: Offset(0, 0))
                            ],
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(
                          child: Text(clothe.quantity.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'AvenirLight')),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          BlocProvider.of<UserBloc>(context).add(
                              UserAddQuantityClothe(
                                  this.clothe.id.toString(), this.id_user)),
                          this.clothe.setQuantity(this.clothe.quantity + 1),
                          setState(() => {print('updating'), updateParent()})
                        },
                        child: Container(child: Icon(Icons.add, size: 25)),
                      ),
                    ],
                  ),
                ))
          ]))
    ]);
  }
}

class ContainerTitle extends StatelessWidget {
  const ContainerTitle({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff9BBBD6),
            Color(0xff6FA7D6),
            Color(0xff599DD6),
            Color(0xff388ED6)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      ),
      height: 130,
      width: size.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          width: size.width - 100,
          child: Center(
            child: Text(AppLocalizations.of(context).bag_page_title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'AvenirLight')),
          ),
        ),
      ]),
    );
  }
}

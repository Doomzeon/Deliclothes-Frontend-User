import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/models/order_info_clothes.dart';
import 'package:deliclothes_flutter/screens/home/home_new.dart';
import 'package:deliclothes_flutter/screens/user_screen/checkout_return_clothes.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/clothe_return_row_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReturnClothes extends StatefulWidget {
  final int userId;

  const ReturnClothes({Key key, this.userId}) : super(key: key);
  @override
  _ReturnClothesState createState() => _ReturnClothesState();
}

class _ReturnClothesState extends State<ReturnClothes> {
  final List<OrderInfoClothes> _clothes = new List<OrderInfoClothes>();

  _manipulateClothe(value, item) {
    if (value == true) {
      this._clothes.add(item);
      print(this._clothes);
    } else {
      this._clothes.removeWhere((element) => element.idClothe == item.idClothe);
      print(this._clothes);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            UserBloc(UserSelectClothesToReturnInfoDoneInitialState()),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is UserSelectClothesToReturnInfoDoneInitialState) {
              BlocProvider.of<UserBloc>(context)
                  .add(UserGetAllClothesToReturn(widget.userId));
              return Container();
            } else if (state is UserSelectClothesToReturnDoneLoadInProgress) {
              return SpinnerContainer(size);
            } else if (state is UserSelectClothesToReturnDoneLoadedSuccess) {
              print(state.clothes);
              return SingleChildScrollView(
                              child: Column(children: [
                  HeaderContainer(
                    size: size,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      height: size.height * 0.75,
                      //color: Colors.orange,
                      child: Column(children: [
                        ...state.clothes.map((e) => ClotheReturnRowCheckbox(
                            clothe: e, callBackFunction: this._manipulateClothe))
                      ]),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          if (this._clothes.length > 0)
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                            value: BlocProvider.of<UserBloc>(
                                                context),
                                            child: CheckoutReturnClothes(
                                                userId: widget.userId,
                                                clothes: this._clothes),
                                          ))).then((value) => setState(() {
                                    BlocProvider.of<UserBloc>(context).add(
                                        UserGetAllClothesToReturn(widget.userId));
                                  }))
                            }
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
                                      color: kRedColor,
                                      borderRadius: BorderRadius.circular(40)),
                                  width: 180,
                                  height: 45,
                                  child: Center(
                                    child: Text(AppLocalizations.of(context).settings_page_make_return_button_next,
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
                ]),
              );
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
              BlocProvider.of<UserBloc>(context)
                  .add(UserGetAllClothesToReturn(widget.userId))
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
                      ),
                      
                    ],
                  ),
                  Row(children: [GestureDetector(
                        onTap: () => {
            Navigator.pop(context)
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
                                    child: Text('Back',
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
                      )],)
                ]));
            }
          },
        ),
      ),
    );
  }
}

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        margin: EdgeInsets.only(top: 50, left: 20),
        //color: Colors.green,
        child: IconButton(
          icon: SvgPicture.asset('assets/icons/left-arrow.svg',
              width: 20, color: kTextColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: 50, left: size.width * 0.10),
          child: Text(
            AppLocalizations.of(context).settings_page_make_return_title,
            style: TextStyle(
                color: kTextColor, fontSize: 18.0, fontFamily: 'AvenirLight'),
          ))
    ]);
  }
}

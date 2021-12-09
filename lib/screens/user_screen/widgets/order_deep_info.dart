import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/screens/home/home_new.dart';
import 'package:deliclothes_flutter/screens/user_screen/widgets/order_row_depp_info_clothe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDeepInfo extends StatefulWidget {
  final int orderId;
  final double amount;

  const OrderDeepInfo({Key key, this.orderId, this.amount}) : super(key: key);
  @override
  _OrderDeepInfoState createState() => _OrderDeepInfoState();
}

class _OrderDeepInfoState extends State<OrderDeepInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create: (context) => UserBloc(UserSelectOrderInfoDoneInitialState()),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is UserSelectOrderInfoDoneInitialState) {
              BlocProvider.of<UserBloc>(context)
                  .add(UserGetInfoOrderDone(widget.orderId));
              return Container();
            } else if (state is UserSelectOrderInfoDoneLoadInProgress) {
              return SpinnerContainer(size);
            } else if (state is UserSelectOrderInfoDoneLoadedSuccess) {
              return Column(
                    children: [
                      HeaderContainer(
                        size: size,
                      ),
                      Container(
                        width: size.width,
                        height:size.height*0.80,
                        //color: Colors.orange,
                        child: SingleChildScrollView(
                            child: Column(children: [
                            ...state.clothes.map((e) => OrderRowClotheDeepInfo(
                clothe: e,
              ))
                          ]),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left:20),
                            child:Text(AppLocalizations.of(context).checkout_page_bill_tot_text,style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'AvenirLight'))
                          ),
                          Container(
                            margin: EdgeInsets.only(right:20),
                            child:Text(widget.amount.toString() + ' €',style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'AvenirLight'))
                          ),
                        ],
                      )
                    ],
                  );
            } else {
              return Container();
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
            AppLocalizations.of(context).settings_page_allorders_order_done_title,
            style: TextStyle(
                color: kTextColor, fontSize: 18.0, fontFamily: 'AvenirLight'),
          ))
    ]);
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/models/clothes.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:deliclothes_flutter/screens/clohte_info/clothe_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ClotheInfoContainerComponent extends StatefulWidget {
  final ClothesPoster clothe;

  const ClotheInfoContainerComponent({Key key, this.clothe}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClotheInfoContainerComponentState(this.clothe);
  }
}

class ClotheInfoContainerComponentState
    extends State<ClotheInfoContainerComponent> {
  final ClothesPoster clothe;

  ClotheInfoContainerComponentState(this.clothe);

  @override
  Widget build(BuildContext context) {
    var id_user;
    var jwt = '';
    var stateUser = context.select((UserBloc cb) => cb.state);
    print('State use =>' + stateUser.toString());
    if (stateUser is UserLoginSuccess) {
      id_user = stateUser.userId;
      //print(stateUser.userData.getEmail());
      //jwt = stateUser.userData.getJwt();
    }
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<UserBloc>(context),
                      child: ClotheInfo(
                          idUser: id_user, clothesPoster: this.clothe),
                    ))),
      },
      child: Container(
        margin: EdgeInsets.only(top: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        width: 175,
        height: 275,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                            child: Text(this.clothe.brand,
                                style: TextStyle(
                                    color: kRedColor,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'AvenirLight'))),
                      ),
                      Positioned(
                        top: 1,
                        right: 2,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/like.svg',
                            width: 25,
                            color:
                                this.clothe.liked ? kRedColor : kSecondaryColor,
                          ),
                          onPressed: () {

    if (stateUser is UserLoginSuccess) {
                            setState(() {
                              if (this.clothe.liked) {
                                this.clothe.liked = false;
                                print('sss');
                                BlocProvider.of<UserBloc>(context).add(
                                    UserDislikedClothe(
                                        id_user, this.clothe.id.toString()));
                              } else {
                                this.clothe.liked = true;
                                print('sss');
                                BlocProvider.of<UserBloc>(context).add(
                                    UserLikedClothe(
                                        id_user, this.clothe.id.toString()));
                              }
                            });}
                          },
                        ),
                      )
                    ],
                  ),
                  width: 175,
                  height: 195,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    image: DecorationImage(
                      image: NetworkImage(clothe.img),
                      fit: BoxFit.cover,
                    ),
                  ),
                  //child:Text()
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
                  width: 175,
                  child: AutoSizeText(clothe.title,
                      maxLines: 2,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 13.0,
                          fontFamily: 'AvenirLight')),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 175 / 2,
                    padding: EdgeInsets.only(left: 5),
                    child: RichText(
                      text: new TextSpan(
                        text: clothe.price.toString() + ' € ',
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 15.0,
                          fontFamily: 'AvenirLight'),
                        children: <TextSpan>[
                          this.clothe.oldPrice != null&&this.clothe.oldPrice !=0.0?
                          new TextSpan(
                            text: this.clothe.oldPrice.toString() +' €',
                            style: new TextStyle(
                              color: kRedColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ):new TextSpan(
                            text: '',
                          ),
                        ],
                      ),
                    )
                    /*Text(clothe.price.toString() + ' €' + (this.clothe.oldPrice !=0.0? ),
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 15.0,
                          fontFamily: 'AvenirLight')),*/
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

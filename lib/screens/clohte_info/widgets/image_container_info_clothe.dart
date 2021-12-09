


import 'package:carousel_pro/carousel_pro.dart';
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/models/clothes_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ImageContainer extends StatefulWidget{
  final ClothesData clothe;
  final int idUser;

  const ImageContainer({Key key, this.clothe, this.idUser}) : super(key: key);

  @override
  _ImageContainerState createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _stateUser =
        context.select((UserBloc cb) => cb.state);
    return Row(
      children: [
        Container(
          child: Stack(
            children: [
              Carousel(
                
                  images: widget
                      .clothe
                      .getImages()
                      .map((e) => Image.network(e.toString(),
                  fit: BoxFit.fill))
                      .toList(),
                  dotSize: 0,
                  dotSpacing: 0,
                  dotColor: Colors.transparent,
                  //indicatorBgPadding: 5.0,
                  dotBgColor: Colors.transparent,
                  autoplayDuration: Duration(minutes: 10)),
              Positioned(
                top: 40,
                left: 2,
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/left-arrow.svg',
                      width: 20, color: Colors.grey[500]),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: 40,
                right: 2,
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/like.svg',
                    width: 25,
                    color: widget.clothe.isLiked() ? kRedColor : kSecondaryColor,
                  ),
                  onPressed: () {
                    if (_stateUser is UserLoginSuccess){
                    setState(() {
                      if (widget.clothe.isLiked()) {
                        widget.clothe.setLiked(false);
                        BlocProvider.of<UserBloc>(context).add(
                            UserDislikedClothe(
                                widget.idUser, widget.clothe.getId().toString()));
                      } else {
                        widget.clothe.setLiked(true);
                        BlocProvider.of<UserBloc>(context).add(UserLikedClothe(
                            widget.idUser, widget.clothe.getId().toString()));
                      }
                    });
                    }
                  },
                ),
              ),
            ],
          ),
          width: size.width,
          height: 550,
        )
      ],
    );
  }
}
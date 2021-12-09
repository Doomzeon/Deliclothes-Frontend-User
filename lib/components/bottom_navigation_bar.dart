
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key key,
    @required this.size, this.selectedPage,
  }) : super(key: key);

  final Size size;
  final int selectedPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 70,
      child: Stack(
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: size.width,
                height: 70,
                color: Colors.white,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(size.width, 110),
                      //painter: BNBCustomPainter(),
                    ),
                    Center(
                        heightFactor: 0.8,
                        child: FloatingActionButton(
                          onPressed: () {
                            onPressedNavItem(5);
                          },
                          backgroundColor: kSecondaryColor,
                          child: SvgPicture.asset(
                            'assets/icons/shopping-bag.svg',
                            width: 20,
                            color: Colors.white,
                          ),
                          elevation: 0.1,
                        )),
                    Container(
                        width: size.width,
                        height: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: SvgPicture.asset('assets/icons/home.svg',
                                  width: 20, color: selectedPage==3?Colors.green:Colors.black ),
                              onPressed: () {
                                onPressedNavItem(3);
                              },
                            ),
                            IconButton(
                              icon: SvgPicture.asset('assets/icons/heart-shape-outline.svg',
                              width: 20,color: selectedPage==4?Colors.green:Colors.black),
                          onPressed: () {
                            onPressedNavItem(4);
                          },
                        ),
                        Container(width: size.width * 0.20),
                        IconButton(
                          icon: SvgPicture.asset('assets/icons/user.svg',
                              width: 20,color: selectedPage==7?Colors.green:Colors.black),
                          onPressed: () {
                            onPressedNavItem(7);
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                              'assets/icons/open-box.svg',
                              width: 20,color: selectedPage==8?Colors.green:Colors.black),
                          onPressed: () {
                            onPressedNavItem(8);
                          },
                        ),
                      ],
                    ))
              ],
            ),
          ))
    ],
      ),
    );
  }
}
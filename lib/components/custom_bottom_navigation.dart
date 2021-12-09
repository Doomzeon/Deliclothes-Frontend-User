import 'package:deliclothes_flutter/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigation extends StatelessWidget {

  const CustomBottomNavigation({
    Key key, this.size
  }) : super(key: key);
  final size;
  @override
  Widget build(BuildContext context) {

    return Container(
      width: size.width,
      height: 70,
      child: Stack(
          children: [
            Positioned(
              bottom:0,
              left:0,
              child:Container(
                width: size.width,
                height: 70,
                color:Colors.transparent,
                child: Stack(
                  children: [
                    CustomPaint(
                      size:Size(size.width, 110),
                      //painter: BNBCustomPainter(),
                    ),
                    Center(
                        heightFactor: 0.8,
                        child:FloatingActionButton(
                          onPressed: (){Navigator.of(context).pushNamed('/clothesFilterPage'); },
                          backgroundColor: kSecondaryColor,
                          child:SvgPicture.asset('assets/icons/shopping-bag.svg',width: 20,color: Colors.white,),
                          elevation:0.1,
                        )
                      ),
                      Container(
                        width: size.width,
                        height:90,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(icon: SvgPicture.asset('assets/icons/home.svg',width: 20), onPressed: () { Navigator.of(context).pushNamed('/'); },),
                            IconButton(icon: SvgPicture.asset('assets/icons/heart-shape-outline.svg',width: 20), onPressed: () {  },),
                            Container(width:size.width*0.20),
                            IconButton(icon: SvgPicture.asset('assets/icons/user.svg',width: 20), onPressed: () {  },),
                            IconButton(icon: SvgPicture.asset('assets/icons/open-box.svg',width: 20), onPressed: () {  },),
                          ],
                        )
                      )
                  ],
                ),
              )
            )
          ],
        ),
    );
  }
}


import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_in_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:deliclothes_flutter/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePageScreenInfoCustomized extends StatefulWidget {
  final String img, title, description;
  final int nextPage;
  const WelcomePageScreenInfoCustomized(
      {Key key, this.img, this.title, this.description, this.nextPage})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WelcomePageScreenInfoCustomizedState(
        this.img, this.title, this.description, this.nextPage);
  }
}

class WelcomePageScreenInfoCustomizedState
    extends State<WelcomePageScreenInfoCustomized> {
  final String img, title, description;
  final int nextPage;

  WelcomePageScreenInfoCustomizedState(
      this.img, this.title, this.description, this.nextPage);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.50,
            color: kPrimaryColor,
            child: CustomPaint(
              painter: BNBCustomPainter(),
              child: Column(children: [
                Container(
                  width: size.width,
                  height: size.height * 0.50,
                  //color: Colors.green,
                  child: Stack(children: [
                    Positioned(
                        top: 55,
                        left: 0,
                        child: Container(
                          height: 50,
                          width: size.width,
                          //color: Colors.orange,
                          child: Center(
                            child: Text('Deliclothes',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                    fontFamily: 'AvenirLight'))
                            ,
                          ),
                        )),
                    Positioned(
                      right: 0,
                      bottom: 1,
                      child: Container(
                          //color: Colors.red,
                          width: 200,
                          height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(img),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 100,
                      child: Container(
                          width: 200,
                          child: Text(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                  fontFamily: 'AvenirLight'))),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 40,
                      child: Container(
                          width: 200,
                          child: Text(description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  fontFamily: 'AvenirLight'))),
                    )
                  ]),
                ),
              ]),
            ),
          ),
          Container(
              width: size.width,
              height: size.height * 0.50,
              child: Stack(children: [
                Positioned(
                  bottom: 250,
                  left: size.width * 0.29,
                  child: GestureDetector(
                    onTap: () => {onPressedNavItem(nextPage)},
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xfffd8451), Color(0xffffbd6f)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(40)),
                      width: 180,
                      height: 45,
                      child: Center(
                        child: Text(AppLocalizations.of(context).welcome_page_text_button,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                fontFamily: 'AvenirLight')),
                      ),
                    ),
                  ),
                )
              ]))
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print(size.height);
    var paint = Paint();
    var path = Path();
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 0;
    paint.color = kPrimaryColor;
    path.moveTo(0, size.height);
    path.quadraticBezierTo(-1, size.height, -1, size.height);
    path.quadraticBezierTo(
        100, size.height + 150, size.width * 0.50, size.height);

    canvas.drawPath(path, paint);

    var paint1 = Paint();
    var path1 = Path();
    paint1.style = PaintingStyle.fill;
    paint1.strokeWidth = 0;
    paint1.color = Colors.white;
    path1.moveTo(size.width * 0.50, size.height);
    path1.quadraticBezierTo(
        size.width * 0.50, size.height, size.width * 0.50, size.height);

    path1.quadraticBezierTo(
        size.width * 0.75, size.height - 200, size.width, size.height - 150);

    canvas.drawPath(path1, paint1);

    var paint2 = Paint();
    var path2 = Path();
    paint2.style = PaintingStyle.fill;
    paint2.strokeWidth = 2;
    paint2.color = Colors.white;
    path2.moveTo(size.width * 0.50, size.height);
    path2.quadraticBezierTo(
        size.width * 0.50, size.height, size.width, size.height);

    path2.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 150);
    path2.quadraticBezierTo(
        size.width, size.height - 150, size.width * 0.50, size.height);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

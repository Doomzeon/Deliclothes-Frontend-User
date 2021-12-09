



import 'package:deliclothes_flutter/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 100,
      padding: EdgeInsets.only(top: 50),
      //color: Colors.orange,
      child: Row(
        children: [
          Container(
              child: IconButton(
            icon: SvgPicture.asset('assets/icons/left-arrow.svg',
                width: 20, color: kTextColor),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
          Container(
            margin: EdgeInsets.only(left: size.width*0.20),
            child: Center(
                child: Text(AppLocalizations.of(context).checkout_page_title,
                    style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        fontFamily: 'AvenirLight'))),
          )
        ],
      ),
    );
  }
}

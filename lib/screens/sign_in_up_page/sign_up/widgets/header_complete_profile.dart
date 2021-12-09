
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderContainerCompleteProfile extends StatelessWidget {
  const HeaderContainerCompleteProfile({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size.width,
          height: 80,
          padding: EdgeInsets.only(top: 50),
          child: Row(
            children: [
              IconButton(
                icon: SvgPicture.asset('assets/icons/left-arrow.svg',
                    width: 25, color: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                margin: EdgeInsets.only(left: size.width *0.15),
                child: Center(
                  child: Text(AppLocalizations.of(context).sign_up_2_page_title,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0,
                          fontFamily: 'AvenirLight')),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

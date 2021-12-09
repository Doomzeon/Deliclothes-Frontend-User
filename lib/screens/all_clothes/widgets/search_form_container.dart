import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterClothesTextField extends StatefulWidget {
  final Function callbackFilter;

  const FilterClothesTextField({Key key, this.callbackFilter}) : super(key: key);
  @override
  _FilterClothesTextFieldState createState() => _FilterClothesTextFieldState();
}

class _FilterClothesTextFieldState extends State<FilterClothesTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          height: 80,
          width: size.width,
          child: Stack(children: [
            Positioned(
              top: 3,
              left: size.width * 0.07,
              child: Container(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 300,
                      height: 45,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20.0,
                                color: Colors.grey[400],
                                offset: Offset(0, 0))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                      padding: EdgeInsets.only(left: 0, bottom: 5),
                      child: TextField(
                        onChanged:(value)=>{widget.callbackFilter(value)},
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 13.0,
                            fontFamily: 'AvenirLight'),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                            hintText: "Enter name of brand/clothe",
                            hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11.0,
                                fontFamily: 'AvenirLight'),
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                        //padding: EdgeInsets.all(5),
                        child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/filter.svg',
                        width: 25,
                        color: Colors.grey[500],
                      ),
                      onPressed: () {},
                    ))
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

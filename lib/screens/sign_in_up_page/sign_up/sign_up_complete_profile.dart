import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/logic/bloc/blocs/user_bloc.dart';
import 'package:deliclothes_flutter/logic/bloc/events/user_events.dart';
import 'package:deliclothes_flutter/logic/bloc/states/user_states.dart';
import 'package:deliclothes_flutter/models/credit_card.dart';
import 'package:deliclothes_flutter/models/user.dart';
import 'package:deliclothes_flutter/screens/home/home_new.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_up/widgets/credit_Card_container.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_up/widgets/header_complete_profile.dart';
import 'package:deliclothes_flutter/screens/sign_in_up_page/sign_up/widgets/text_form_container_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpCompleteProfile extends StatefulWidget {
  final String email, password;

  const SignUpCompleteProfile({Key key, this.email, this.password})
      : super(key: key);
  @override
  _SignUpCompleteProfileState createState() => _SignUpCompleteProfileState();
}

class _SignUpCompleteProfileState extends State<SignUpCompleteProfile> {
  String _name, _surname, _phoneCode, _street, _city;
  int _phoneNumber, _cap;
  CardType _cardType;
  PaymentCard _paymentCard = new PaymentCard();
  List<String> _dropDownValuesCodeNumbers = ['+39'];
  List<String> _dropDownValuesCityes = [
    'Milan',
    'Cormano',
    'Sesto San Giovanni',
    'Cinisello Balsamo'
  ];
    

  User _user = new User();


  @override
  Widget build(BuildContext context) {
  List<String> _dropDownValuesGender = [
     AppLocalizations.of(context).clothes_list_1_page_gender_man,
     AppLocalizations.of(context).clothes_list_1_page_gender_woman
  ];
    setName(value) {
      this._user.name = value;
    }

    setSurname(value) {
      this._user.surname = value;
    }

    setPhoneCode(value) {
      this._user.phone_code = value;
      print(this._user.phone_code);
    }

    setStreet(value) {
      this._user.street = value;
    }

    setCity(value) {
      this._user.city = value;
    }
    setGender(value){
      this._user.gender = value;
    }

    setPhoneNumber(value) {
      print(value);
      this._user.phone_number = int.parse(value);
    }

    setCap(value) {
      this._user.zip_code = int.parse(value);
    }

    setNumberCard(value) {
      this._user.card.number = value;
    }

    setCvc(value) {
      this._user.card.cvv = value;
    }

    setOwner(value) {
      this._user.card.owner = value;
    }

    setYear(value) {
      this._user.card.year = value;
    }

    setMonth(value) {
      this._user.card.month = value;
    }

    validateName(String value){
      if(value !='')
        return false;
      else
        return true;
    }

    validateSurname(String value){
      if(value !='')
        return false;
      else
        return true;
      
    }
    validatePhone(String value){
      if(value !='')
        return false;
      else
        return true;
    }
    validateCap(String value){
      if(value !='')
        return false;
      else
        return true;
    }

    validateResidence(String value){
      if(value !='')
        return false;
      else
        return true;
    }

    Size size = MediaQuery.of(context).size;
  this._user.email = widget.email;
  this._user.password = widget.password;
    return Scaffold(
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserRegisterInProgress) {
        return SpinnerContainer(size);
      } else {
        return SingleChildScrollView(
                  child: Column(
            children: [
              HeaderContainerCompleteProfile(size: size),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormContainerSignUp(
                    callbackFunction: setName,
                    widthContainer: size.width - 50,
                    hintText: AppLocalizations.of(context).sign_up_input_name,
                    icon: Icons.person_outlined,
                    validationCallback: validateName,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormContainerSignUp(
                    validationCallback: validateSurname,
                    callbackFunction: setSurname,
                    widthContainer: size.width - 50,
                    hintText: AppLocalizations.of(context).sign_up_input_surname,
                    icon: Icons.person_outlined,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropDownContainer(
                      callbackFunction: setPhoneCode,
                      dropDownItems: this._dropDownValuesCodeNumbers,
                      widthContainer: 100),
                  TextFormContainerSignUp(
                    inputType: 'Num',
                    lenghtMax:10,
                    validationCallback: validatePhone,
                    callbackFunction: setPhoneNumber,
                    widthContainer: size.width - 150,
                    hintText: AppLocalizations.of(context).sign_up_input_phone,
                    icon: null,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropDownContainer(
                      callbackFunction: setCity,
                      dropDownItems: this._dropDownValuesCityes,
                      widthContainer: size.width - 50),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropDownContainer(
                      callbackFunction: setGender,
                      dropDownItems: _dropDownValuesGender,
                      widthContainer: size.width - 50),
                ],
              ),
              Container(
                //color: Colors.red,
                width: size.width,
                padding: EdgeInsets.only(left:25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormContainerSignUp(
                      validationCallback: validateResidence,
                      callbackFunction: setStreet,
                      widthContainer: size.width *0.60- 10,
                      hintText: AppLocalizations.of(context).sign_up_input_residence,
                      icon: Icons.location_city_outlined,
                    ),
                    TextFormContainerSignUp(
                      inputType: 'Num',
                      lenghtMax:5,
                      validationCallback: validateCap,
                      callbackFunction: setCap,
                      widthContainer: size.width *0.30 ,
                      hintText: AppLocalizations.of(context).sign_up_input_zip_code,
                      icon: Icons.location_city_outlined,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              CreditCardRow(
                  callBackFunctionNumberCard: setNumberCard,
                  callBackFunctionYear: setYear,
                  callBackFunctionMonth: setMonth,
                  callBackFunctionCvv: setCvc,
                  callBackOwner: setOwner),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => {
      print(this._user.phone_code),
                      BlocProvider.of<UserBloc>(context)
                          .add(UserRegister(
                            this._user
                          ))


                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      width: 180,
                      height: 45,
                      child: Center(
                        child: Text(AppLocalizations.of(context).sign_up_button_text_register,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                fontFamily: 'AppleBraille')),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }
    }));
  }
}

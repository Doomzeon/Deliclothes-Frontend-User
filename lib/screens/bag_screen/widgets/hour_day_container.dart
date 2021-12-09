import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliclothes_flutter/components/custom_time_picker.dart';
import 'package:deliclothes_flutter/constant.dart';
import 'package:deliclothes_flutter/models/confirm_order.dart';
import 'package:deliclothes_flutter/models/delivery_hour_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

class HourDelivery extends StatefulWidget {
  final DeliveryHourDate data;
  final Function setDayDelivery;
  final Function setHourDelivery;

  const HourDelivery(
      {Key key, this.data, this.setDayDelivery, this.setHourDelivery})
      : super(key: key);
  @override
  _HourDeliveryState createState() => _HourDeliveryState();
}

class _HourDeliveryState extends State<HourDelivery> {
  DateTime _date;
  String selectedTime='';

  @override
  Widget build(BuildContext context) {
    buildCupertinoDatePicker(BuildContext context, DeliveryHourDate data) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return Container(
                height: MediaQuery.of(context).copyWith().size.height / 3,
                color: Colors.white,
                child: SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.single,
                  view: DateRangePickerView.month,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    //var visibleDates = args.value;
                    super.setState(() {
                      this._date = args.value;
                      widget.setDayDelivery(args.value);
                    });
                  },
                ));
          });
    }

    Size size = MediaQuery.of(context).size;
    List<int> _availableHours = generateAvailableHours(widget.data);
    List<int> _availableMinutes = [0, 10, 20, 30, 40, 50];
    return Container(
        width: size.width,
        height: 110,
        color: Colors.white,
        child: Column(children: [
          Row(
            children: [
              Container(
                  width: 200,
                  padding: EdgeInsets.only(top: 10, left: 25),
                  child: AutoSizeText(
                      AppLocalizations.of(context).checkout_page_hour_delivery +
                          (selectedTime != '' ? selectedTime : "---"),
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 14.0,
                          fontFamily: 'AvenirLight'))),
              GestureDetector(
                  child: Container(
                    width: 100,
                    height: 35,
                    margin: EdgeInsets.only(top: 10, left: size.width * 0.15),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 20.0,
                              color: Colors.grey[400],
                              offset: Offset(0, 0))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Cambia', //TODO
                        style: TextStyle(fontSize: 12.5),
                      ),
                    ),
                  ),
                  onTap: () {
                    showCustomTimePicker(
                        context: context,
                        onFailValidation: (context) =>
                            showMessage(context, 'Unavailable selection.'),
                        initialTime: TimeOfDay(
                            hour: _availableHours.first,
                            minute: _availableMinutes.first),
                        selectableTimePredicate: (time) =>
                            _availableHours.indexOf(time.hour) != -1 &&
                            _availableMinutes.indexOf(time.minute) !=
                                -1).then((time) => super.setState(() => {
                          selectedTime = time?.format(context),
                          widget.setHourDelivery(selectedTime)
                        })); // buildCupertinoTimePicker(context, widget.data);
                  })
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: 200,
                  padding: EdgeInsets.only(top: 10, left: 25),
                  child: AutoSizeText(
                      AppLocalizations.of(context).checkout_page_day_delivery +
                          (_date != null
                              ? _date.day.toString() +
                                  '/' +
                                  (_date.month.toString().length == 1
                                      ? '0' + _date.month.toString()
                                      : _date.month.toString()) +
                                  '/' +
                                  _date.year.toString()
                              : '----'),
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 14.0,
                          fontFamily: 'AvenirLight'))),
              GestureDetector(
                  child: Container(
                    width: 100,
                    height: 35,
                    margin: EdgeInsets.only(top: 10, left: size.width * 0.15),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 20.0,
                              color: Colors.grey[400],
                              offset: Offset(0, 0))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Cambia', //TODO
                        style: TextStyle(fontSize: 12.5),
                      ),
                    ),
                  ),
                  onTap: () {
                    buildCupertinoDatePicker(context, widget.data);
                  })
            ],
          ),
        ]));
  }
}

showMessage(BuildContext context, String message) => showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16,
            ),
            Icon(
              Icons.warning,
              color: Colors.amber,
              size: 56,
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF231F20),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xFFE8ECF3)))),
                child: Text(
                  'Cerrar',
                  style: TextStyle(
                      color: Color(0xFF2058CA),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
    });

generateAvailableHours(DeliveryHourDate data) {
  if (data.hoursUnavailable == null) {
    return [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
  } else {
    var itemsList = List<int>.generate(24, (index) => null);
    for (var it = 0; it < itemsList.length; it++) {
      for (var i = 0; i < data.hoursUnavailable.length; i++) {
        if (data.hoursUnavailable[i].hourFrom.hour <= itemsList[it] &&
            data.hoursUnavailable[i].hourTo.hour >= itemsList[it]) {
          itemsList.removeAt(it);
        }
      }
    }
    return itemsList;
  }
}

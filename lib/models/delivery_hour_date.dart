class DeliveryHourDate {
  final List<DeliveryHourDateTime> hoursUnavailable;
  final String directions;

  DeliveryHourDate( this.directions, this.hoursUnavailable);

  static DeliveryHourDate fromJson(dynamic data) {
    if (data['time_unavailable'].length > 0)
      return DeliveryHourDate(
          data['directions'].toString() as String,
          List<DeliveryHourDateTime>.from(data['time_unavailable']
              .map((e) => DeliveryHourDateTime.fromJson(e)) ,
          ));
    else
      return DeliveryHourDate( data['directions'].toString() as String, null);
  }
}


class DeliveryHourDateTime {
  final DateTime hourFrom;
  final DateTime hourTo;

  DeliveryHourDateTime(this.hourFrom, this.hourTo);
  
static DeliveryHourDateTime fromJson(dynamic data) {
  print(data);
  return DeliveryHourDateTime(
    DateTime.parse(data['from']),
    DateTime.parse(data['to'])
  );
}

}

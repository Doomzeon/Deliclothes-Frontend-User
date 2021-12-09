

class ConfirmOrder{
   double amount;
   int creditCardId, zipCode;
   String city;
   String streetName, hourDelivery;
   DateTime dayDelivery;
   String creditCardStripeId;

  ConfirmOrder({this.amount, this.streetName, this.hourDelivery, this.dayDelivery});

}
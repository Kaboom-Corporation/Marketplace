import 'dart:convert';

class Offer {
  String offererName;
  String price;
  String currency;
  String paymentMethode;
  String possibleDate;
  String comment;
  String productName;
  String productId;
  Offer({
    required this.offererName,
    required this.price,
    required this.currency,
    required this.paymentMethode,
    required this.possibleDate,
    required this.comment,
    required this.productName,
    required this.productId,
  });

  Map<String, dynamic> toMap() {
    return {
      'offererName': offererName,
      'price': price,
      'currency': currency,
      'paymentMethode': paymentMethode,
      'possibleDate': possibleDate,
      'comment': comment,
      'productName': productName,
      'productId': productId,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      offererName: map['offererName'] ?? '',
      price: map['price'] ?? '',
      currency: map['currency'] ?? '',
      paymentMethode: map['paymentMethode'] ?? '',
      possibleDate: map['possibleDate'] ?? '',
      comment: map['comment'] ?? '',
      productName: map['productName'] ?? '',
      productId: map['productId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) => Offer.fromMap(json.decode(source));
}

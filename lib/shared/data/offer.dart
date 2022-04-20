import 'dart:convert';

class Offer {
  String offererName;
  String offererId;
  String price;
  String currency;
  String paymentMethode;
  String possibleDate;
  String comment;
  String productName;
  String productId;
  bool? selected;
  Offer({
    required this.offererName,
    required this.offererId,
    required this.price,
    required this.currency,
    required this.paymentMethode,
    required this.possibleDate,
    required this.comment,
    required this.productName,
    required this.productId,
    this.selected,
  });

  Map<String, dynamic> toMap() {
    return {
      'offererName': offererName,
      'offererId': offererId,
      'price': price,
      'currency': currency,
      'paymentMethode': paymentMethode,
      'possibleDate': possibleDate,
      'comment': comment,
      'productName': productName,
      'productId': productId,
      'selected': selected,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      offererName: map['offererName'] ?? '',
      offererId: map['offererId'] ?? '',
      price: map['price'] ?? '',
      currency: map['currency'] ?? '',
      paymentMethode: map['paymentMethode'] ?? '',
      possibleDate: map['possibleDate'] ?? '',
      comment: map['comment'] ?? '',
      productName: map['productName'] ?? '',
      productId: map['productId'] ?? '',
      selected: map['selected'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) => Offer.fromMap(json.decode(source));
}

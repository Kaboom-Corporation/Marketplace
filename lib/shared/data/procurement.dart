import 'dart:convert';

class Procurement {
  String procurementType;
  String name;
  String quantity;
  String price;
  String currency;
  String paymentMethod;
  String productType;
  String endDate;
  String deliveryAddress;
  String comment;
  String organisationName;
  Procurement({
    required this.procurementType,
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
    required this.paymentMethod,
    required this.productType,
    required this.endDate,
    required this.deliveryAddress,
    required this.comment,
    required this.organisationName,
  });

  Map<String, dynamic> toMap() {
    return {
      'procurementType': procurementType,
      'name': name,
      'quantity': quantity,
      'price': price,
      'currency': currency,
      'paymentMethod': paymentMethod,
      'productType': productType,
      'endDate': endDate,
      'deliveryAddress': deliveryAddress,
      'comment': comment,
      'organisationName': organisationName,
    };
  }

  factory Procurement.fromMap(Map<String, dynamic> map) {
    return Procurement(
      procurementType: map['procurementType'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? '',
      price: map['price'] ?? '',
      currency: map['currency'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      productType: map['productType'] ?? '',
      endDate: map['endDate'] ?? '',
      deliveryAddress: map['deliveryAddress'] ?? '',
      comment: map['comment'] ?? '',
      organisationName: map['organisationName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Procurement.fromJson(String source) => Procurement.fromMap(json.decode(source));
}

//"auction" : "fixed"

enum ProcurementType { Auction, Fixed }

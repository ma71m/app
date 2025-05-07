// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Deal {
  final String id;
  final String image;
  final String title;
  final String description;
  final double price;
  final double Minprice;
  final double Maxprice;
  final Timestamp timer; // Changed from Duration to Timestamp
  final int numofbuyers;
  final int maxbuyers;

  const Deal({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.Minprice,
    required this.Maxprice,
    required this.timer,
    required this.numofbuyers,
    required this.maxbuyers,
  });

  factory Deal.fromMap(Map<String, dynamic> map) {
    return Deal(
      id: map['id'],
      numofbuyers: map['numofbuyers'],
      maxbuyers: map['maxbuyers'],
      image: map['image'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      Minprice: map['Minprice'],
      Maxprice: map['Maxprice'],
      timer: map['timer'],
    );
  }

  // Add a method to calculate the remaining time
  Duration get remainingTime {
    final deadline = timer.toDate();
    final now = DateTime.now();

    if (deadline.isBefore(now)) {
      return Duration.zero; // or some other default value
    }

    return deadline.difference(now);
  }
}

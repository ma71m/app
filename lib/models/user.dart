import 'package:sahla/models/order.dart';

class User {
  final List<Order>? orders;
  final String? username;
  final String? email;
  final String? userimageAssetPath;
  final int? moneyAmount;

  User(
      {required this.username,
      required this.email,
      this.orders,
      this.userimageAssetPath,
      this.moneyAmount});
}

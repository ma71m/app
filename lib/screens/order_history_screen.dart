import 'package:flutter/material.dart';
import 'package:sahla/app_styles.dart';

import '../models/order.dart';

class OrderHistoryScreen extends StatelessWidget {
  final List<Order> orderList = [
    Order(
      image: 'assets/deal_images/deal1.jpg',
      title: 'Deal 1',
      date: DateTime(2022, 3, 1),
      price: 19.99,
    ),
    Order(
      image: 'assets/deal_images/deal2.jpg',
      title: 'Deal 2',
      date: DateTime(2022, 2, 28),
      price: 29.99,
    ),
    // Add more orders here
  ];

   OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyles.primaryColor,
          title: Text(
            'Order History',
            style: AppStyles.primaryFont.copyWith(
              color: AppStyles.white,
            ),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orderList.length,
          itemBuilder: (context, index) {
            final order = orderList[index];
            return Column(
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 90, // Set the desired height here
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width * 0.35,
                            height:
                                70, // Make the container fill the available height
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              order.title,
                              style: AppStyles.orderHistoryTitle,
                            ),
                            subtitle: Text(
                              '${order.date.year}-${order.date.month}-${order.date.day}',
                              style: AppStyles.secondaryFont,
                            ),
                            trailing: Text(
                              '\$${order.price}',
                              style: AppStyles.orderHistoryPrice,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            );
          },
        ));
  }
}

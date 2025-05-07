// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:sahla/app_styles.dart';
import 'package:sahla/screens/deal_detail_screen.dart';
import 'package:sahla/utils/slideRoute.dart';
import 'package:sahla/widgets/countDownTimer.dart';

class DealCard extends StatelessWidget {
  final String dealId;
  final String image;
  final String title;
  final double price;
  final String discription;
  final double Minprice;
  final double Maxprice;
  final Duration timer;
  final int numofbuyers;
  final int maxbuyers;

  DealCard({super.key, 
    required this.dealId,
    required this.image,
    required this.title,
    required this.price,
    required this.discription,
    required this.Minprice,
    required this.Maxprice,
    required this.timer,
    required this.numofbuyers,
    required this.maxbuyers,
  });
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => _foldingCellKey.currentState?.toggleFold(),
      child: SimpleFoldingCell.create(
        key: _foldingCellKey,
        frontWidget: _buildFrontWidget(context),
        innerWidget: _buildInnerWidget(context),
        cellSize: Size(MediaQuery.of(context).size.width * 0.9,
            MediaQuery.of(context).size.height * 0.21),
        padding: const EdgeInsets.all(16),
        borderRadius: 10,
        onOpen: () => print('$title open'),
        onClose: () => print('$title closed'),
      ),
    );
  }

  Widget _buildFrontWidget(context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyles.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: Text(
                    title,
                    style: AppStyles.dealCardTitle.copyWith(height: 0.9),
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '\$$price',
                      style: AppStyles.dealCardPrice,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Icon(
                      Icons.arrow_downward,
                      color: Color(0xFF0bd605),
                      size: 20,
                    ),
                    Text(
                      '\$$Minprice',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0bd605),
                      ),
                      textScaler: const TextScaler.linear(0.45),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 10),
            Center(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInnerWidget(context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyles.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.19,
                    width: MediaQuery.of(context).size.width * 0.35,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Text(
                    title,
                    style: AppStyles.dealDetailTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.11,
              width: MediaQuery.of(context).size.width * 1,
              child: Text(
                discription,
                style: AppStyles.dealDetailDescription,
                overflow: TextOverflow.fade,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.78,
                            MediaQuery.of(context).size.height * 0.072),
                        foregroundColor: AppStyles.black1,
                        backgroundColor: AppStyles.primaryColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(2),
                                topRight: Radius.circular(2),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          SlideRoute(
                              page: DealDetailScreen(
                            dealId: dealId,
                          )));
                    },
                    child: Row(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$$price',
                              style: AppStyles.dealCardPrice,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  size: 20,
                                  Icons.arrow_downward_sharp,
                                  color: Color(0xFF0bd605),
                                ),
                                Text(
                                  '\$$Minprice',
                                  textScaler: const TextScaler.linear(0.5),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0bd605),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            CountdownTimer(
                              duration: timer,
                              style: AppStyles.dealCardPrice,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.shopping_cart,
                              color: AppStyles.dealCardPrice.color,
                              size: 22,
                            )
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

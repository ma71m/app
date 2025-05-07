import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahla/app_styles.dart';
import 'package:sahla/widgets/countDownTimer.dart';
import 'package:simple_animated_button/elevated_layer_button.dart';

import '../models/deal.dart';

class DealDetailScreen extends StatefulWidget {
  final String dealId;

  const DealDetailScreen({super.key, required this.dealId});
  @override
  State<DealDetailScreen> createState() => _DealDetailScreenState();
}

class _DealDetailScreenState extends State<DealDetailScreen> {
  Deal? _deal;

  @override
  void initState() {
    super.initState();
    _fetchDeal();
  }

  Future<void> _fetchDeal() async {
    final dealRef =
        FirebaseFirestore.instance.collection('deals').doc(widget.dealId);
    final dealDoc = await dealRef.get();
    final dealData = dealDoc.data() as Map<String, dynamic>;
    setState(() {
      _deal = Deal.fromMap(dealData);
    });
  }

  @override
  Widget build(BuildContext context) {
    final countdownFuture = Future.delayed(const Duration(milliseconds: 500));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        title: Text(
          _deal?.title ?? 'Loading...',
          style: AppStyles.primaryFont.copyWith(
            color: AppStyles.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              _deal?.image ?? 'Loading...', //TODO: put image of loading
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  _deal?.title ?? 'Loading...',
                  style: AppStyles.dealDetailTitle,
                ),
                const SizedBox(height: 8),
                Text(
                  _deal?.description ?? 'Loading...',
                  maxLines: 6,
                  style: AppStyles.dealDetailDescription.copyWith(
                    overflow: TextOverflow.fade,
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${_deal?.numofbuyers ?? 'Loading...'}/${_deal?.maxbuyers ?? 'Loading...'} Bought ',
                      style: AppStyles.dealCardPrice.copyWith(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedLayerButton(
                        buttonHeight: 55,
                        topDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber,
                          border: Border.all(),
                        ),
                        baseDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppStyles.secondaryColor,
                          border: Border.all(),
                        ),
                        buttonWidth: 160,
                        animationDuration: const Duration(milliseconds: 200),
                        animationCurve: Curves.ease,
                        topLayerChild: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Share",
                              style:
                                  AppStyles.primaryFont.copyWith(fontSize: 23),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.share,
                              color: AppStyles.black1,
                            )
                          ],
                        ),
                        onClick: () {})
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${_deal?.price ?? 'Loading...'}',
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
                              '\$${_deal?.Minprice ?? 'Loading...'}',
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
                    FutureBuilder(
                      future: countdownFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // or some other loading indicator
                        } else {
                          return _deal?.remainingTime != Duration.zero
                              ? CountdownTimer(
                                  duration: _deal!.remainingTime,
                                  style: AppStyles.dealCardPrice,
                                )
                              : const Text('Countdown has ended');
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: AppStyles.primaryColor,
                      ),
                      child: Text('Purchase',
                          style: AppStyles.secondaryFont.copyWith(
                              fontSize: 24, color: AppStyles.lightGrey)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:sahla/app_styles.dart';
import 'package:sahla/services/providers.dart';
import 'package:sahla/utils/fadeslide.dart';
import 'package:sahla/widgets/deal_card.dart';

import 'user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isRefreshing = false;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final dealProvider = Provider.of<DealProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    dealProvider.fetchDeals();
    userProvider.fetchUserData(forceRefresh: true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var dealProvider = Provider.of<DealProvider>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(),
        isExtended: true,
        onPressed: () async {
          setState(() {
            _isRefreshing = true;
          });
          await dealProvider.fetchDeals();
          await userProvider.fetchUserData(forceRefresh: true);
          setState(() {
            _isRefreshing = false;
          });
        },
        tooltip: 'Refresh',
        child: _isRefreshing
            ? const CircularProgressIndicator()
            : const Icon(Icons.refresh),
      ),
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        actions: [
          TextButton(
              onPressed: () {
                FlutterEasyDialogs.show(EasyDialog.positioned(
                    decoration: const EasyDialogAnimation.fade(),
                    content: Container(
                        height: 150.0,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:[],
                        )),
                    id: "Payment"));
              },
              child: Text(
                "\$${userProvider.moneyAmount}",
                style: AppStyles.primaryFont.copyWith(fontSize: 20),
              )),
          const SizedBox(
            width: 8,
          )
        ],
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            shadowColor: Colors.transparent, // Use the default icon color
            elevation: 0, // No shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(50, 50), // Set the button size
            padding: EdgeInsets.zero, // Remove default padding
          ),
          onPressed: () {
            Navigator.push(
              context,
              FadeSlideRoute(
                page: const UserProfileScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.person,
            size: 32,
          ), // TODO: must be changed to profile avatar
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: dealProvider.deals.isEmpty
                ? const Center(
                    child: Text(
                    "There is no deals at the moment",
                  ))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: dealProvider.deals.length,
                    itemBuilder: (context, index) {
                      var deal = dealProvider.deals[index];
                      return DealCard(
                        discription: deal.description,
                        image: deal.image,
                        title: deal.title,
                        price: deal.price,
                        Minprice: deal.Minprice,
                        Maxprice: deal.Maxprice,
                        timer: deal.remainingTime,
                        numofbuyers: deal.numofbuyers,
                        maxbuyers: deal.maxbuyers,
                        dealId: deal.id,
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/Logo.png',
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

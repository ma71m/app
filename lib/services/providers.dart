import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sahla/models/deal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String? _uid;
  String? _displayName;
  String? _email;
  int? _moneyAmount;
  List<dynamic>? _orders;
  String? _userImageAssetPath;

  String? get displayName => _displayName;
  String? get email => _email;
  int? get moneyAmount => _moneyAmount;
  List<dynamic>? get orders => _orders;
  String? get userImageAssetPath => _userImageAssetPath;

  Future<void> fetchUserData({bool forceRefresh = false}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (forceRefresh || !sharedPreferences.containsKey('displayName')) {
      try {
        await _loadFromFirebase();
        print("Firebase");
        _saveToSharedPreferences(sharedPreferences);
      } catch (e) {
        print('Error loading data from Firebase: $e');
      }
    } else {
      _loadFromSharedPreferences(sharedPreferences);
      print("shared");
      print(displayName);
      print(email);
      print(_uid);
    }
    notifyListeners();
  }

  Future<void> _loadFromFirebase() async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    final userDocRef = firestore.collection('users').doc(user.uid);
    final userData = await userDocRef.get();
    if (userData.exists) {
      final data = userData.data()!;
      _displayName = data['displayName'];
      _email = data['email'];
      _moneyAmount = data['moneyAmount'] ?? 0;
      _orders = data['orders'];
      _userImageAssetPath = data['userImageAssetPath'];
    } else {
      throw Exception('User data not found in Firestore');
    }
  }

  void _loadFromSharedPreferences(SharedPreferences sharedPreferences) {
    _displayName = sharedPreferences.getString('displayName');
    _email = sharedPreferences.getString('email');
    _moneyAmount = sharedPreferences.getInt('moneyAmount') ?? 0;
    final ordersList = sharedPreferences.getStringList('orders');
    if (ordersList != null) {
      _orders = ordersList.map((e) => jsonDecode(e)).toList();
    }
    _userImageAssetPath = sharedPreferences.getString('userImageAssetPath');
  }

  void _saveToSharedPreferences(SharedPreferences sharedPreferences) {
    if (_displayName != null && _email != null) {
      sharedPreferences.setString('displayName', _displayName!);
      sharedPreferences.setString('email', _email!);
      sharedPreferences.setInt('moneyAmount', _moneyAmount ?? 0);
      if (_orders != null) {
        sharedPreferences.setStringList(
            'orders', _orders!.map((e) => jsonEncode(e)).toList());
      } else {
        sharedPreferences.setStringList('orders', []);
      }
      sharedPreferences.setString(
          'userImageAssetPath', _userImageAssetPath ?? '');
    } else {
      print('Display name and email are required');
    }
  }

  Future<void> login(String email, String password) async {
    const storage = FlutterSecureStorage();
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    _uid = user!.uid;
    await storage.write(key: 'authToken', value: _uid);
    await fetchUserData();
  }

  Future<void> logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('email');
    sharedPreferences.remove('password');
    sharedPreferences.remove('displayName');
    sharedPreferences.remove('email');
    sharedPreferences.remove('moneyAmount');
    sharedPreferences.remove('orders');
    sharedPreferences.remove('userImageAssetPath');
  }
}

class DealProvider with ChangeNotifier {
  List<Deal> _deals = [];

  List<Deal> get deals {
    return [..._deals];
  }

  Future<void> fetchDeals() async {
    try {
      final dealsRef = FirebaseFirestore.instance.collection('deals');
      final dealsSnapshot = await dealsRef.get();
      final dealsList =
          dealsSnapshot.docs.map((doc) => Deal.fromMap(doc.data())).toList();
      _deals = dealsList;
      notifyListeners();
    } catch (error) {
      print('Error fetching deals: $error');
    }
  }
}

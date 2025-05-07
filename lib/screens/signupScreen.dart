import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahla/app_styles.dart';
import 'package:sahla/screens/home_screen.dart';
import 'package:sahla/services/providers.dart';
import 'package:sahla/utils/slideRoute.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key, required this.controller});
  final PageController controller;
  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Center(
              child: SizedBox(height: MediaQuery.of(context).size.height *0.38,
                child: Image.asset(
                  "assets/images/signup.jpeg",
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Sign Up',
                      style: AppStyles.primaryFont.copyWith(fontSize: 45),
                    ),
                    const Spacer(),
                    _isLoading
                        ? const CircularProgressIndicator(
                            strokeWidth: 7,
                            color: AppStyles.darkOrange,
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _usernameController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppStyles.black1,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: AppStyles.secondaryFont
                        .copyWith(color: AppStyles.darkOrange),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppStyles.black1,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppStyles.primaryColor,
                      ),
                    ),
                  ),
                ),  /// Username
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _emailController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppStyles.black1,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: AppStyles.secondaryFont
                        .copyWith(color: AppStyles.darkOrange),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppStyles.black1,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppStyles.primaryColor,
                      ),
                    ),
                  ),
                ),  /// Email
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _passController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppStyles.black1,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: AppStyles.primaryFont.copyWith(
                      color: AppStyles.darkOrange,
                      fontSize: 13,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppStyles.black1,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppStyles.primaryColor,
                      ),
                    ),
                  ),
                ),   /// Password
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text('Have an account?',
                        style: AppStyles.secondaryFont
                            .copyWith(fontSize: 13, color: AppStyles.black1)),
                    const SizedBox(
                      width: 2.5,
                    ),
                    InkWell(
                      onTap: () {
                        widget.controller.animateToPage(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      child: Text('Log In',
                          style: AppStyles.secondaryFont.copyWith(
                              fontSize: 14, color: AppStyles.darkOrange)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          // Create a new user in Firebase Auth
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passController.text,
                          );

                          // Get the current user
                          final user = userCredential.user;

                          // Create a new document in Firestore
                          final firestore = FirebaseFirestore.instance;
                          final userDocRef =
                              firestore.collection('users').doc(user!.uid);
                          await userDocRef.set({
                            'displayName': _usernameController.text,
                            'email': _emailController.text,
                            'moneyAmount': 0,
                            'orders': [],
                          });

                          // Save credentials to SharedPreferences
                          final userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          userProvider.login(
                              _emailController.text, _passController.text);

                          // Navigate to HomeScreen
                          Navigator.pushReplacement(
                            context,
                            SlideRoute(page: const HomeScreen()),
                          );
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: AwesomeSnackbarContent(
                                inMaterialBanner: true,
                                title: 'Error',
                                message: e.message!,
                                contentType: ContentType.failure,
                              ),
                            ),
                          );
                        } catch (e) {
                          // Handle any other exceptions
                          print('Error: $e');
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: AppStyles.primaryColor,
                      ),
                      child: Text('Sign Up',
                          style: AppStyles.secondaryFont.copyWith(
                              fontSize: 24, color: AppStyles.lightGrey)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

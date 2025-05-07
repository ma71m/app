import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahla/app_styles.dart';
import 'package:sahla/screens/home_screen.dart';
import 'package:sahla/screens/signupScreen.dart';
import 'package:sahla/services/providers.dart';
import 'package:sahla/utils/slideRoute.dart';

class MainView extends StatefulWidget {
  final int index;

  const MainView({super.key, required this.index});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        controller: controller,
        itemBuilder: (context, index) {
          if (index == 0) {
            return LoginScreen(
              controller: controller,
            );
          } else if (index == 1) {
            return SingUpScreen(
              controller: controller,
            );
          }
          return null;
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.controller});
  final PageController controller;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              child: SizedBox(height: MediaQuery.of(context).size.height *0.42,
                child: Image.asset(
                  "assets/images/signin.png", //TODO: Image for LOGIN
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
                      'Log In',
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
                  controller: _emailController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppStyles.black1,
                    fontSize: 15,
                    fontFamily: 'Poppins',
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
                ),
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
                    labelStyle: AppStyles.primaryFont
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
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text('Don’t have an account?',
                        style: AppStyles.secondaryFont
                            .copyWith(fontSize: 13, color: AppStyles.black1)),
                    const SizedBox(
                      width: 2.5,
                    ),
                    InkWell(
                      onTap: () {
                        widget.controller.animateToPage(1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      child: Text('Sign Up',
                          style: AppStyles.secondaryFont.copyWith(
                              fontSize: 14, color: AppStyles.darkOrange)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  // TODO: Remember to add Inkwell And Make This Button
                  'Forget Password?',
                  style: AppStyles.secondaryFont.copyWith(fontSize: 13),
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
                          final userProvider = Provider.of<UserProvider>(context, listen: false);
                          await userProvider.login(_emailController.text, _passController.text);
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
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width, 30),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        backgroundColor: AppStyles.primaryColor,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                        color: AppStyles.lightGrey,
                      )
                          : Text(
                        'Sign In',
                        style: AppStyles.secondaryFont.copyWith(
                          fontSize: 24,
                          color: AppStyles.lightGrey,
                        ),
                      ),
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

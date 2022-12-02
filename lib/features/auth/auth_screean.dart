import 'package:ashewa_apps_with_nodejs/common/widgets/custom_button.dart';
import 'package:ashewa_apps_with_nodejs/common/widgets/custom_textfiled.dart';
import 'package:ashewa_apps_with_nodejs/constants/global_varible.dart';
import 'package:ashewa_apps_with_nodejs/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;

  final _formkey = GlobalKey<FormState>();
  final _signinformkey = GlobalKey<FormState>();

  final AuthService authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailforsigninController =
      TextEditingController();
  final TextEditingController passwordforsigninController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signUp() {
    authService.signupUser(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
  }

  void signIn() {
    authService.signInUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVirable.greyBackgroundCOlor,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset(
                    "assets/ic_launcher.png",
                    fit: BoxFit.fill,
                  ),
                ),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? GlobalVirable.backgroundColor
                      : GlobalVirable.greyBackgroundCOlor,
                  title: const Text('Create Account'),
                  leading: Radio(
                      activeColor: GlobalVirable.secondaryColor,
                      value: Auth.signup,
                      groupValue: _auth,
                      onChanged: ((Auth? value) {
                        setState(() {
                          _auth = value!;
                        });
                      })),
                ),

                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: GlobalVirable.backgroundColor,
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          CustomTextFiled(
                            controller: nameController,
                            hintText: 'Name',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFiled(
                            controller: emailController,
                            hintText: 'Email',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFiled(
                            controller: passwordController,
                            hintText: 'Password',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              text: 'Sign Up',
                              onTap: (() {
                                if (_formkey.currentState!.validate()) {
                                  signUp();
                                }
                              }))
                        ],
                      ),
                    ),
                  ),

                // Form(key: _signinformkey,child: Column(children: [],),),
                ListTile(
                  title: const Text('Sign In.'),
                  tileColor: _auth == Auth.signin
                      ? GlobalVirable.backgroundColor
                      : GlobalVirable.greyBackgroundCOlor,
                  leading: Radio(
                    activeColor: GlobalVirable.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: ((Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    }),
                  ),
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: GlobalVirable.backgroundColor,
                    child: Form(
                      key: _signinformkey,
                      child: Column(
                        children: [
                          CustomTextFiled(
                            controller: emailforsigninController,
                            hintText: 'Email',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFiled(
                            controller: passwordforsigninController,
                            hintText: 'Password',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              text: 'Sign In',
                              onTap: (() {
                                if (_signinformkey.currentState!.validate()) {
                                  signIn();
                                }
                              }))
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          )),
        ));
  }
}

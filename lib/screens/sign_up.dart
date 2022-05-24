import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_haffeli/services/firebase_auth.dart';
import '../reusable/delayed.dart';
import '../reusable/reusable_widgets.dart';
import 'bienvenue.dart';

class sign_Up extends StatefulWidget {
  const sign_Up({Key? key}) : super(key: key);

  @override
  State<sign_Up> createState() => _sign_UpState();
}

class _sign_UpState extends State<sign_Up> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Sign UP",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.1, 20, 0),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 600,
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    SizedBox(height: 30),
                    delayed(
                      delay: 1500,
                      child: reusableTextFeild(
                          "Entre UserName",
                          Icons.person_outline,
                          false,
                          _userNameTextController,
                          "username"),
                    ),
                    SizedBox(height: 20),
                    delayed(
                      delay: 2000,
                      child: reusableTextFeild(
                          "Entre Email ",
                          Icons.person_outline,
                          false,
                          _emailTextController,
                          "email"),
                    ),
                    SizedBox(height: 20),
                    delayed(
                      delay: 2500,
                      child: reusableTextFeild(
                          "Enter Password",
                          Icons.lock_outline,
                          true,
                          _passwordTextController,
                          "password"),
                    ),
                    SizedBox(height: 15),
                    delayed(
                        delay: 3000,
                        child: signInSignUpButton(
                            context, "Sign Up", Icons.email, Colors.grey,
                            () async {
                          if (_formKey.currentState!.validate()) {
                            firebaseAuthService(FirebaseAuth.instance)
                                .Sign_up_WithEmail(
                                    _emailTextController.text,
                                    _passwordTextController.text,
                                    _userNameTextController.text,
                                    context);
                          }
                        })),
                    SizedBox(height: 30),
                    delayed(
                        delay: 3500,
                        child: signInSignUpButton(
                            context,
                            "Sign Up With Gmail",
                            FontAwesomeIcons.google,
                            Color.fromARGB(255, 241, 66, 8), () async {
                          await firebaseAuthService(FirebaseAuth.instance)
                              .sign_up_WithGoogle(context);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => bienvenue()));
                        })),
                    SizedBox(height: 0),
                    delayed(
                        delay: 3500,
                        child: signInSignUpButton(
                            context,
                            "Sign Up With Facebook",
                            FontAwesomeIcons.facebook,
                            Color.fromARGB(255, 6, 100, 177), () async {
                          await firebaseAuthService(FirebaseAuth.instance)
                              .sign_up_WithFacebook(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => bienvenue()));
                        })),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_haffeli/services/firebase_auth.dart';
import '../reusable/delayed.dart';
import '../reusable/reusable_widgets.dart';

class forget_password extends StatefulWidget {
  const forget_password({Key? key}) : super(key: key);

  @override
  State<forget_password> createState() => _forget_passwordState();
}

class _forget_passwordState extends State<forget_password> {
  TextEditingController _emailTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Forget Password",
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
              delayed(
                delay: 1500,
                child: logoWidget("assets/images/haffeli_bg.png"),
              ),
              Container(
                width: 600,
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    SizedBox(height: 20),
                    delayed(
                      delay: 500,
                      child: reusableTextFeild(
                          "Entre Email ",
                          Icons.person_outline,
                          false,
                          _emailTextController,
                          "email"),
                    ),
                    SizedBox(height: 15),
                    delayed(
                        delay: 1000,
                        child: signInSignUpButton(context, "Reset Pasword",
                            Icons.abc_outlined, Colors.white, () async {
                          if (_formKey.currentState!.validate()) {
                            firebaseAuthService(FirebaseAuth.instance)
                                .forget_Password(
                                    _emailTextController.text, context);
                          }
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_haffeli/screens/forget_password.dart';
import 'package:project_haffeli/screens/sign_up.dart';
import 'package:project_haffeli/services/firebase_auth.dart';
import '../reusable/delayed.dart';
import '../reusable/reusable_widgets.dart';

class Sign_In extends StatefulWidget {
  const Sign_In({Key? key}) : super(key: key);

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    SizedBox(height: 30),
                    delayed(
                      delay: 2000,
                      child: reusableTextFeild(
                          "Entre Email",
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
                    SizedBox(height: 5),
                    delayed(delay: 2700, child: forgetPassword(context)),
                    SizedBox(height: 10),
                    delayed(
                      delay: 2500,
                      child: signInSignUpButton(
                          context, "Log IN", Icons.email, Colors.grey,
                          () async {
                        //print("test");
                        if (_formKey.currentState!.validate()) {
                          firebaseAuthService(_auth).Sign_in_WithEmail(
                              _emailTextController.text,
                              _passwordTextController.text,
                              context);
                        }
                        print(_formKey.toString());
                      }),
                    ),
                    SignUpOption()
                  ]),
                ),
                // ),
              )

              // ),
            ],
          ),
        ),
      ),
    );
  }

  Row SignUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Dont have account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => sign_Up()));
          },
          child: const Text(
            "Sign UP",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 35,
        alignment: Alignment.bottomRight,
        child: TextButton(
          child: const Text(
            "Forget Password",
            style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.right,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => forget_password()),
          ),
        ));
  }
}

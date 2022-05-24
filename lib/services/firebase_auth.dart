import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../models/users.dart';
import '../screens/bienvenue.dart';

class firebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final _googleSignIn = GoogleSignIn();

  UserModel userModel = UserModel();

  firebaseAuthService(FirebaseAuth auth);
//sign in with email and password
  Future<void> Sign_in_WithEmail(
      String email, String password, BuildContext context) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) async {
      if (!_auth.currentUser!.emailVerified) {
        await sendEmailVerfication(context);
      } else {
        Fluttertoast.showToast(msg: "Login successful");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => bienvenue()));
      }
    }).catchError((e) {
      print(e!.message);
    });
  }

//sign up with email and password
  Future<void> Sign_up_WithEmail(String email, String password, String username,
      BuildContext context) async {
    {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        userModel.email = user!.email;
        userModel.uid = user.uid;
        userModel.username = username;

        await firebaseFirestore
            .collection("users")
            .doc(user.uid)
            .set(userModel.toMap());
        if (!_auth.currentUser!.emailVerified) {
          await sendEmailVerfication(context);
        } else {
          Fluttertoast.showToast(msg: "Account created sucessfully");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => bienvenue()),
              (route) => false);
        }
      }).catchError((e) {
        print(e!.message);
      });
    }
  }

  //forget password
  Future<void> forget_Password(String email, BuildContext context) async {
    await _auth
        .sendPasswordResetEmail(
          email: email,
        )
        .then((value) => Navigator.of(context).pop());
  }

  //Verfication email
  Future<void> sendEmailVerfication(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      Fluttertoast.showToast(msg: "Email verfication sent!");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  //sign up with Google
  Future<void> sign_up_WithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        await _auth.signInWithPopup(googleProvider).then((value) async {
          User? user = FirebaseAuth.instance.currentUser;
          userModel.email = user!.email;
          userModel.uid = user.uid;
          userModel.username = user.displayName;
          await firebaseFirestore
              .collection("users")
              .doc(user.uid)
              .set(userModel.toMap());
        });
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final AuthCredential authCredential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          await _auth.signInWithCredential(authCredential).then((value) async {
            User? user = FirebaseAuth.instance.currentUser;
            userModel.email = user!.email;
            userModel.uid = user.uid;
            userModel.username = user.displayName;
            await firebaseFirestore
                .collection("users")
                .doc(user.uid)
                .set(userModel.toMap());
          });
          Fluttertoast.showToast(msg: "Account created sucessfully");
        }
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
      throw e;
    }
  }

//sign up with facebook
  Future<void> sign_up_WithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _auth.signInWithCredential(facebookAuthCredential);
      User? user = FirebaseAuth.instance.currentUser;
      userModel.email = user!.email;
      userModel.uid = user.uid;
      userModel.username = user.displayName;
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
      throw e;
    }
  }
}

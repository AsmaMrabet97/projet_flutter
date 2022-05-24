import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:project_haffeli/screens/bienvenue.dart';
import 'package:project_haffeli/screens/detailsUser.dart';
import 'package:project_haffeli/screens/detailsUser_category.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:project_haffeli/screens/sign_in.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.instance.webInitialize(
      appId: "1147126442529090",
      cookie: true,
      xfbml: true,
      version: "v13.0",
    );
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailCategory(),
    );
  }
}

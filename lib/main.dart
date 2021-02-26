import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_demo_saudi/Provider/FirebaseDemoProvider.dart';
import 'package:flutter_app_demo_saudi/Provider/ImagePickerProvider.dart';
import 'package:flutter_app_demo_saudi/Provider/SignUpProvider.dart';
import 'package:flutter_app_demo_saudi/Screens/AnalysisImageScreen/AnalysisDetailScreen.dart';
import 'package:flutter_app_demo_saudi/Screens/DetailScreen/DetailScreen.dart';
import 'package:flutter_app_demo_saudi/Screens/Firebasedemopack/FirebaseDemo.dart';
import 'package:flutter_app_demo_saudi/Screens/Splash/splashscreen.dart';
import 'package:provider/provider.dart';

import 'Global/Global.dart';
import 'Provider/AnalysisProvider.dart';
import 'Provider/DetailsScreenProvider.dart';
import 'Provider/HomeProvider.dart';
import 'Provider/ProfileProvider.dart';
import 'Provider/SignInProvider.dart';
import 'Provider/SplashProvider.dart';
import 'Screens/Home/HomeScreen.dart';
import 'Screens/ImagePicker/ImagePickerScreen.dart';
import 'Screens/SignInScreen/signin.dart';
import 'Screens/SignUp/signup.dart';
import 'Screens/home1/home1.dart';
import 'Screens/home2/home2.dart';
import 'Screens/profile/ProfilePage.dart';
import 'constantPackage/constStrings.dart';
import 'model/UserModel.dart';
import 'utils/preference.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preference.load();

  //check user is logged in or not
  try{

    String user_json_details= await Preference.getString(user_credentials);
    Global.user_details=await userModelFromJson(user_json_details);
    if(Global.user_details!=null){
      print("take u home${Global.user_details.email}");
    }else{
    }

  }catch(e){}

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (ctx) => SplashProvider()),
    ChangeNotifierProvider(create: (ctx) => HomeProvider()),
    ChangeNotifierProvider(create: (ctx) => FirebaseDemoProvider()),
    ChangeNotifierProvider(create: (ctx) => ProfileProvider()),
    ChangeNotifierProvider(create: (ctx) => ImagePickerProvider()),
    ChangeNotifierProvider(create: (ctx) => DetailScreenProvider()),
    ChangeNotifierProvider(create: (ctx) => AnalysisScreenProvider()),
    ChangeNotifierProvider(create: (ctx) => SignInProvider()),
    ChangeNotifierProvider(create: (ctx) => SignUpProvider())
  ],
      child:MyApp()
  ),

  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute:  SplashScreen.classname,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        Home.classname: (context) => Home(),
        SplashScreen.classname:(context)=>SplashScreen(),
        AnalysisImageScreen.classname:(context)=>AnalysisImageScreen(),
        ProfilePage.classname:(context)=>ProfilePage(),
        SignInPage.classname:(context)=>SignInPage(),
       DetailScreen.screename:(context)=>DetailScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        FirebaseDemo.classname:(context)=>FirebaseDemo(),
        SignUpScreen.classname:(context)=>SignUpScreen(),
        ImagePickerScreen.classname:(context)=>ImagePickerScreen(),
      },
      theme: ThemeData(

        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

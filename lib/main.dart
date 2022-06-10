import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iotapp/screens/create.dart';
import 'package:iotapp/screens/home.dart';
import 'package:iotapp/screens/signup.dart';
import 'firebase_options.dart';


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: FirebaseAuth.instance.currentUser  != null ? "/" :'/signup',
      routes: {
        '/':(context) => const Home(),
        '/signup':(context)=>  SignUp(),
        '/create':(context)=> Create()
      },
    );
  }
}

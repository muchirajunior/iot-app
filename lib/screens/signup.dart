import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:iotapp/screens/home.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var text='login';
  bool loading = false;
  align(){
    setState(() {
      text=text=='login' ? "register" :"login";
    });
  }

  var email=TextEditingController();
  var password=TextEditingController();
  var confirmPassword=TextEditingController();

  signUp()async{
    loading=true;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData){
          return const Home();
        }else{
          return const SignInScreen(
            providerConfigs: [
              EmailProviderConfiguration(),
            ],
          );}
    })
    );
  }
}


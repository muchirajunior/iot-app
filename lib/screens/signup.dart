import 'package:flutter/material.dart';
import 'package:iotapp/screens/components.dart';
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
          return Home();
        }else{
          return const SignInScreen(
            providerConfigs: [
              EmailProviderConfiguration(),
            ],
          );}
    })
    );
   
    // return Scaffold(
    //   backgroundColor: Colors.grey.shade200,
    //   body:Center(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         const Text("Sign Up", style: TextStyle(fontSize:20,)),
    //         const SizedBox(height: 50,),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             customButton("login", align),
    //             customButton("register", align),
    //           ],
    //         ),
    //         Container(
    //           height: 5,
    //           width:MediaQuery.of(context).size.width,
    //           color: Colors.grey,
    //         child: AnimatedAlign(
    //           alignment: text=="login" ? Alignment.centerLeft : Alignment.centerRight,
    //           duration: const Duration(seconds: 1),
    //           child: Container(
    //             height: 5,
    //             margin:const EdgeInsets.fromLTRB(20, 0, 20, 0),
    //             width:MediaQuery.of(context).size.width*.4,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10),
    //               color: Colors.grey.shade700
    //             ),
    //           ),
    //            ),
    //         ),
    //         const SizedBox(height: 30,),
    //         customTextInput(email, "email", false),
    //         customTextInput(password, "password", true),
    //         text=='register' ? customTextInput(confirmPassword, "confirm password", true) : const Text(""),
    //         const SizedBox(height:40),
    //         loading ? const CircularProgressIndicator() : ElevatedButton(onPressed: signUp, child:  Text(text))

    //       ],
    //   ),)
    // );
  }
}



import 'package:firebase_auth/firebase_auth.dart';

Map<String,dynamic> sampleProject(name,pin0,pin1,pin2,pin3,pin4,pin5,pin6,pin7,pin8){
  return {
    "name":name,
    "owner":FirebaseAuth.instance.currentUser!.email.toString(),
    "pin1":"off",
    "pin2":"off",
    "pin3":"off",
    "pin4":"off",
    "pin5":"off",
    "pin6":"off",
    "pin7":"off",
    "pin8":"off",
    "pin0":"off",
    "pin0Name":pin0,
    "pin1Name":pin1,
    "pin2Name":pin2,
    "pin3Name":pin3,
    "pin4Name":pin4,
    "pin5Name":pin5,
    "pin6Name":pin6,
    "pin7Name":pin7,
    "pin8Name":pin8,

  };
}
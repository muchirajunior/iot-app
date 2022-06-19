import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iotapp/screens/components.dart';
import 'package:iotapp/services/utils.dart';

class Create extends StatefulWidget {
  Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  var projectName=TextEditingController();
  var pin0Name=TextEditingController(text: "Item ");
  var pin1Name=TextEditingController(text: "Item 1");
  var pin2Name=TextEditingController(text: "Item 2");
  var pin3Name=TextEditingController(text: "Item 3");
  var pin4Name=TextEditingController(text: "Item 4");
  var pin5Name=TextEditingController(text: "Item 5");
  var pin6Name=TextEditingController(text: "Item 6");
  var pin7Name=TextEditingController(text: "Item 7");
  var pin8Name=TextEditingController(text: "Item 8");

 submit(){
   CollectionReference reference=FirebaseFirestore.instance.collection("projects");
   var data=sampleProject(projectName.text, pin0Name.text, pin1Name.text, pin2Name.text, pin3Name.text, pin4Name.text, pin5Name.text, pin6Name.text, pin7Name.text, pin8Name.text);
   reference.add(data).whenComplete(() => {
     customSnackBar("project created successfully", context),
     Navigator.pop(context)
   });
   
 }

  heading(name)=> Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  <Widget>[
            Text(name)
          ],);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Project"),
      ),

      body: ListView(
        padding:const EdgeInsets.all(10),
        children: [
          customTextInput(projectName, "project name", false),
          heading("CONTROL PINS"),
          customTextInput(pin0Name, "", false),
          customTextInput(pin1Name, "", false),
          customTextInput(pin2Name, "", false),
          customTextInput(pin3Name, "", false),
          customTextInput(pin4Name, "", false),
          customTextInput(pin5Name, "", false),
          heading("SENSOR PINS"),
          customTextInput(pin6Name, "", false),
          customTextInput(pin7Name, "", false),
          customTextInput(pin8Name, "", false),
          
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: submit,
             child: const Text("Create Project"))
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

customTextInput(TextEditingController controller,String text, bool pass, {int maxLines=1}){
  return Container(
    margin:const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
     ),
     child: TextFormField(
       controller: controller,
       maxLines: maxLines,
       obscureText: pass,
       decoration: InputDecoration(
         hintText: text,
         contentPadding: const EdgeInsets.all(10),
         border: InputBorder.none,
       ),
     ),
  );
}

customButton(String text,Function method){
  return MaterialButton(
    onPressed:()=> method(),
    child:  Text(text),
    );
}

customSnackBar(var text,BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text))
    );
}

deleteDialog(BuildContext context, String id,String projectName){
  return  showDialog(context: context, builder: (context){
    return AlertDialog(
      title:const  Text("warning"),
      content: Text("project $projectName will be deleted and this action cannot be reversed !"),
      actions: [
        IconButton(onPressed: (){ 
            Navigator.pop(context);
            FirebaseFirestore.instance.collection('projects').doc(id).delete();
            }, 
            icon: const Icon(Icons.delete), color: Colors.red,),
        IconButton(onPressed: ()=> Navigator.pop(context), icon: const Icon(Icons.cancel), color: Colors.amber,),
      ],
    );
  });
}
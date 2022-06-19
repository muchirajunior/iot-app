import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iotapp/screens/components.dart';

class Project extends StatefulWidget {
  Project({Key? key}) : super(key: key);

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {

 List<String> pins=['pin0','pin1','pin2','pin3','pin4','pin5','pin6','pin7','pin8'];
 update(id,pin,value){
   DocumentReference reference=FirebaseFirestore.instance.collection('projects').doc(id);
   reference.update({
     pin:value=="on" ? 'off' :'on'
   });
 }

  @override
  Widget build(BuildContext context) {
    Map data=ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
        actions: [
          IconButton(onPressed: (){
            FirebaseFirestore.instance.collection('projects').doc(data['id']).get().then((value) => 
              Clipboard.setData(ClipboardData(text: value.data().toString() ))
            );
            customSnackBar("copied to clipboard, share to developer via email", context);

          },
           icon: const Icon(Icons.share))
        ],
      ),

      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('projects').doc(data['id']).snapshots(),
        builder: ((context,snapshot){
          return ListView(
            padding: const EdgeInsets.all(12),
            children: pins.map((pin) => Card(
              child: ListTile(
                title: Text( snapshot.data!.get("${pin}Name"),),
                trailing: pins.indexOf(pin)<6 ? ElevatedButton(
                  onPressed: ()=>update(snapshot.data!.id, pin,snapshot.data!.get(pin) ),
                  child:Text(snapshot.data!.get(pin)) ) : 
                  CircleAvatar(child: Text(snapshot.data!.get(pin)),),
        
              ),
            )).toList()
          );
        }),
      ),

    );
  }
}
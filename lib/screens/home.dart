import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iotapp/screens/components.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController text=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        actions: [
          Center(child: Row(
            children: [
              Text(FirebaseAuth.instance.currentUser!.email.toString().split("@").first),
              IconButton(onPressed: (){
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, "/signup");
              }, icon: const Icon(Icons.person_remove))
            ],
          ))

        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("projects").where("owner",isEqualTo: FirebaseAuth.instance.currentUser!.email.toString()).snapshots(),
        builder: ((context, snapshot){
          if (snapshot.hasData){
            if (snapshot.data!.docs.isNotEmpty){
              return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                return Card(child: ListTile(
                  title: Text(documentSnapshot['name']),
                  trailing: IconButton(
                    onPressed: ()=>deleteDialog(context, documentSnapshot.id, documentSnapshot['name']),
                    icon: const Icon(Icons.delete)),
                  onTap: ()=>Navigator.pushNamed(context, '/project',arguments: {"name":documentSnapshot['name'], "id":documentSnapshot.id}),                    
                ),);
              });
            }else{
            return const Center(child:Text("You have No project \n click on the add button to create one"));
          }}else{
            return const Center(child: CircularProgressIndicator(),);
          }
          
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.pushNamed(context, "/create"),
        child: const Icon(Icons.add),
        ),
    );
    
  }
}
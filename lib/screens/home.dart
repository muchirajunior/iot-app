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
          Center(child: Text(FirebaseAuth.instance.currentUser!.email.toString()))
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("projects").where("owner",isEqualTo: FirebaseAuth.instance.currentUser!.email.toString()).snapshots(),
        builder: ((context, snapshot){
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                return Card(child: ListTile(
                  title: Text(documentSnapshot['name']),
                  trailing: IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.delete)),
                ),);
              });
          }else{
            return const Center(child:Text("You have No project \n click on the add button to create one"));
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
import 'package:assignment_app/ui/formadd.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        
        children: [
        Image.asset('assets/images/mmepl_home.jpg',
        height: 200,
        width: 400,
        fit: BoxFit.contain,),
        SizedBox(height: 10,),
        Text('Welcome onboard User!',style: TextStyle(fontSize: 20),),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> FormPage() ),);
        }, child: Text('Add Item'))
        ]
      ),
    );
  }
}
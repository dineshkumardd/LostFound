import 'package:assignment_app/helper/global_provider.dart';
import 'package:assignment_app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuccessPagState extends StatefulWidget {
  const SuccessPagState({super.key});

  @override
  State<SuccessPagState> createState() => __SuccessPagStateState();
}

class __SuccessPagStateState extends State<SuccessPagState> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalProvider>(context);
    final data = globalData.formData[0];
     return Scaffold(
      appBar: AppBar(title: Text("Submitted Data")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:  16.0),
                  child: Text('Your details has been successfully saved',
                style: TextStyle(
                  fontSize: 25
                ),),
                ),
                Text('Name : ${data['name']}',
                style: TextStyle(
                  fontSize: 20
                ),),
                Text('Contact : ${data['contact']}',
                style: TextStyle(
                  fontSize: 20
                ),),
                Text('Description : ${data['desc']}',
                style: TextStyle(
                  fontSize: 20
                ),),
                Text('Date : ${data['date']}',
                style: TextStyle(
                  fontSize: 20
                ),),
                Text('Location : ${data['location']}',
                style: TextStyle(
                  fontSize: 20
                ),),
                
                 for (var item in globalData.items)
              Text('Images Added : $item}',
                style: TextStyle(
                  fontSize: 20
                ),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(child: ElevatedButton(onPressed: (){
                      globalData.items.clear();
                      Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),ModalRoute.withName('/')
                          );
                    }, child: Text('Back to Home'))),
                  ],
                )
              ],
          ),
        ),
      )
    );
  }
}
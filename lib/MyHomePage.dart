import 'package:flutter/material.dart';

import 'main.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Center(
      child: IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>cameraScreen()));
      },icon: Icon(Icons.camera_alt,size: 50,),),
    ) ,);
  }
}

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:capp/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

import 'click.dart';
import 'gallery.dart';
var _cameras;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class cameraScreen extends StatefulWidget {
  const cameraScreen({super.key});

  @override
  State<cameraScreen> createState() => _cameraScreenState();
}

class _cameraScreenState extends State<cameraScreen> {
  late CameraController controller;
  bool showrear=true;
  var camera_index=0;
  var currnetcamerastatus = 1;
  bool showflash=false;
  bool isshow=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
    setState(() {
      currnetcamerastatus = 1;
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(home:Stack(children: [
      CameraPreview(controller),
      Positioned(top:50,right:10,left:10,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [IconButton(onPressed: (){}, icon: Icon(Icons.close,color: Colors.white,)),
          Text('00:00',style: TextStyle(fontSize: 25,color: Colors.white,decoration: TextDecoration.none,fontWeight: FontWeight.normal),),
        IconButton(onPressed: (){
      if(showflash==true){
        setState(() {
          showflash = !showflash;
          controller.setFlashMode(FlashMode.off);
        });
      }else {
        setState(() {
          showflash = !showflash;
          controller.setFlashMode(FlashMode.torch);
        });
      }
        }, icon: showflash?Icon(Icons.flash_on,color: Colors.white,):Icon(Icons.flash_off,color: Colors.white,)),
      ],)),
      Positioned(bottom:210,child:Container(
        height: 100,
        width: 1000,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(height: 10, width: 90, color: Colors.white),
            );
          },
        ),
      ), ),
      Positioned( bottom: 100,
        left: 10,right: 10,
          child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: ()async{
                final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,);

                          if (pickedFile == null) {
                          } else {
                            File imageFile = File(pickedFile.path);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => gallery(pickedFile: imageFile,),),);
                          }
              }, icon: Icon(Icons.image,color: Colors.white,)),
              IconButton(onPressed: ()async{
                final path = await join((await getTemporaryDirectory()).path,
                '${DateTime.now()}.png');
                final XFile picture = await controller.takePicture();

                picture.saveTo(path);
                Navigator.push(context, MaterialPageRoute(builder: (context) => click(path:path)));
              }, icon: Visibility(visible: isshow,
                  replacement: Icon(Icons.radio_button_on_rounded,color: Colors.white,size: 100,),
                  child: Icon(Icons.adjust_rounded,color: Colors.white,size: 100,))),
              IconButton(onPressed: (){
                if(showrear==true){
                  setState(() {
                    camera_index=0;
                    showrear=!showrear;
                  });
                }else{
                  setState(() {
                    camera_index=1;
                    showrear=!showrear;

                  });

                }
                controller = CameraController(_cameras[camera_index], ResolutionPreset.max);
                controller.initialize().then((_) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                  });
                }).catchError((Object e) {
                  if (e is CameraException) {
                    switch (e.code) {
                      case 'CameraAccessDenied':
                        break;
                      default:
                        break;
                    }
                  }
                });

              }, icon: Icon(Icons.flip_camera_android,color: Colors.white,))
            ],
          )
      ),
      Positioned(
          bottom: 315,
          left: 160,
          child: Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent),
              onPressed: () {},
              child: Icon(
                Icons.minimize,
                color: Colors.white,
              ),
            ),
          )),
      Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            height: 80,
            width: 400,
            color: Colors.grey.shade900,
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 110,
                      height: 0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: currnetcamerastatus == 2
                              ? Colors.grey.shade800
                              : Colors.transparent,
                          shape: StadiumBorder()),
                      onPressed: () {
                        setState(() {
                          currnetcamerastatus = 2;
                          isshow=true;
                        });
                      },
                      child: Text(
                        'video',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            decoration: TextDecoration.none),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: currnetcamerastatus == 1
                              ? Colors.grey.shade800
                              : Colors.transparent,
                          shape: StadiumBorder()),
                      onPressed: () {
                        setState(() {
                          currnetcamerastatus = 1;
                          isshow=false;
                        });
                      },
                      child: Text(
                        'photo',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ))
    ],) ,);
  }
}

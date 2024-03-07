import 'dart:io';

import 'package:flutter/material.dart';
class gallery extends StatefulWidget {
  final File pickedFile;
  const gallery({required this.pickedFile,super.key});

  @override
  State<gallery> createState() => _galleryState();
}

class _galleryState extends State<gallery> {
  TextEditingController area = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Stack(
          children: [Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.90,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Image.file((widget.pickedFile!), fit: BoxFit.cover),
            ),Positioned(
                top: 30,
                left: 10,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ))),
            Positioned(
                top: 30,
                left: 200,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.crop_rotate,
                      color: Colors.white,
                    ))),
            Positioned(
              top: 30,
              left: 250,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.white,
                  )),
            ),
            Positioned(
              top: 30,
              right: 50,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.title,
                    color: Colors.white,
                  )),
            ),
            Positioned(
                top: 30,
                right: 10,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                )),
            Positioned(
                bottom: 140,
                left: 180,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_arrow_up_outlined,
                    color: Colors.white,
                  ),
                )),
            Positioned(
                bottom: 130,
                left: 187,
                child: Text(
                  'Filter',
                  style: TextStyle(color: Colors.white),
                )),
            Positioned(
              bottom: 75,
              left: 5,
              child: Container(
                height: 40,
                width: 380,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.grey.shade800),
                child: TextFormField(
                  controller: area,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      hintText: 'Add a caption...',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.av_timer,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              child: Row(
                children: [
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 8,
                    width: 10,
                  ),
                  Container(
                    height: 30,
                    width: 60,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey.shade800,
                    ),
                    child: Text(
                      'Tushar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 20,
                    width: 265,
                  ),
                  CircleAvatar(
                    child: IconButton(
                        onPressed: () {
                          // sendFilemessage(
                          //   context,
                          //   pickedFile,
                          //   ref,
                          // );

                          // ref.read(statusControllerProvider).uploadStatus(
                          //     statusImage: File(''),
                          //     context: context,
                          //     type: 'image',
                          //     text: area.text,
                          //     x: 1000,
                          // );

                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        )),
                    backgroundColor: Colors.green,
                    radius: 25,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}

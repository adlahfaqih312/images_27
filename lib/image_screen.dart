import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              selectedImage != null
                  ?  Image.file(selectedImage!,width: 300, height: 300,)
                  : Text("No Image Selected"),
              SizedBox(height:100),
              TextButton(onPressed: ()async{
                showDialog(context: context, builder: (context){
                  return AlertDialog(title: Text("Select Source"),
                  actions: [
                    IconButton(onPressed: ()async{
                     await selectImage(source: ImageSource.camera);
                     Navigator.pop(context);
                    }, icon: Icon(Icons.camera),),
                    IconButton(onPressed: ()async{
                     await selectImage(source: ImageSource.gallery);
                     Navigator.pop(context);
                    }, icon: Icon(Icons.browse_gallery),),
                  ],
                  );
                }
                );
              },
                  child: Text("Select Image",style: TextStyle(fontSize: 25),),style: TextButton.styleFrom(backgroundColor: Colors.red,foregroundColor: Colors.black,),
              ),
            ],
          ),
        ),
      ),
    );
  }
  selectImage({required ImageSource source})async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if(image != null){
      selectedImage=File(image.path);
    }
    else{
      selectedImage=null;
    }
    setState(() {});
  }
}

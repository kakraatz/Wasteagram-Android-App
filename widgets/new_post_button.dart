import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../screens/new_post_screen.dart';

class NewPostButton extends StatelessWidget {
  XFile? pickedImage;
  @override
  Widget build(BuildContext context) {
    return Semantics(
        button: true,
        enabled: true,
        onLongPressHint: 'Add a new post to your Wasteagram list.',
        child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              pickedImage = await getImage();
              //String imageURL = await postImage(pickedImage);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NewPostScreen(pickedImage: pickedImage)));
              //FirebaseFirestore.instance
              //.collection('bandnames')
              //.add({'name': 'Rusty Laptop', 'votes': 22});
            }));
  }

  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    return pickedImage;
  }
}

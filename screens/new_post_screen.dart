import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wasteagram/widgets/posts_list.dart';
import '../widgets/back_button.dart' as back_button;
import '../widgets/get_location.dart';

class NewPostScreen extends StatefulWidget {
  final XFile? pickedImage;
  const NewPostScreen({Key? key, required this.pickedImage}) : super(key: key);
  @override
  NewPostScreenState createState() => NewPostScreenState();
}

class NewPostScreenState extends State<NewPostScreen> {
  final formKey = GlobalKey<FormState>();
  final numController = TextEditingController();
  LocationData? locationData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const back_button.BackButton(),
          title: const Text('New Post'),
        ),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Semantics(
                label: 'Displays the image of this post.',
                enabled: true,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                    child: SizedBox(
                        height: 250,
                        width: 250,
                        child: displayImage(widget.pickedImage)))),
            Semantics(
                label: 'Input number of food waste items in the image.',
                enabled: true,
                child: SizedBox(
                    height: 65,
                    width: 200,
                    child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: numController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              labelText: 'Food Waste Items',
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid number.';
                            } else {
                              return null;
                            }
                          },
                        ))))
          ],
        )),
        bottomNavigationBar: BottomAppBar(
            color: Colors.green,
            child: Container(
                height: 100,
                child: Center(
                    child: Semantics(
                  label: 'Button for uploading image and saving the post',
                  enabled: true,
                  child: IconButton(
                    icon:
                        const Icon(Icons.upload, size: 50, color: Colors.white),
                    onPressed: () async {
                      final form = formKey.currentState;
                      if (form != null && form.validate()) {
                        //print("here");
                        showDialog(
                            context: context,
                            builder: (context) {
                              return uploadingAlert();
                            });
                        locationData = await retrieveLocation();
                        FirebaseFirestore.instance
                            .collection('posts')
                            .doc(DateTime.now().toString())
                            .set({
                          'date': Timestamp.fromDate(DateTime.now()),
                          'imageURL': await postImage(widget.pickedImage),
                          'quantity': num.parse(numController.text),
                          'latitude': locationData!.latitude,
                          'longitude': locationData!.longitude
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostsList()));
                      }
                    },
                  ),
                )))));
  }

  Image? displayImage(pickedImage) {
    if (pickedImage == null) {
      Navigator.pop(context);
      return null;
    } else {
      return Image.file(File(widget.pickedImage!.path), fit: BoxFit.contain);
    }
  }

  Future postImage(XFile? pickedImage) async {
    var fileName = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile((File(pickedImage!.path)));
    await uploadTask;
    var url = await storageReference.getDownloadURL();
    return url;
  }

  AlertDialog uploadingAlert() {
    return const AlertDialog(
      title: Text('Posting...'),
      icon: CircularProgressIndicator(),
      alignment: Alignment.center,
    );
  }
}

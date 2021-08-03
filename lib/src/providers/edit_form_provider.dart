import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

class EditFormProvider extends ChangeNotifier{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isClicked = false;

  String name = "";
  String description = "";
  String date = DateTime.now().toLocal().toString().split(' ')[0];

  bool isValidated(){
    print(formKey.currentState?.validate()); 
    return formKey.currentState?.validate() ?? false;
  }

  bool activate(){
    print(isClicked);
    return isClicked = !isClicked;
  }

  Future<void> updateSecret(String cod, String name, String description, String date) async {
    await FirebaseFirestore.instance.collection('secrets').where("name", isEqualTo: cod).get().then((snapshot){
      for(DocumentSnapshot ds in snapshot.docs){
        FirebaseFirestore.instance.collection('secrets').doc(ds.id).update({
          "name": name,
          "description": description,
          "date": date
        });
      }
    });
  }

  Future<void> updateImage(String cod, File image, String imageUrl) async {
    final imageName = image.path.split('/').last;
    final imageExtension = path.extension(imageName);

    final storageReference = FirebaseStorage.instance.ref().child('uploads/$cod$imageExtension');    
    await storageReference.putFile(image);    
    await storageReference.getDownloadURL().then((fileURL) {    
      imageUrl = fileURL;    
    });

    await FirebaseFirestore.instance.collection('secrets').where("name", isEqualTo: cod).get().then((snapshot){
      for(DocumentSnapshot ds in snapshot.docs){
        FirebaseFirestore.instance.collection('secrets').doc(ds.id).update({
          "imageUrl": imageUrl
        });
      }
    });
  }

  Future<void> updateAudio(String cod, File audio, String audioUrl) async {
    final audioName = audio.path.split('/').last;
    final audioExtension = path.extension(audioName);

    final audioReference = FirebaseStorage.instance.ref().child('audios/$cod$audioExtension');
    await audioReference.putFile(audio, SettableMetadata(
        contentType: "audio/X-HX-AAC-ADTS",
        customMetadata: <String, String>{"file": "audio"}
      )
    );
    await audioReference.getDownloadURL().then((fileURL){
      audioUrl = fileURL;
    });

    await FirebaseFirestore.instance.collection('secrets').where("name", isEqualTo: cod).get().then((snapshot){
      for(DocumentSnapshot ds in snapshot.docs){
        FirebaseFirestore.instance.collection('secrets').doc(ds.id).update(({
          "audioUrl": audioUrl
        }));
      }
    });
  }
}
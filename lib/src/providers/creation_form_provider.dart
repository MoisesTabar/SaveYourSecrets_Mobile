import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class CreationFormProvider extends ChangeNotifier{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = "";
  String description = "";
  String date = DateTime.now().toLocal().toString().split(' ')[0];

  bool isValidated(){
    print(formKey.currentState?.validate()); 
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> addSecrets(String name, String description, String date, File image, String fileUrl, [File? audio, String? audioUrl]) async {
    final imageName = image.path.split('/').last;
    final imageExtension = path.extension(imageName);

    final imageReference = FirebaseStorage.instance.ref().child('uploads/$name$imageExtension');    
    await imageReference.putFile(image);    
    await imageReference.getDownloadURL().then((fileURL) {    
      fileUrl = fileURL;    
    });  

    // ignore: unnecessary_null_comparison
    if(audio != null){
      final audioName = audio.path.split('/').last;
      final audioExtension = path.extension(audioName);
      final audioReference = FirebaseStorage.instance.ref().child('audios/$name$audioExtension');
      await audioReference.putFile(audio, SettableMetadata(
          contentType: "audio/X-HX-AAC-ADTS",
          customMetadata: <String, String>{"file": "audio"}
        )
      );
      await audioReference.getDownloadURL().then((audioURL){
        audioUrl = audioURL;
      });
    }

    await FirebaseFirestore.instance.collection('secrets').doc().set({
      'name': name,
      'description': description,
      'date': date,
      'imageUrl': fileUrl,
      'audioUrl': audioUrl != null ? audioUrl : null 
    });
  }

  Future<void> deleteAllSecrets() async {
    await FirebaseFirestore.instance.collection('secrets').get().then((snapshot){
      for(DocumentSnapshot ds in snapshot.docs){
          ds.reference.delete();
        }
      }
    );
  }
}
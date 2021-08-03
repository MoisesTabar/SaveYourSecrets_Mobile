import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:save_your_secrets/src/providers/creation_form_provider.dart';
import 'package:save_your_secrets/src/utils/formfield_util.dart';
import 'package:save_your_secrets/src/widgets/date_dialog.dart';
import 'package:save_your_secrets/src/widgets/dialogs.dart';
import 'package:save_your_secrets/src/widgets/widgets.dart';

class SecretCreationPage extends StatefulWidget {
  @override
  _SecretCreationPageState createState() => _SecretCreationPageState();
}

class _SecretCreationPageState extends State<SecretCreationPage> {
  late File _imageFile;
  late String _imageUrl = "";
  late File _audioFile;
  late String _audioUrl = "";

  late bool isRecorderInitialized;
  late FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();

  Future<void> _openCamera(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(image!.path);
    });
  }

  Future<void> _recorder(String fileName) async {
    if(!isRecorderInitialized) return;
    await _audioRecorder.startRecorder(toFile: '${fileName.trim()}.aac');
  }

  Future<void> _stop() async {
    if(!isRecorderInitialized) return;
    final stopAudio = await _audioRecorder.stopRecorder();
    setState(() {
      _audioFile = File(stopAudio!);
    });
  }

  @override
  void initState() {
    super.initState();
    isRecorderInitialized = true;
  }

  @override
  void dispose() { 
    isRecorderInitialized = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   final creationProvider = Provider.of<CreationFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.black)
        ),
        elevation: 0,
        backgroundColor: Colors.grey[200] 
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¡Registra tu secreto!',
              style: TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.bold, 
                fontSize: 20
              ),
            ),
            Form(
              key: creationProvider.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    onChanged: (value) => creationProvider.name = value,
                    decoration: FormFieldDecorations.loginInputDecoration('Mi Secreto', 'Nombre del secreto', Icons.lock),
                    validator: (value){
                      return value != null && value.length >= 1
                      ? null
                      : 'Este campo no puede ser nulo';
                    }
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) => creationProvider.description = value,
                    decoration: FormFieldDecorations.loginInputDecoration('Mi ultra secreto', 'Descripción', Icons.info),
                    validator: (value){
                      return value != null && value.length >= 1
                      ? null
                      : 'Este campo no puede ser nulo';
                    },
                  ),
                  SizedBox(height: 20),
                  DateDialog(
                    date: creationProvider.date,
                    buttonColor: Colors.indigo.shade600,
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey,
                    elevation: 0,
                    color: Colors.indigo.shade600,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      child: Text('Registrar secreto', style: TextStyle(color: Colors.white))
                    ),
                    onPressed: () async {
                      // ignore: unnecessary_null_comparison
                      if(!creationProvider.isValidated() || _imageFile == null) {
                        await showDialog(
                          context: context, 
                          builder: (_) => Dialogs(
                            dialogTitle: 'Falta algo!',
                            dialogContent: 'Falta algun campo del secreto',
                            dialogHeaderColor: Colors.amber.shade600,
                            dialogIcon: Icons.warning,
                            buttonContent: 'Volver',
                            onButtonPressed: () => Navigator.of(context).pop(),
                          )
                        );
                      }
                      else{ 
                        await creationProvider.addSecrets(
                          creationProvider.name, 
                          creationProvider.description, 
                          creationProvider.date,
                          _imageFile,
                          _imageUrl,
                          _audioFile,
                          _audioUrl
                        );

                        await showDialog(
                          context: context, 
                          builder: (_) => Dialogs(
                            dialogTitle: 'Secreto creado',
                            dialogContent: 'Secreto creado exitosamente!!',
                            dialogHeaderColor: Colors.indigo.shade600,
                            dialogIcon: Icons.lock,
                            buttonContent: 'Volver',
                            onButtonPressed: () => Navigator.of(context).pop(),
                          )
                        );
                      }
                    },
                  )
                ],
              )
            )
          ]
        ),
      ), 
      floatingActionButton: CustomFloatingActionButton(
        audioOnPressed: () async => showDialog(context: context, builder: (_) => RecordModal(
          recorder: () => _recorder(creationProvider.name),
          stop: () => _stop(),
          isRecorderInitialized: isRecorderInitialized,
          audioRecorder: _audioRecorder,
        )),
        cameraOnPressed: () async {
          await _openCamera(context);
        },
      ),
    );
  }
}
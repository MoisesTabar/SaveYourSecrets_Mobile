import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:provider/provider.dart';
import 'package:save_your_secrets/src/providers/edit_form_provider.dart';
import 'package:save_your_secrets/src/widgets/date_dialog.dart';
import 'package:save_your_secrets/src/widgets/widgets.dart';

class EditSecretForm extends StatefulWidget {
  late final String cod;

  EditSecretForm({required this.cod});

  @override
  _EditSecretFormState createState() => _EditSecretFormState();
}

class _EditSecretFormState extends State<EditSecretForm> {
  late File _audioFile;
  late String _audioUrl = "";

  late bool isRecorderInitialized;
  late FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();

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

    final editFormProvider = Provider.of<EditFormProvider>(context);

    return ClipShadowPath(
      clipper: CircularClipper(),
      shadow: Shadow(color: Colors.black, blurRadius: 0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: editFormProvider.isClicked ? Colors.indigo.shade600 : Colors.black 
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        height: editFormProvider.isClicked ? 400 : 0,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: editFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 21),
                child: Text(
                  '¡Edita tu secreto!',
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 20
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                inputDecorationTexts: ['Tu secreto', 'Edita el nombre de tu secreto'], 
                inputDecorationIcon: Icons.lock, 
                inputType: TextInputType.text, 
                inputOnChanged: (value) => editFormProvider.name = value
              ),
              CustomTextFormField(
                inputDecorationTexts: ['La descripción', 'Edita la descripción de tu secreto'], 
                inputDecorationIcon: Icons.info, 
                inputType: TextInputType.text, 
                inputOnChanged: (value) => editFormProvider.description = value
              ),
              Padding(
                padding: EdgeInsets.only(left: 32),
                child: DateDialog(
                  date: editFormProvider.date,
                  buttonColor: Colors.indigo.shade600,
                ),
              ),
              SizedBox(height: 14),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.white,
                child: Container(
                  child: Text('Actualizar secreto', style: TextStyle(color: Colors.black))
                ),
                onPressed: () async {
                  if(!editFormProvider.isValidated()) return;
                  await editFormProvider.updateSecret(
                    widget.cod,
                    editFormProvider.name, 
                    editFormProvider.description, 
                    editFormProvider.date 
                  );

                  await showDialog(
                    context: context, 
                    builder: (_) => Dialogs(
                      dialogTitle: 'Secreto actualizado',
                      dialogContent: 'Secreto actualizado exitosamente!!',
                      dialogHeaderColor: Colors.indigo.shade600,
                      dialogIcon: Icons.lock,
                      buttonContent: 'Volver',
                      onButtonPressed: () => Navigator.of(context).pop(),
                    )
                  );
                },
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.white,
                child: Container(
                  child: Text('Actualizar audio', style: TextStyle(color: Colors.black)),
                ),
                onPressed: () async {
                  await showDialog(
                    context: context, 
                    builder: (_) => RecordModal(
                      recorder: () => _recorder(editFormProvider.name), 
                      stop: () => _stop(), 
                      isRecorderInitialized: isRecorderInitialized, 
                      audioRecorder: _audioRecorder
                    )
                  );
                  await editFormProvider.updateAudio(widget.cod, _audioFile, _audioUrl);

                  await showDialog(
                    context: context, 
                    builder: (_) => Dialogs(
                      dialogTitle: 'Audio actualizado',
                      dialogContent: 'Audio actualizado exitosamente!!',
                      dialogHeaderColor: Colors.indigo.shade600,
                      dialogIcon: Icons.mic,
                      buttonContent: 'Volver',
                      onButtonPressed: () => Navigator.of(context).pop(),
                    )
                  );
                }

              )
            ],
          ),
        ), 
      ),
    );
  }
}
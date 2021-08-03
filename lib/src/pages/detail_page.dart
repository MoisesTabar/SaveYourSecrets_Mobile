import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:save_your_secrets/src/providers/edit_form_provider.dart';
import 'package:save_your_secrets/src/widgets/audio_display.dart';
import 'package:save_your_secrets/src/widgets/widgets.dart';

class DetailPage extends StatefulWidget {
  
  late final String tituloDetalle;
  late final String fechaDetalle;
  late final String descripcionDetalle;
  late final String imageDetalle;
  late final String audioDetalle;
  late final String cod;

  DetailPage({
    required this.tituloDetalle,
    required this.fechaDetalle,
    required this.descripcionDetalle,
    required this.imageDetalle,
    required this.audioDetalle,
    required this.cod
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late File _imageFile;
  late String _imageUrl = "";

  Future<void> _openCamera(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final editFormProvider = Provider.of<EditFormProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipShadowPath(
                    shadow: Shadow(blurRadius: 7, color: Colors.black38),
                    clipper: CircularClipper(), 
                    child: FadeInImage(
                      height: 400.0,
                      width: double.infinity,
                      fit: BoxFit.cover, 
                      image: NetworkImage(widget.imageDetalle), 
                      placeholder: NetworkImage('https://i.stack.imgur.com/y9DpT.jpg'),
                    )
                  ),
                  EditSecretForm(
                    cod: widget.cod,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.only(left: 15.0, top: 15.0),
                        onPressed: (){
                          Navigator.pop(context);
                          editFormProvider.isClicked = false;
                        },
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30.0,
                        color: Colors.white,
                      ),
                      IconButton(
                        padding: EdgeInsets.only(right: 15.0, top: 15.0),
                        onPressed: () async {
                          await _openCamera(context);

                          await editFormProvider.updateImage(widget.cod, _imageFile, _imageUrl);

                          await showDialog(
                            context: context, 
                            builder: (_) => Dialogs(
                              dialogTitle: 'Exito!!', 
                              dialogContent: 'Se ha actualizado la foto correctamente!!', 
                              dialogIcon: Icons.camera_alt,
                              dialogHeaderColor: Colors.indigo.shade600,
                              buttonContent: 'Volver',
                              onButtonPressed: () => Navigator.of(context).pop(),
                            ) 
                          );

                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.camera_alt),
                        iconSize: 30.0,
                        color: Colors.white,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                widget.tituloDetalle,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Fecha del secreto: ${widget.fechaDetalle}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey
                ),
              ),
              Padding(
                padding: EdgeInsets.all(11),
                child: Text(
                  'Descripción del secreto: ${widget.descripcionDetalle}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              AudioDisplay(audioSource: widget.audioDetalle),
              MaterialButton(
                onPressed: () => setState(() => editFormProvider.activate()),
                color: Colors.indigo.shade600,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                child: Text('Editar secreto', style: TextStyle(color: Colors.white)),
              ),
             ],
          ),
        ), 
      ),
    );
  }
}
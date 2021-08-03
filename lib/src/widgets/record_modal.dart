import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordModal extends StatefulWidget {

  late final Future<void> Function() recorder, stop;
  late final bool? isRecorderInitialized;
  late final FlutterSoundRecorder audioRecorder;

  RecordModal({
    required this.recorder,
    required this.stop,
    required this.isRecorderInitialized,
    required this.audioRecorder
  });

  @override
  _RecordModalState createState() => _RecordModalState();
}

class _RecordModalState extends State<RecordModal> {

  late bool? isRecording = false;

  Future<void> _toggle() async {
    if(widget.audioRecorder.isStopped){
      await widget.recorder();
    }
    else{
      widget.stop();
    }
  }

  Future<void> _init() async {
    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted){
      throw RecordingPermissionException("El permiso para grabar ha sido denegado");
    }

    await widget.audioRecorder.openAudioSession();
  }

  Future<void> _dispose() async {
    widget.audioRecorder.closeAudioSession();
  }

  @override
  void initState() { 
    super.initState();
    _init();
  }

  @override
  void dispose() { 
    _dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white, 
      elevation: 0,
      insetAnimationCurve: Curves.easeOutCubic,
      insetAnimationDuration: Duration(milliseconds: 500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            color: Colors.white,
          ),
          AnimatedContainer(
            color: isRecording! ? Colors.indigo.shade600 : Colors.red.shade600,
            width: double.infinity,
            height: 200,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInSine,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  child: Icon(isRecording! ? Icons.stop : Icons.mic, color: Colors.black, size: 65)
                ),
              ],
            ),

          ),
          Positioned(
            top: 235,
            left: MediaQuery.of(context).size.width * 0.30,
            child: MaterialButton(
              color: Colors.white,
              onPressed: () async {
                await _toggle();
                setState(() {
                  isRecording = !isRecording!;
                });
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
              child: Column(
                children: [
                  Text(
                    isRecording! ? 'Detener' : 'Grabar'
                  ),
                ],
              ),
            )
          ),
          Positioned(
            top: 280,
            left: MediaQuery.of(context).size.width * 0.30,
            child: MaterialButton(
              color: isRecording! ? Colors.indigo.shade600 : Colors.red.shade600,
              onPressed: () => Navigator.pop(context),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
              child: Text('Volver', style: TextStyle(color: Colors.white)),
            ) 
          )
        ],
      ),
    );
  }
}
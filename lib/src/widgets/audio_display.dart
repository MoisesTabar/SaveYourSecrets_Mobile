import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioDisplay extends StatefulWidget {
  late final String audioSource;

  AudioDisplay({required this.audioSource});

  @override
  _AudioDisplayState createState() => _AudioDisplayState();
}

class _AudioDisplayState extends State<AudioDisplay> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late bool isClicked = false;

  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();


  @override
  void initState() { 
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _assetsAudioPlayer.open(Audio.network(widget.audioSource), autoStart: false, showNotification: true);
  }


  @override
  void dispose() { 
    _controller.dispose();
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Icon(CupertinoIcons.backward_fill),
          onTap: () => _assetsAudioPlayer.seekBy(Duration(seconds: -10)),
        ),
        GestureDetector(
          onTap: (){
            setState(() => isClicked = !isClicked);
            if(isClicked){
              _controller.forward();
              _assetsAudioPlayer.play();
            }
            else{
              _controller.reverse();
              _assetsAudioPlayer.pause();
            }
          },
          child: AnimatedIcon(
            icon: AnimatedIcons.pause_play,
            progress: _controller,
            size: 50,
            color: Colors.black,
          ),
        ),
        InkWell(
          child: Icon(CupertinoIcons.forward_fill),
          onTap: (){
            _assetsAudioPlayer.seekBy(Duration(seconds: 10));
            _assetsAudioPlayer.seek(Duration(seconds: 10));
            _assetsAudioPlayer.next();
          },
        )
      ], 
    );
  }
}
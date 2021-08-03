import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatefulWidget {

  late final Function() cameraOnPressed;
  late final Function() audioOnPressed;

  CustomFloatingActionButton({
    required this.cameraOnPressed,
    required this.audioOnPressed
  });

  @override
  _CustomFloatingActionButtonState createState() => _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton> with SingleTickerProviderStateMixin{
  late bool _isClicked = false;
  late AnimationController _animationController;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  late Curve _curve;
  late double _fabHeight = 56.0;

  @override
  initState() {
    _curve = Curves.decelerate;

    _animationController = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 500)
    )..addListener(() => setState(() => {}));

    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    if(!_isClicked)
      _animationController.forward();
    else
      _animationController.reverse();

    _isClicked = !_isClicked;
  }

  Widget _cameraOnPressed(){
    return FloatingActionButton(
      backgroundColor: Colors.indigo.shade800,
      elevation: 0,
      onPressed: widget.cameraOnPressed,
      heroTag: 'camera',
      child: Icon(Icons.camera),
    );
  }

  Widget _audioOnPressed() {
    return FloatingActionButton(
      backgroundColor: Colors.indigo.shade800,
      elevation: 0,
      onPressed: widget.audioOnPressed,
      heroTag: 'audio',
      child: Icon(Icons.mic),
    );
  }

  Widget _displayButtons() {
    return FloatingActionButton(
      backgroundColor: Colors.indigo.shade600,
      elevation: 0,
      onPressed: animate,
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: _cameraOnPressed(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: _audioOnPressed(),
        ),
        _displayButtons()
      ],
    );
  }
}
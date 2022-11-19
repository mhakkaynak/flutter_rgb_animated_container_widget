import 'dart:async';

import 'package:flutter/material.dart';

class RGBContainer extends StatefulWidget {
  const RGBContainer({super.key, this.colorChangingSpeed = 1});

  final int colorChangingSpeed;

  @override
  State<RGBContainer> createState() => _RGBContainerState();
}

class _RGBContainerState extends State<RGBContainer> {
  Color _color = Colors.blue;
  final _duration = const Duration(milliseconds: 100);
  final _rgb = [255, 0, 0];
  late Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.colorChangingSpeed < 1 || widget.colorChangingSpeed > 5) {
      throw 'Color changing speed cannot be higger than 5 or smaller than 1.';
    }
    _timer = Timer.periodic(_duration, (timer) {
      _changeColor();
    });
    super.initState();
  }

  void _changeColor() {
    setState(() {
      _color = Color.fromRGBO(_rgb[0], _rgb[1], _rgb[2], 1);
      if (_rgb[0] == 255 && _rgb[1] == 0 && _rgb[2] < 255) {
        _rgb[2] += widget.colorChangingSpeed;
      } else if ((_rgb[0] <= 255 && _rgb[0] > 0) &&
          _rgb[1] == 0 &&
          _rgb[2] == 255) {
        _rgb[0] -= widget.colorChangingSpeed;
      } else if (_rgb[0] <= 0 && _rgb[1] < 255 && _rgb[2] == 255) {
        _rgb[1] += widget.colorChangingSpeed;
      } else if (_rgb[0] == 0 &&
          _rgb[1] == 255 &&
          (_rgb[2] <= 255 && _rgb[2] > 0)) {
        _rgb[2] -= widget.colorChangingSpeed;
      } else if (_rgb[0] < 255 && _rgb[1] == 255 && _rgb[2] == 0) {
        _rgb[0] += widget.colorChangingSpeed;
      } else if (_rgb[0] == 255 && _rgb[1] <= 255 && _rgb[2] == 0) {
        _rgb[1] -= widget.colorChangingSpeed;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: _duration,
      decoration: BoxDecoration(color: _color),
    );
  }
}

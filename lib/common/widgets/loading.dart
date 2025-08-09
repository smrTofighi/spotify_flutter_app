import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, required this.color, required this.size});
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.waveDots(color: color, size: size),
    );
  }
}
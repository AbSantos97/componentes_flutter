import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingSimplePage extends StatefulWidget {



  const LoadingSimplePage({super.key});

  @override
  State<LoadingSimplePage> createState() => _LoadingSimplePageState();
}

class _LoadingSimplePageState extends State<LoadingSimplePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Blur(
          blur: 2.5,
          blurColor: Colors.white,
          child: Container(
            color: Colors.transparent,
            width: size.width,
            height: size.height
          ),
        ),
        Center(child: loadingWidget())
      ],
    );
  }

  Widget loadingWidget() {
    return LoadingAnimationWidget.twistingDots(
      leftDotColor: Colors.amberAccent.shade400, 
      rightDotColor: Colors.black, size: 75.0);
  }

  
}
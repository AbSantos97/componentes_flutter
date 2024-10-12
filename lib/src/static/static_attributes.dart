import 'package:flutter/material.dart';

class StaticAttributesUtils{

  static TextStyle estiloTitulos(){
    return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 18
    );
  }

  static TextStyle estilosSimpleTexto(){
    return const TextStyle(
      color: Colors.black,
      fontStyle: FontStyle.normal,
      fontSize: 15
    );
  }
}
import 'package:flutter/material.dart';

class StaticAttributesUtils{

  static TextStyle estiloTitulos(){
    return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 21
    );
  }

  static TextStyle estiloEspectacular(){
    return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 45
    );
  }

  static TextStyle estiloTitulosDatePicker(){
    return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 28
    );
  }

  static TextStyle estilosSimpleTexto(){
    return const TextStyle(
      color: Colors.black,
      fontStyle: FontStyle.normal,
      fontSize: 18
    );
  }

   static TextStyle estilosSimpleTexto22(){
    return const TextStyle(
      color: Colors.black,
      fontStyle: FontStyle.normal,
      height: 1.3,
      fontSize: 22
    );
  }

    static TextStyle estilosSimpleTextoColorAlternativo(){
    return const TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontSize: 15
    );
  }

  static TextStyle estilosSimpleTextoNegritas(double size){
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      fontSize: size
    );
  }

  static TextStyle estilosSimpleTextoNegritasSubrayado(){
    return const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.underline,
      fontSize: 15
    );
  }

  static ButtonStyle estiloOutlineButton(double padding, Color color){
    return ElevatedButton.styleFrom(
      shadowColor: Colors.white,
      backgroundColor: color,
      minimumSize: const Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: padding),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10)
        ),
      ),
    ); 
  }
}
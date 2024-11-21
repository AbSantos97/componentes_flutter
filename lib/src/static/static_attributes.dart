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

  static TextStyle estilosSimpleTextoNegritas(){
    return const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      fontSize: 15
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
}
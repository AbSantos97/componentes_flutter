import 'package:componentes_basicos/src/models/modelo_simple_campo_texto.dart';
import 'package:flutter/material.dart';

class SimpleCampoTexto extends StatefulWidget {
  final ModeloSimpleCampoTexto modeloCampo;
  
  const SimpleCampoTexto(this.modeloCampo, {super.key});

  @override
  State<SimpleCampoTexto> createState() => _SimpleCampoTextoState();
}

class _SimpleCampoTextoState extends State<SimpleCampoTexto> {



  @override
  Widget build(BuildContext context) {

    ModeloSimpleCampoTexto modeloCampo = widget.modeloCampo;
    
    return TextFormField(
      autocorrect: modeloCampo.autocorrect,
      maxLength: modeloCampo.longitudCampo,
      controller: modeloCampo.defaultController,
      obscureText: modeloCampo.obscureText,
      keyboardType: modeloCampo.tipo,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: (value) => validateText(value, modeloCampo.mensajeError),
      decoration: InputDecoration(
        suffixIcon: modeloCampo.passwordType?IconButton(onPressed: () => {
          setState(() {
             modeloCampo.obscureText = !modeloCampo.obscureText;  
          })
        }, icon: Icon(modeloCampo.obscureText?Icons.visibility_off:Icons.visibility)):null,
        labelText: modeloCampo.requerido? '${modeloCampo.nombreCampo} *':modeloCampo.nombreCampo,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(),
        labelStyle: const TextStyle(color: Colors.black),
        fillColor: Colors.black,
        focusedBorder: const OutlineInputBorder(),
      ),
    );
  }

  String? validateText(String ?param , String mensajeError){
    if( param == null || param.isEmpty){
      return mensajeError;
    }
    return null;
  }

}
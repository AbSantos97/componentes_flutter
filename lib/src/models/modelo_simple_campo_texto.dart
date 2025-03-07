import 'package:flutter/material.dart';

class ModeloSimpleCampoTexto {

  String nombreCampo;
  int longitudCampo = 25;
  String mensajeError;
  bool autocorrect = false;
  bool obscureText = false;
  TextInputType tipo = TextInputType.name;
  bool requerido = true;
  bool justLecture = false;
  bool passwordType=false;
  TextEditingController defaultController = TextEditingController();

  ModeloSimpleCampoTexto(this.nombreCampo,this.tipo,this.longitudCampo,this.autocorrect,this.mensajeError);

  ModeloSimpleCampoTexto.mensajeJustLecture(this.nombreCampo,this.tipo,this.longitudCampo,this.autocorrect):mensajeError= "El campo $nombreCampo es requerido",justLecture = true;

   ModeloSimpleCampoTexto.campoNoRequerido(this.nombreCampo,this.tipo,this.longitudCampo,this.autocorrect):mensajeError= "",justLecture = false,requerido=false;

  ModeloSimpleCampoTexto.mensajeErrorPorDefecto(this.nombreCampo,this.tipo,this.longitudCampo,this.autocorrect):mensajeError= "El campo $nombreCampo es requerido";

  ModeloSimpleCampoTexto.passwordOption(this.nombreCampo,this.tipo,this.longitudCampo,this.autocorrect,this.mensajeError)
  :obscureText=true,
  passwordType=true;


}
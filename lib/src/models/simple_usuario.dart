import 'dart:convert';

class SimpleUsuario {
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String correoElectronico;
  String numeroTelefonico;
  String fechaNacimiento;
  String contrasena;


  SimpleUsuario(this.nombre,this.apellidoPaterno,this.apellidoMaterno,this.correoElectronico,this.numeroTelefonico,this.fechaNacimiento,this.contrasena);

  factory SimpleUsuario.simpleUsuarioFromJson(Map<String,dynamic> json) => 
  SimpleUsuario(
    json[""],
    json[""], 
    json[""], 
    json[""], 
    json[""], 
    json[""],
    json[""]
    );

    Set<String> toJson() => {
      jsonEncode(<String,String>{
        "first_name": nombre,
        "first_last_name": apellidoPaterno,
        "second_last_name": apellidoMaterno,
        "email": correoElectronico,
        "phone_number": numeroTelefonico,
        "password": contrasena,
        "role": "Cliente",
        "birthday": fechaNacimiento
      })
    };


}
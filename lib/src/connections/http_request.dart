import 'dart:convert';
import 'dart:io';
import 'package:componentes_basicos/src/models/album.dart';
import 'package:componentes_basicos/src/models/inicio_sesion_result.dart';
import 'package:componentes_basicos/src/models/simple_usuario.dart';
import 'package:http/http.dart' as http;

class HttpRequest{

  Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {

      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<InicioSesionResult> loginUser(String correoElectronico, String password) async {
    final response = await http.post(Uri.parse("https://api.conectalabores.com/users/login"),
    body: jsonEncode(<String,String>{
      "email": correoElectronico,
      "password": password

    }),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    });
    Map<String, dynamic> jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

    // final responseDos = await http.get(Uri.parse("https://api.conectalabores.com/users/list"));
    // List<dynamic> jsonResponseDos = jsonDecode(responseDos.body) as List<dynamic>;
    // jsonResponseDos.forEach(print);
    // jsonResponseDos.map((e) => InicioSesionResult.fromJsonError(e));


    if(response.statusCode != 200){
      return InicioSesionResult.fromJsonError(jsonResponse);
    }
    return InicioSesionResult.fromJson200(jsonResponse['info']);
  }

  Future<String> saveSimpleUser(SimpleUsuario usuario) async{
    final response = await 
    http.post( Uri.parse("https://api.conectalabores.com/users/register/"),body: jsonEncode(<String,String>{
      "first_name": usuario.nombre,
      "first_last_name": usuario.apellidoPaterno,
      "second_last_name": usuario.apellidoMaterno,
      "email": usuario.correoElectronico,
      "phone_number": usuario.numeroTelefonico,
      "password": usuario.contrasena,
      "role": "Cliente",
      "birthday": usuario.fechaNacimiento
    }),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    });
    
    if(response.statusCode == 200){
      return "El registro se ha hecho de manera correcta";
    }
    return "Ocurrio un error";
  }

}
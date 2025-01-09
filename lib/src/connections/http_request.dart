import 'dart:convert';
import 'dart:io';
import 'package:componentes_basicos/src/models/album.dart';
import 'package:componentes_basicos/src/models/especialidades_por_servicio.dart';
import 'package:componentes_basicos/src/models/experiencia_trabajador.dart';
import 'package:componentes_basicos/src/models/inicio_sesion_result.dart';
import 'package:componentes_basicos/src/models/job_list.dart';
import 'package:componentes_basicos/src/models/simple_usuario.dart';
import 'package:componentes_basicos/src/models/user_data.dart';
import 'package:componentes_basicos/src/models/usuarios_ultima_busqueda.dart';
import 'package:componentes_basicos/src/models/worker_data.dart';
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

  Future<UserData> getUsuarioEspecifico(String id) async {
    final String urlPath = "https://api.conectalabores.com/users/$id";
    final response = await http.get(Uri.parse(urlPath));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

    
    if(response.statusCode == 200){  
      return UserData.fromJson200(jsonResponse);
    }
    return UserData.fromJson500(jsonResponse);

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
    Map<String, dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

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

  Future<String> updateUsuario(String id, UserData usuario) async {
    final response = await http.put(Uri.parse("https://api.conectalabores.com/users/finish_registration/$id"),
    body: jsonEncode(<String,String>{
      "first_name": usuario.firstName,
      "first_last_name": usuario.lastName,
      "second_last_name": usuario.secondLastName,
      "phone_number": usuario.phoneNumber,
      "birthday": usuario.birthday,
      "url_avatar":usuario.urlImagen,
      "authentication_method":"app"
    }),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    });

    if(response.statusCode == 200){
      return "Todo se guardo bien";
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    print(jsonResponse);
    return "Ocurrio un error";

  }

  Future<List<EspecialidadesPorServicio>> getEspecialidadesByFilter(String filter) async {
    final response = await http.get(Uri.parse("https://api.conectalabores.com/jobs/getspecialties?jobname=$filter"));
    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
      return jsonResponse.map((e) => EspecialidadesPorServicio.fromJson200(e)).toList();
    }
    return List.empty();
  }

  Future<List<UsuariosUltimaBusqueda>> obtenerUsuariosPorBusqueda(String job, String speciality) async {
    final response = await http.get(Uri.parse("https://api.conectalabores.com/jobs/workerslist?job=$job&specialtie=$speciality"));
    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
      return jsonResponse.map((e) => UsuariosUltimaBusqueda.fromJson200(e)).toList();
    }
    return List.empty();
  }

  Future<ExperienciaTrabajador> obtenerResumenTrabajador(int id) async{
    final response = await http.get(Uri.parse('https://api.conectalabores.com/worker_experience/workerexperiencebyId/$id'));
    Map<String,dynamic> json = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String,dynamic>;
    print('La respuesta es: ${response.statusCode}');
    if(response.statusCode == 200){
      return ExperienciaTrabajador.success200(json);
    }
    return ExperienciaTrabajador.errorServer(json);
  }

  Future<List<JobList>> obtenerListaOficios() async {
    final response = await http.get(Uri.parse("https://api.conectalabores.com/jobs/jobslist"));
    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      return jsonResponse.map((e) => JobList.success200(e)).toList();
    }
    return List.empty();
  }

  Future<int> crearTrabajador(WorkerData worker) async{
    final response = await 
    http.post( Uri.parse("https://api.conectalabores.com/worker_experience/fillworkerexperience"),body: jsonEncode(<String,String>{
      "worker_id": worker.workerId,
      "speciality_id": worker.specialityId.toString(),
      "job_id": worker.jobId.toString(),
      "company_name": worker.companyName,
      "start_date": worker.startDate,
      "job_alias": worker.jobAlias,
      "location": worker.location,
      "resume": worker.resume
    }),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    });
    
    if(response.statusCode == 200){
      Map<String,dynamic> responseBody = jsonDecode(response.body);
      return responseBody['id'];
    }
    return 0;
  }

  Future<int> crearEspecialidadTrabajador(String description) async{
    final response = await 
    http.post( Uri.parse("https://api.conectalabores.com/jobs/registerspecialty"),body: jsonEncode(<String,String>{
      "description": description,
      "degree": "Maestro",
      "profession": "",
      "certification": ""
    }),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    });
    
    if(response.statusCode == 200){
      Map<String,dynamic> json = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String,dynamic>;
      return json['id'];
    }
    return 0;
  }

  Future<String> guardarImagenesEvidencias(File file)async {
    final request = http.MultipartRequest("POST", Uri.parse("https://api.conectalabores.com/files/upload-file"));
    request.files.add(await http.MultipartFile.fromPath('file',file.path));
    http.StreamedResponse response = await request.send();
    if(response.statusCode == 200){
      String responseBody = await response.stream.bytesToString();
      Map<String,dynamic> resp = jsonDecode(responseBody);
      return resp['url'];
    }
    return "";
  }

  Future<String> guardarRelacionImagenesEvidenciaWorkerExperience(String url,String idWE) async{
    final response = await http.post(Uri.parse("https://api.conectalabores.com/worker_evidence/saveworkerevidence"),body: jsonEncode(<String,String>{
      "Url": url,
      "description": "Imagen_evidencia",
      "worker_experience_id": idWE
    }),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    });

    if(response.statusCode == 200){
      return "Imagen guardada con exito";
    }
    return "";

  }

}
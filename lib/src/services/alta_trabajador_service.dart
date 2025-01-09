import 'dart:io';

import 'package:componentes_basicos/src/connections/http_request.dart';
import 'package:componentes_basicos/src/models/worker_data.dart';

class AltaTrabajadorService {

  HttpRequest httpRequest = HttpRequest();

  Future<int> altaUsuario(WorkerData worker) async {
    int response = await httpRequest.crearTrabajador(worker);
    return response;
  }

  Future<int> crearEspecialidadNueva(String especialidadNueva) async {
    int resultadoEspecialidad = await httpRequest.crearEspecialidadTrabajador(especialidadNueva);
   return resultadoEspecialidad;
  }

  Future<String> crearRutaImagenes(File imagen)async {
    String response = await httpRequest.guardarImagenesEvidencias(imagen);
    return response;
  }

  Future<String> relacionerWorkerEvidenceConWorkerExperience(String url, String id) async {
    String resultado = await httpRequest.guardarRelacionImagenesEvidenciaWorkerExperience(url,id);
    return resultado;
  }


}
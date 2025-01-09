import 'package:componentes_basicos/src/models/worker_evidence.dart';

class ExperienciaTrabajador {

  final String nombre;
  final String apellido;
  final double calificacion;
  final String resumen;
  final String especialidad;
  final String nombreNegocio;
  final List<WorkerEvidence> workerEvidences;
  final String mensajeRespuesta;
  
  ExperienciaTrabajador.success({required this.nombre,required this.apellido,required this.calificacion, required this.resumen,
   required this.especialidad, required this.nombreNegocio, required this.mensajeRespuesta, required this.workerEvidences});

  ExperienciaTrabajador.error({required this.mensajeRespuesta}):
   apellido="",calificacion=0.0,especialidad="",nombre="",nombreNegocio="",resumen="",workerEvidences = List.empty(growable: false);

  factory ExperienciaTrabajador.success200(Map<String,dynamic> json) {
    List<dynamic> lista = json['Worker_Evidence']??List.empty();
    List<WorkerEvidence> evidences = List.empty(growable: true);
    if(lista.isEmpty){
      evidences.add(const WorkerEvidence.error());
    }
    evidences.addAll(lista.map((e) => WorkerEvidence.success200(json: e)).toList());

    return ExperienciaTrabajador.success(nombre: json['Name'], 
    apellido: json['LastName'], 
    calificacion: json['Score']??0.0, 
    resumen: json['Resume']??'', 
    especialidad: json['Specialty'], 
    nombreNegocio: json['Business'],
     mensajeRespuesta: json['response'],
     workerEvidences: evidences);
  }

     
factory ExperienciaTrabajador.errorServer(Map<String,dynamic> json) =>
  ExperienciaTrabajador.error(mensajeRespuesta: json['response']);
}

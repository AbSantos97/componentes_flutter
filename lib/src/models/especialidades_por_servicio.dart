class EspecialidadesPorServicio {

  final int id;
  final String nombre;
  final String errorMessage;

  const EspecialidadesPorServicio.success({required this.id,required this.nombre}):errorMessage="";

  const EspecialidadesPorServicio.error({ required this.errorMessage}):id=0,nombre="";

  factory EspecialidadesPorServicio.fromJson200(Map<String,dynamic> json)
    => EspecialidadesPorServicio.success(id: json['id'], nombre: json['name']);
  

}
class UsuariosUltimaBusqueda{

  final String nombre;
  final String especialidad;
  final double calificacion;
  final String imagen;
  final String oficio;
  final int id;

  const UsuariosUltimaBusqueda(this.nombre,this.especialidad,this.calificacion,this.imagen,this.oficio):id=0;

  const UsuariosUltimaBusqueda.success({required this.id,required this.nombre, required this.especialidad,
  required this.calificacion,required this.imagen,required this.oficio});

  factory UsuariosUltimaBusqueda.fromJson200(Map<String,dynamic> json)
    => UsuariosUltimaBusqueda.success(id: json['id'],
    nombre: json['Name'],
    especialidad: json['Specialty'],
    calificacion: json['Score']??0, 
    imagen: 'https://cdn-icons-png.flaticon.com/512/3135/3135768.png',
    oficio: json['Work']);
}

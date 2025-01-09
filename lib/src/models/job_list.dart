class JobList {
  final int id;
  final String nombre;

  const JobList.success({required this.id, required this.nombre});

  factory JobList.success200(Map<String,dynamic> json) =>
    JobList.success(id: json['id'], nombre: json['name']);

}
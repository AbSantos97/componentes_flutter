class ServiciosModel {

  final int id;
  final String name;
  final String errorMessage;

  ServiciosModel.success({required this.id, required this.name}):errorMessage="";

  ServiciosModel.error({required this.errorMessage}):id=0,name="";

  factory ServiciosModel.fromJson200(Map<String,dynamic> json)
  => ServiciosModel.success(id: json['id'], name: json['name']);



}
class ContractList {
    
    final String nombreCompania;
    final String especialidad;
    final String estatusContrato;
    final String tituloContrato;
    final double value;
    final String logotipo;
    final String id;

    const ContractList.success({required this.nombreCompania, required this.especialidad, required this.estatusContrato, required this.value, required this.id, required this.tituloContrato}):logotipo="https://static.vecteezy.com/system/resources/previews/024/106/033/non_2x/template-business-generic-logo-company-free-vector.jpg";

    factory ContractList.success200(Map<String,dynamic> json)
    => ContractList.success(
      nombreCompania: json['company'],
       especialidad: 'Especialidad',
        estatusContrato: json['status'],
         value: 2000.0, id: json['id'],
          tituloContrato: json['tittle']);
}
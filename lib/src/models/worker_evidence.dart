class WorkerEvidence {

  final int id;
  final String url;
  final String description;

  const WorkerEvidence.success({required this.id, required this.url, required this.description});

  const WorkerEvidence.error():id=0,description="",url="https://static.vecteezy.com/system/resources/previews/022/059/000/non_2x/no-image-available-icon-vector.jpg";

  factory WorkerEvidence.success200({required Map<String,dynamic> json}){
    return WorkerEvidence.success(id: json['id'], url: json['Url'], description: json['description']);
  }

}
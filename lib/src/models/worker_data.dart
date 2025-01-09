class WorkerData {
  
  final String workerId;
  int? specialityId;
  final int jobId;
  final String companyName;
  final String startDate;
  final String jobAlias;
  final String location;
  final String resume;

  WorkerData.success({required this.workerId, required this.specialityId, required this.jobId, 
  required this.companyName, required this.startDate, required this.jobAlias, required this.location, required this.resume});

}
class ContractModel {
  final int contractTextReferenceId = 1;
  final int statusId = 1;
  final String empleadorId;
  final int workerExperienceId;
  final String contractName;
  final String workDescription;
  final double amount;

  const ContractModel.success200({required this.empleadorId, required this.workerExperienceId, 
  required this.contractName, required this.workDescription, required this.amount});

}
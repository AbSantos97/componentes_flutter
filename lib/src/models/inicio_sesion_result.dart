
class InicioSesionResult {

    final String firstName;
    final String firstLastName;
    final String ?secondLastName;
    final String token;
    final String role;
    final String id;
    final String chatReferenceId;
    final String errorMessage;

    const InicioSesionResult.success({required this.id, required this.firstName,required this.firstLastName,
    required this.secondLastName,required  this.role,required this.token,required this.chatReferenceId}):errorMessage="";

    const InicioSesionResult.fail({required this.errorMessage}):
    firstLastName="",
    secondLastName="",
    firstName="",
    token="",
    role="",
    chatReferenceId="",
    id="";

    factory InicioSesionResult.fromJson200(Map<String,dynamic> json) 
    => InicioSesionResult.success(
      id: json['id'],
      firstName: json['first_name'],
      firstLastName: json['first_last_name'],
      secondLastName: json['second_last_name'],
      role: json['role'],
      token: json['token'],
      chatReferenceId: json['chatreferenceId']
      );
    
    factory InicioSesionResult.fromJsonError(Map<String,dynamic> json) 
    => InicioSesionResult.fail(
      errorMessage: json['detail']
      );

}

class InicioSesionResult {

    final String firstName;
    final String firstLastName;
    final String ?secondLastName;
    final String token;
    final String role;
    final String errorMessage;

    const InicioSesionResult.success({required this.firstName,required this.firstLastName,
    required this.secondLastName,required  this.role,required this.token}):errorMessage="";

    const InicioSesionResult.fail({required this.errorMessage}):
    firstLastName="",
    secondLastName="",
    firstName="",
    token="",
    role="";

    factory InicioSesionResult.fromJson200(Map<String,dynamic> json) 
    => InicioSesionResult.success(
      firstName: json['first_name'],
      firstLastName: json['first_last_name'],
      secondLastName: json['second_last_name'],
      role: json['role'],
      token: json['token']
      );
    
    factory InicioSesionResult.fromJsonError(Map<String,dynamic> json) 
    => InicioSesionResult.fail(
      errorMessage: json['detail']
      );

}
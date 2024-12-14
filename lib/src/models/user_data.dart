class UserData {
  
  final String id;
  final String firstName;
  final String lastName;
  final String secondLastName;
  final String urlImagen;
  final String phoneNumber;
  final String email;
  final String birthday;
  final String errorMessage;

  const UserData.success({
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.secondLastName,
      required this.urlImagen,
      required this.phoneNumber,
      required this.email,
      required this.birthday,
  }):errorMessage = "";

  const UserData.error({required this.errorMessage}):
  id = "",
  firstName = "",
  lastName = "",
  secondLastName = "",
  urlImagen = "",
  phoneNumber = "",
  email = "",
  birthday = "";

  factory UserData.fromJson200(Map<String,dynamic> json)
  =>UserData.success(
    id: json['id'], 
    firstName: json['first_name'], 
    lastName: json['first_last_name'], 
    secondLastName: json['second_last_name'], 
    urlImagen: json['url_avatar'] ?? "https://images.squarespace-cdn.com/content/v1/5d77a7f8ad30356d21445262/1695000300830-5TKAFHC2EBYTTM2QUWUP/fotos-de-perfil-blanco-y-negro.jpg", 
    phoneNumber: json['phone_number'], 
    email: json['email'], 
    birthday: json['birthday']??"2024-12-01"
    );

    factory UserData.fromJson500(Map<String,dynamic> json)
  =>const UserData.error(
    errorMessage: "falta error por controlar"
    );

}
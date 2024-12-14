import 'package:componentes_basicos/src/connections/http_request.dart';
import 'package:componentes_basicos/src/models/user_data.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileViewUser extends StatefulWidget {
  const ProfileViewUser({super.key});

  @override
  State<ProfileViewUser> createState() => _ProfileViewUserState();
}

class _ProfileViewUserState extends State<ProfileViewUser> {
  final _storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true ));
  HttpRequest httpRequest = HttpRequest();
  String? userId = "";

  @override
  void initState() {
    startUser();
    super.initState();
  }

  Future<void> startUser() async {
    userId = await _storage.read(key: "id");
    setState(() {
      userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(userId == null ||  userId!.isEmpty){
      return  const Center(child: CircularProgressIndicator());
    }else{
      return Scaffold(
      appBar: 
      AppBar(
        backgroundColor: Colors.amber.shade400,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/edit_client_profile',arguments: userId);
          }, icon: const Icon(Icons.edit))
        ],
        title: const Text('ConectaLabores', textAlign: TextAlign.end, style: TextStyle(color: Colors.black87),),
      ),
      body: FutureBuilder<UserData>(future: httpRequest.getUsuarioEspecifico(userId!)
      , builder: builder)
      );
    }
    
  }

  Widget builder(BuildContext context, AsyncSnapshot<UserData> snapshot) {  
    if(snapshot.hasData){
      return Column(
          children: [
            _filaFotoPerfil(snapshot.data),
            _informacionPerfil(snapshot.data)
          ],
      );
    }
     if(snapshot.hasError){
        return const Text("Salio un error");
     }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _filaFotoPerfil(UserData ?userData){
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    return Container(
      width: width,
      color: Colors.amber.shade400,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
        child: Row(
          children: [
            CircleAvatar(
              maxRadius: 50.0,
              minRadius: 30.0,
              backgroundImage: NetworkImage(userData!.urlImagen)
            ),
            const SizedBox(width: 18.0,),
            Expanded(
              child: Text('Nombre:\n${userData.firstName} ${userData.lastName} ${userData.secondLastName}',
              style: StaticAttributesUtils.estilosSimpleTextoNegritas(19),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _informacionPerfil(UserData ?userData){
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Numero telefonico:", style: StaticAttributesUtils.estilosSimpleTextoNegritas(19)),
              const SizedBox(height: 15.0),
              Text(userData!.phoneNumber),
              const Divider(),
              const SizedBox(height: 15.0),
              Text("Correo electronico:", style: StaticAttributesUtils.estilosSimpleTextoNegritas(19)),
              const SizedBox(height: 15.0),
              Text(userData.email),
              const Divider(),
              const SizedBox(height: 15.0),
              Text("Fecha de nacimiento:", style: StaticAttributesUtils.estilosSimpleTextoNegritas(19)),
              const SizedBox(height: 15.0),
              Text(userData.birthday),
               const Divider(),
              
            ],
          ),
        ),
      )
    );
  }
}
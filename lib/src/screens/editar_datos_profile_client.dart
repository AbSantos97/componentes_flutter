import 'dart:io';

import 'package:componentes_basicos/src/connections/http_request.dart';
import 'package:componentes_basicos/src/models/modelo_simple_campo_texto.dart';
import 'package:componentes_basicos/src/models/user_data.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:componentes_basicos/src/widgets/simple_campo_texto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditarDatosProfileClient extends StatefulWidget {
  const EditarDatosProfileClient({super.key});

  @override
  State<EditarDatosProfileClient> createState() => _EditarDatosProfileClientState();
}

class _EditarDatosProfileClientState extends State<EditarDatosProfileClient> {

  HttpRequest httpRequest = HttpRequest();
  SimpleCampoTexto nombre = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeErrorPorDefecto("Nombre", TextInputType.name, 25, true));
  SimpleCampoTexto apellidoPaterno = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeErrorPorDefecto("Apellido Paterno", TextInputType.name, 25, true));
  SimpleCampoTexto apellidoMaterno = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeErrorPorDefecto("Apellido Materno", TextInputType.name, 25, true));
  SimpleCampoTexto correoElectronico = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeErrorPorDefecto("Correo Electronico", TextInputType.emailAddress, 25, true));
  SimpleCampoTexto numeroTelefonico = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeErrorPorDefecto("Numero telefonico", TextInputType.number, 25, true));
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  DateTime fechaSeleccionada = DateTime.now();
  bool inicialize = false;
  String idUsuario = "";
  File? imageLoaded;
  ImageProvider? imageProvider;
  bool popAvailable = false;

  @override
  Widget build(BuildContext context) {

    idUsuario = ModalRoute.of(context)!.settings.arguments as String;
    
    return FutureBuilder(future: httpRequest.getUsuarioEspecifico(idUsuario), builder: screenBody);
  }



  Widget screenBody(BuildContext context, AsyncSnapshot<UserData> snapshot){
      final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    if(snapshot.hasData){
      return PopScope(
        canPop: popAvailable,
        onPopInvokedWithResult: (didPop, result) async {
          await buildDialog(context);
        },
        child: dataBody(width,snapshot.data));
    }

    if(snapshot.hasError){

    }

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> buildDialog(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Desea abandonar el formulario?',style: StaticAttributesUtils.estiloTitulos()),
          content: Text(
            'Al dar clic en si, ningun dato modificado sera guardado', style: StaticAttributesUtils.estilosSimpleTexto(),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Si'),
              onPressed: () {
                popAvailable = true;
                setState(() {
                  popAvailable;
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Scaffold dataBody(double width,UserData? userData) {
    if(!inicialize){
      nombre.modeloCampo.defaultController.text = userData!.firstName;
      apellidoPaterno.modeloCampo.defaultController.text = userData.lastName;
      apellidoMaterno.modeloCampo.defaultController.text = userData.secondLastName;
      numeroTelefonico.modeloCampo.defaultController.text = userData.phoneNumber;
      fechaSeleccionada = DateTime.parse(userData.birthday);
      String month = fechaSeleccionada.month <10?'0${fechaSeleccionada.month}':fechaSeleccionada.month.toString();
      String day = fechaSeleccionada.day < 10?'0${fechaSeleccionada.day}':fechaSeleccionada.day.toString();
      textEditingController.text = '${fechaSeleccionada.year}-$month-$day';
    }
    inicialize = true;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: ()async => buildDialog(context), icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.amber.shade400,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 40.0),
                child: Text('Editar Perfil',style: StaticAttributesUtils.estilosSimpleTextoNegritas(22))),
              const SizedBox(height: 80.0),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      color: Colors.white,
                      width: width - 50,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                            margin: const EdgeInsets.only(top: 85.0,bottom: 5.0),
                            child: nombre
                            ),
                            Container(
                            margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                            child: apellidoPaterno
                            ),
                            Container(
                            margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                            child: apellidoMaterno
                            ),
                            Container(
                            margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                            child: numeroTelefonico 
                            ),

                            Container(
                            margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                            child: TextFormField(
                              controller: textEditingController,
                              showCursor: false,
                              readOnly: true,
                              autocorrect: false,
                              validator: (value) => validateText(value, "Fecha de Nacimiento"),
                              onTap: () async {
                                FocusScope.of(context).requestFocus(FocusNode());
                                DateTime fecha = await _selectDate(context);
                                String month = fecha.month <10?'0${fecha.month}':fecha.month.toString();
                                String day = fecha.day < 10?'0${fecha.day}':fecha.day.toString();
                                textEditingController.text = '${fecha.year}-$month-$day';
                              },
                              keyboardType: null,
                              decoration: const InputDecoration(
                                labelText: "Fecha de Nacimiento *",
                                border: OutlineInputBorder()
                              ),
                            )
                            ),

                            OutlinedButton(
                              style: StaticAttributesUtils.estiloOutlineButton(45),
                              onPressed: callSaveFunction, 
                              child: Text("Guardar",style: StaticAttributesUtils.estilosSimpleTextoColorAlternativo())
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                   Positioned(
                    top: -85,
                     child: CircleAvatar(
                       maxRadius: 80.0,
                       minRadius: 50.0,
                       backgroundImage: imageLoaded == null? NetworkImage(userData!.urlImagen):imageProvider
                     ),
                   ),
                   Positioned(
                    top: 30,
                    right: width/2 -100,
                     child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                       child: Container(
                        color: Colors.amber.shade400,
                         child: IconButton(
                          color: Colors.black,
                          onPressed: openGallery,
                          icon: const Icon(Icons.add_photo_alternate)),
                       ),
                     )
                   ),
                ],
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  void openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image == null){
      return;
    }
    imageLoaded = File(image.path);
    imageProvider = FileImage(imageLoaded!);
    setState(() {
      imageLoaded;
    });
    
  }

  String? validateText(String ?param , String campo){
    if(param == null || param.isEmpty){
      return 'El campo $campo es requerido';
    }
    return null;
  }

  Future<DateTime> _selectDate(BuildContext context) async{
    fechaSeleccionada = (await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime.now().subtract(const Duration(days: 25550)),
      currentDate: fechaSeleccionada,
      helpText: "Fecha de nacimiento",
      confirmText: "Aceptar",
      cancelText: "Cancelar",
      lastDate: DateTime.now().add(const Duration(days: 1)), 
    ))!;
    return fechaSeleccionada;
  }

  void callSaveFunction() async {
    if (_formKey.currentState!.validate()) {
      
      String valorNombre = nombre.modeloCampo.defaultController.text;
      String valorApellidoPaterno = apellidoPaterno.modeloCampo.defaultController.text;
      String valorApellidoMaterno = apellidoMaterno.modeloCampo.defaultController.text;
      String valorNumeroTelefonico = numeroTelefonico.modeloCampo.defaultController.text;
      String valorFechaNacimiento = textEditingController.text;

      String? respuesta = await httpRequest.updateUsuario(idUsuario, UserData.success(
        id: idUsuario,
        firstName: valorNombre, 
        lastName: valorApellidoPaterno,
        secondLastName: valorApellidoMaterno, 
        urlImagen: "https://images.squarespace-cdn.com/content/v1/5d77a7f8ad30356d21445262/1695000300830-5TKAFHC2EBYTTM2QUWUP/fotos-de-perfil-blanco-y-negro.jpg",
        phoneNumber: valorNumeroTelefonico, 
        email: "", 
        birthday: valorFechaNacimiento));
      
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(respuesta)));
      }
    }
  }
}
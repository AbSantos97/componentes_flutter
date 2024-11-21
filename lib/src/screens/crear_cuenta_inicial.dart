import 'package:componentes_basicos/src/connections/http_request.dart';
import 'package:componentes_basicos/src/models/modelo_simple_campo_texto.dart';
import 'package:componentes_basicos/src/models/simple_usuario.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:componentes_basicos/src/widgets/simple_campo_texto.dart';
import 'package:flutter/material.dart';

class CrearCuentaUsuarioComun extends StatefulWidget {
  const CrearCuentaUsuarioComun({super.key});

  @override
  State<CrearCuentaUsuarioComun> createState() => _CrearCuentaUsuarioComunState();
}

class _CrearCuentaUsuarioComunState extends State<CrearCuentaUsuarioComun> {
  
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  
  SimpleCampoTexto nombre = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeErrorPorDefecto("Nombre", TextInputType.name, 25, true));
  SimpleCampoTexto apellidoPaterno = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeErrorPorDefecto("Apellido Paterno", TextInputType.name, 25, true));
  SimpleCampoTexto apellidoMaterno = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeErrorPorDefecto("Apellido Materno", TextInputType.name, 25, true));
  SimpleCampoTexto correoElectronico = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeErrorPorDefecto("Correo Electronico", TextInputType.emailAddress, 25, true));
  SimpleCampoTexto numeroTelefonico = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeErrorPorDefecto("Numero telefonico", TextInputType.number, 25, true));
  SimpleCampoTexto contrasena = SimpleCampoTexto(ModeloSimpleCampoTexto.passwordOption("Contraseña", TextInputType.visiblePassword, 16, false, "El campo contraseña es requerido"));

  DateTime fechaSeleccionada = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
      backgroundColor: Colors.amber.shade400,
      centerTitle: true,
      title: const Text('ConectaLabores', textAlign: TextAlign.end, style: TextStyle(color: Colors.black87),),
      ),
      body: Center(child: _bodyOfScreen()),
    );
  }

  Widget _bodyOfScreen(){

  final Size size = MediaQuery.sizeOf(context);
  final double width = size.width;

  return SingleChildScrollView(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10.0,top: 10.0),
            child: Text("Crear cuenta",style: StaticAttributesUtils.estiloTitulos())
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(  
              width: width-50.0,
              padding: const EdgeInsets.all(20.0),
              color: Colors.white,
              child:  Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [  
                  Container(
                    margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
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
                    child: correoElectronico
                  ),
                
                  Container(
                  margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                    child:numeroTelefonico
                  ),
                
                  Container(
                  margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                    child: contrasena
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
                        // ignore: prefer_interpolation_to_compose_strings
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

                  ElevatedButton(onPressed: () => validarForm(),
                    child: Container(
                    padding: const EdgeInsets.only(left: 60.0,right: 60.0),
                    child: Text('Enviar',style: StaticAttributesUtils.estilosSimpleTexto())),
                    )

                  ],
                ),
              ),
            ),
          )
      ],
    ),
  );
  }

   String? validateText(String ?param , String campo){
    if(param == null || param.isEmpty){
      return 'El campo $campo es requerido';
    }
    return null;
  }

  void validarForm() async {
    if (_formKey.currentState!.validate()) {
      HttpRequest httpRequest = HttpRequest();
      
      String valorNombre = nombre.modeloCampo.defaultController.text;
      String valorApellidoPaterno = apellidoPaterno.modeloCampo.defaultController.text;
      String valorApellidoMaterno = apellidoMaterno.modeloCampo.defaultController.text;
      String valorCorreo = correoElectronico.modeloCampo.defaultController.text;
      String valorNumero = numeroTelefonico.modeloCampo.defaultController.text;
      String valorContrasena = contrasena.modeloCampo.defaultController.text;
      String valorFechaNacimiento = textEditingController.text;

      String response = await httpRequest.saveSimpleUser(SimpleUsuario(valorNombre, valorApellidoPaterno,
       valorApellidoMaterno, valorCorreo, valorNumero, valorFechaNacimiento, valorContrasena));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(response)));
    }
  }

  Future<DateTime> _selectDate(BuildContext context) async{
    fechaSeleccionada = (await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime.now().subtract(const Duration(days: 25550)),
      currentDate: fechaSeleccionada,
      helpText: "Fecha de inicio",
      confirmText: "Aceptar",
      cancelText: "Cancelar",
      lastDate: DateTime.now().add(const Duration(days: 1)), 
    ))!;
    return fechaSeleccionada;
  }
  
}
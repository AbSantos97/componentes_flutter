import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:flutter/material.dart';

class EjemploFormularios extends StatefulWidget {
  const EjemploFormularios({super.key});

  @override
  State<EjemploFormularios> createState() => _EjemploFormulariosState();
}

class _EjemploFormulariosState extends State<EjemploFormularios> {
final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
  final Size size = MediaQuery.sizeOf(context);
  final double width = size.width;
  
    return Container(
      color: Colors.grey.shade400,
      child:  SingleChildScrollView(
        child: Column(
           children: [
             Container(
              margin: const EdgeInsets.only(bottom: 20.0,top: 20.0),
              child: Text("Crear cuenta",style: StaticAttributesUtils.estiloTitulos(),)),
             ClipRRect(
               borderRadius: BorderRadius.circular(20.0),
               child: Container(  
                 width: width-100.0,
                 padding: const EdgeInsets.all(20.0),
                 color: Colors.white,
                 child:  Form(
                   key: _formKey,
                   child: Column(
                     children: [
                       
                      Container(
                        margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                        child: TextFormField(
                           autocorrect: false,
                           autofocus: true,
                           validator: (value) => validateText(value, "Nombre"),
                           maxLength: 10,
                           decoration: const InputDecoration(
                             prefixIcon: Icon(Icons.account_box),
                             labelText: 'Nombre *',
                             border: OutlineInputBorder()
                           ),
                         ),
                      ),
                     
                       Container(
                        margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                         child: TextFormField(
                           autocorrect: false,
                           autofocus: true,
                           validator: (value) => validateText(value, "Apellido paterno"),
                           maxLength: 10,
                           decoration: const InputDecoration(
                             prefixIcon: Icon(Icons.account_box),
                             labelText: 'Apellido paterno *',
                             border: OutlineInputBorder()
                           ),
                         ),
                       ),
                     
                       Container(
                        margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                         child: TextFormField(
                           autocorrect: false,
                           autofocus: true,
                           validator: (value) => validateText(value, "Apellido materno"),
                           maxLength: 10,
                           decoration: const InputDecoration(
                             prefixIcon: Icon(Icons.account_box),
                             labelText: 'Apellido materno *',
                             border: OutlineInputBorder()
                           ),
                         ),
                       ),
                     
                       Container(
                        margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                         child: TextFormField(
                           autocorrect: false,
                           autofocus: true,
                           maxLength: 10,
                           keyboardType: TextInputType.emailAddress,
                           validator: (value) => validateText(value, "Correo electronico"),
                           decoration: const InputDecoration(
                             prefixIcon: Icon(Icons.email),
                             labelText: 'Correo electronico *',
                             border: OutlineInputBorder()
                           ),
                         ),
                       ),
                     
                       Container(
                        margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                         child: TextFormField(
                           autocorrect: false,
                           autofocus: true,
                           keyboardType: TextInputType.phone,          
                           maxLength: 10,
                           validator: (value) => validateText(value, "Numero telefonico"),
                           decoration: const InputDecoration(
                          
                             prefixIcon: Icon(Icons. phone),
                             labelText: 'Numero telefonico *',
                             border: OutlineInputBorder()
                           ),
                         ),
                       ),
                     
                       Container(
                        margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                         child: TextFormField(
                           autocorrect: false,
                           autofocus: true,
                           maxLength: 10,
                           obscureText: true,
                           keyboardType: TextInputType.visiblePassword,
                           validator: (value) => validateText(value, "Contraseña"),
                           decoration: const InputDecoration(
                             prefixIcon: Icon(Icons.password),
                             labelText: 'Contraseña *',
                             border: OutlineInputBorder()
                           ),
                                               ),
                       ),
                      ElevatedButton(onPressed: () => validarForm(),

                       child: Container(
                        padding: const EdgeInsets.only(left: 60.0,right: 60.0),
                        child: Text('Enviar',style: StaticAttributesUtils.estilosSimpleTexto(),)),
                       )
                     ],
                   ),
                 ),
               ),
             )
          ],
        ),
      )
    );
  }

  String? validateText(String ?param , String campo){
    if(param == null || param.isEmpty){
      return 'El campo $campo es requerido';
    }
    return null;
  }

  void validarForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Envio correcto de la informacion')));
    }
  }
}
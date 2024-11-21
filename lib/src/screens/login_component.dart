import 'package:componentes_basicos/src/connections/http_request.dart';
import 'package:componentes_basicos/src/models/inicio_sesion_result.dart';
import 'package:componentes_basicos/src/models/modelo_simple_campo_texto.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:componentes_basicos/src/widgets/simple_campo_texto.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  SimpleCampoTexto correoElectronico = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeErrorPorDefecto("Correo Electronico", TextInputType.emailAddress, 25, true));
  SimpleCampoTexto contrasena = SimpleCampoTexto(ModeloSimpleCampoTexto.passwordOption("Contraseña", TextInputType.visiblePassword, 16, false, "El campo contraseña es requerido"));


  final _formKey = GlobalKey<FormState>();
  bool ocultarPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade400,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0.0, 50.0, 30.0, 50.0),
                child: Text("Conectalabores",
                style: StaticAttributesUtils.estiloTitulos()
                )
              )
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.fromLTRB(30.0, 20.0, 00.0, 0.0),
                child: Text("Hola! \nBienvenido",
                style: StaticAttributesUtils.estiloEspectacular()),
              )
            ),
            const SizedBox(height: 10.0),

            _crearFormulario(),

            Container(
               margin: const EdgeInsets.fromLTRB(0.0, 5.0, 30.0, 10.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("Olvide mi contraseña",style: StaticAttributesUtils.estilosSimpleTextoNegritas(),)),
            ),

            _crearBotonIniciarContacto(),

            const SizedBox(height: 120.0),

            Align(
              alignment: Alignment.bottomCenter,
              child: _crearSimpleTexto("¿Aun no tienes cuenta?", StaticAttributesUtils.estilosSimpleTexto())
            ),
            
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, "/crear_cuenta"), 
                child: _crearSimpleTexto("Registrate", StaticAttributesUtils.estilosSimpleTextoNegritasSubrayado())
              )
            )

          ],
        ),
      ),
    );
  }

  Widget _crearSimpleTexto(String texto, TextStyle estilo){
    return Text(texto,style: estilo);
  }

  Widget _crearFormulario(){
    return Form(
      key: _formKey,
      child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5.0,bottom: 5.0,left: 30.0,right: 30.0),
                child: correoElectronico
              ),
             Container(
               margin: const EdgeInsets.only(top: 5.0,bottom: 5.0,left: 30.0,right: 30.0),
                child: contrasena
              ),
          ],
      )
    );
  }

  Widget _crearBotonIniciarContacto(){
    ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      shadowColor: Colors.white,
      backgroundColor: Colors.black,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10)
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 5.0,bottom: 5.0,left: 30.0,right: 30.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
                style: raisedButtonStyle,
                onPressed: () async {
                  bool goAhead = await ejecutarLogin();
                  if(goAhead && context.mounted){
                    Navigator.pushNamedAndRemoveUntil(context, "/",(_)=> false);
                  }
                 
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
                  child: Text('Iniciar sesión',style: StaticAttributesUtils.estilosSimpleTextoColorAlternativo()),
                )
        ),
      ),
    );
  }

  Future<bool> ejecutarLogin() async {
    if (_formKey.currentState!.validate()) {
      HttpRequest httpRequest = HttpRequest();
      InicioSesionResult response = await httpRequest.loginUser(
        correoElectronico.modeloCampo.defaultController.text, 
        contrasena.modeloCampo.defaultController.text);
      
       if (context.mounted && response.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(response.errorMessage)));
       }

       await Future.delayed(const Duration(seconds: 2));
       return response.errorMessage.isEmpty;
       
    }

    return false;

  }

}
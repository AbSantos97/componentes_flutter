import 'dart:async';

import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:flutter/material.dart';

class CodigoVerificacionScreen extends StatefulWidget {
  const CodigoVerificacionScreen({super.key});

  @override
  State<CodigoVerificacionScreen> createState() => _CodigoVerificacionScreenState();
}

class _CodigoVerificacionScreenState extends State<CodigoVerificacionScreen> {
  late Timer _timer;
  int totalTime = 120;


  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber.shade400,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70.0),
              Text("Confirmar cuenta", style: StaticAttributesUtils.estilosSimpleTextoNegritas(27),),
               const SizedBox(height: 50.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(  
                  width: size.width - 100.0,
                  color: Colors.white,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: Text("Método de confirmación de cuenta",
                        style: StaticAttributesUtils.estiloTitulos(),
                        textAlign: TextAlign.center),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                       padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: Text("Se ha enviado un código de verificación a su correo electrónico, favor de ingresarlo.",
                        style: StaticAttributesUtils.estilosSimpleTexto22(),
                        textAlign: TextAlign.center),
                      ),
                      const SizedBox(height: 20.0),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0,right: 8.0),
                        child: TextField(
                          autocorrect: false,
                          maxLength: 6,
                          keyboardType: TextInputType.text,
                         decoration: InputDecoration(
                            labelText: "Código de verificación",
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.black)
                         ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                        onPressed: totalTime >0?null:(){
                          totalTime = 120;
                          startTimer();
                        }, 
                        child: Text('Reenviar el código ${totalTime ==0?'':totalTime}')
                        ),
                      ),
                      const SizedBox(height: 30.0),
                       OutlinedButton(
                              style: StaticAttributesUtils.estiloOutlineButton(45,Colors.amber.shade400),
                              onPressed: () => goToLoginScreen(), 
                              child: Text("Confirmar",style: StaticAttributesUtils.estilosSimpleTexto())
                            ),
                      SizedBox(height: size.height/5),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //TODO: Hacer validacion de codigo en backend, dependiendo lo que se envie se hara el regreso al login o se quedara aca
  void goToLoginScreen(){
    Navigator.pushReplacementNamed(context, '/login');
  }

  void startTimer(){
    const intervalo = Duration(seconds: 1);
    _timer = Timer.periodic(intervalo, (timer){
      if(totalTime == 0){
        setState(() {
          _timer.cancel();
        });
      }else{
        totalTime = totalTime -1;
        setState(() {
          totalTime;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
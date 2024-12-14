import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [

            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/info_profile"),
              child: _createRowPersonalData("Perfil","assets/images/portafolio-profesional.png")
            ),
            _createRowPersonalData("Contratos finalizados","assets/images/camaraderia.png"),
            _createRowPersonalData("Contratos en proceso","assets/images/licencias.png"),
            _createRowPersonalData("Metodos de pago","assets/images/metodo-de-pago.png"),
            _createRowPersonalData("Cambiar de perfil - Trabajador","assets/images/comunicacion.png"),
            _createRowPersonalData("Cerrar sesión","assets/images/salida.png")
            
          ],
        ),
      ),
    );
  }

  Widget _createRowPersonalData(String opt,String assetPath){
    return Container(
      margin: const EdgeInsets.only(top: 10.0,bottom: 10.0),
      child: Row(
        children: [
          Image.asset(assetPath,scale: 7.5,),
          const SizedBox(width: 8.0,),
          Text(opt,style: StaticAttributesUtils.estilosSimpleTexto22(),)
      
        ],
      ),
    );
  }

}
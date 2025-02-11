import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:flutter/material.dart';

class DetallesContratos extends StatefulWidget {
  const DetallesContratos({super.key});

  @override
  State<DetallesContratos> createState() => _DetallesContratosState();
}

class _DetallesContratosState extends State<DetallesContratos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ConectaLabores',
            textAlign: TextAlign.end, style: TextStyle(color: Colors.black87)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10.0,right: 10.0,left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Detalles de la contratación"),
              ListTile(
                title: const Text("Pinturas berel"),
                subtitle: const Text("Pintor de brocha gorda"),
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage("https://static.vecteezy.com/system/resources/previews/024/106/033/non_2x/template-business-generic-logo-company-free-vector.jpg"),
                ),
                dense: false,
                minVerticalPadding: 10,
                style: ListTileStyle.list,
                contentPadding: const EdgeInsets.all(0),
                trailing: Container(
                  height: 25,
                  width: 100,
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: selectColor(""),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Text("Por Firmar",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          StaticAttributesUtils.estilosSimpleTextoNegritasCustom(
                              13, Colors.black)),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Fecha de contratacion"),
                  Text("02/09/2024")
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Fecha de firma"),
                  Text("--/--/----")
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Monto establecido"),
                  Text('\$2,500MXN')
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Estatus de pago:"),
                  Text("Pendiente")
                ],
              ),
              const SizedBox(height: 10),
              const Text("Descripcion del servicio"),
              const SizedBox(height: 10),
              const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur a vulputate nibh. Duis luctus luctus eleifend. Ut sodales quam sed libero venenatis, ut ultrices tortor consequat. Proin neque diam, consequat a sodales et, pulvinar ac quam. Aliquam ut finibus risus. Donec placerat, erat sed viverra malesuada, quam ipsum laoreet erat, a hendrerit tellus enim a eros. Proin eu ullamcorper metus, eu fermentum leo. In lectus velit, fringilla eu lectus eget, gravida mattis sapien. Suspendisse rutrum eu erat sed sagittis. Sed maximus tempus tortor quis porta. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer ac fermentum lorem. Curabitur convallis, ante sit amet pellentesque cursus, dui augue suscipit arcu, vitae pellentesque velit urna et sapien.",textAlign: TextAlign.justify)
              ,OutlinedButton(onPressed: () {}, style: StaticAttributesUtils.estiloOutlineButton(10.0, Colors.white), child: const Text("Ver contrato"))
            ],
          ),
        ),
      ),
    );
  }

  Color selectColor(String estatus) {
    if (estatus == "En Proceso") {
      return Colors.lightBlue.shade200;
    }
    if (estatus == "Cancelado") {
      return Colors.red.shade200;
    }
    if (estatus == "Falta Firma") {
      return Colors.yellow.shade200;
    }
    return Colors.green.shade200;
  }
}

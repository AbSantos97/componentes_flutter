import 'package:componentes_basicos/src/models/conversacion_chat.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:flutter/material.dart';

class ConversacionScreen extends StatefulWidget {
  const ConversacionScreen({super.key});

  @override
  State<ConversacionScreen> createState() => _ConversacionScreenState();
}

class _ConversacionScreenState extends State<ConversacionScreen> {

  List<ConversacionChat> msg = List.empty(growable: true);
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    msg.add(ConversacionChat("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum elit felis, pulvinar porta accumsan et",
    "cliente", "trabajador", false));
    msg.add(ConversacionChat("Pellentesque ex dui, iaculis id quam eget, lobortis ornare augue. Integer malesuada varius tempor. Vivamus vel eros eu dui ornare rutrum a in nunc. Sed posuere id elit at dictum. Fusce nulla tortor, auctor sit amet metus sodales",
    "cliente", "trabajador", false));
    msg.add(ConversacionChat("ultrices elementum purus. Sed in magna ut elit suscipit posuere quis cursus sem. Curabitur ullamcorper ultricies quam in malesuada.",
    "trabajador", "cliente", false));
    msg.add(ConversacionChat("Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Quisque eu magna bibendum nisl maximus ultrices tincidunt vel metus. Cras sollicitudin sed massa vitae egestas. Nam luctus elit egestas vulputate gravida",
    "trabajador", "cliente", false));
    msg.add(ConversacionChat(" Aliquam tempus neque ut consequat scelerisque. Ut volutpat, turpis non porta consectetur, tortor augue mollis dui, in euismod ex justo sit amet turpis. ",
    "cliente", "trabajador", false));
    msg.add(ConversacionChat("Ut et mollis ex. Nunc scelerisque elit leo, in dictum velit fermentum a. Nam maximus blandit velit sed finibus. Donec vehicula, massa eu placerat malesuada, est quam pharetra ligula, nec sollicitudin est turpis sit amet nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc nec velit eu erat commodo porta eget sed nunc.",
    "trabajador", "cliente", false));
    msg.add(ConversacionChat("Praesent fermentum tellus erat, in dignissim nisl scelerisque et. Sed efficitur in nunc ac condimentum. Donec interdum aliquam sapien, sit amet finibus ante suscipit in. Sed eu lorem ex.",
    "cliente", "trabajador", false));
    msg.add(ConversacionChat("Duis ac blandit neque. Duis tempus molestie tellus nec convallis. Nullam libero velit, ultrices ac nisl sed, volutpat malesuada ipsum. Pellentesque venenatis elit mauris, quis facilisis nisl feugiat sit amet.",
    "trabajador", "cliente", false));
    msg.add(ConversacionChat("Mauris eget placerat arcu, rhoncus accumsan massa. Phasellus risus sapien, vestibulum at pharetra sed, dignissim sit amet lorem. Aliquam vitae rhoncus felis, in interdum nisl. Donec lobortis odio justo, sit amet viverra tortor blandit at. Nunc a elementum dolor.",
    "cliente", "trabajador", false));
    msg.add(ConversacionChat("Maecenas quis tincidunt ipsum, id vestibulum magna. Donec pretium, mi ut bibendum placerat, lectus eros feugiat odio",
    "trabajador", "cliente", false));
    msg.add(ConversacionChat("ut aliquam nisl erat vel ante. Ut semper blandit enim, non tempor felis mollis sed",
    "cliente", "trabajador", false));
    msg.add(ConversacionChat("Duis egestas risus blandit justo porttitor, nec laoreet diam porttitor. Pellentesque efficitur sagittis pharetra",
    "cliente", "trabajador", false));
    msg.add(ConversacionChat("Maecenas quis tincidunt ipsum, id vestibulum magna. Donec pretium, mi ut bibendum placerat, lectus eros feugiat odio",
    "trabajador", "cliente", true));
    msg.add(ConversacionChat("Maecenas quis tincidunt ipsum, id vestibulum magna. Donec pretium, mi ut bibendum placerat, lectus eros feugiat odio",
    "trabajador", "cliente", true));
    msg.add(ConversacionChat("Maecenas quis tincidunt ipsum, id vestibulum magna. Donec pretium, mi ut bibendum placerat, lectus eros feugiat odio",
    "trabajador", "cliente", true));
    msg.add(ConversacionChat("Maecenas quis tincidunt ipsum, id vestibulum magna. Donec pretium, mi ut bibendum placerat, lectus eros feugiat odio",
    "trabajador", "cliente", true));

    

    Widget body = GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar( 
          title: 
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Conectalabores",style:StaticAttributesUtils.estiloTitulos()),
              Text("Abraham Olvera Santos",style:StaticAttributesUtils.estilosSimpleTexto())
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: iniciarContrato, icon: const Icon(Icons.handshake), tooltip: "Iniciar contrato")
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                controller: scrollController,
                child: Column(
                  children: [
                    for(ConversacionChat i in msg)_cuadrosDeTexto(i),
                  ]
                ),
              ),
            ),
            Row(
              children: [
                  Expanded(
                  child:  Container(
                    margin: const EdgeInsets.all(10.0),
                    child:  const TextField(
                      autocorrect: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder()
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: () => {}, icon: const Icon(Icons.send))
              ],
            )
          ],
        ),
      ),
    );
    return body;

  }

  Widget _cuadrosDeTexto(ConversacionChat msg){
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;

    Color color = msg.remitenteId == "cliente"?Colors.amber.shade400:Colors.lightBlue.shade100;
    Alignment alignment = msg.remitenteId == "cliente"?Alignment.centerRight:Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Badge(
            backgroundColor: Colors.red,
            isLabelVisible: msg.esNuevo && msg.remitenteId != "cliente",
            child: Container(
              width: width-120.0,
              color: color,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(msg.msg),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void iniciarContrato(){
    Navigator.pushNamed(context, '/form_contrato');

  }
}
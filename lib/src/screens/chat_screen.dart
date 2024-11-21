
import 'package:componentes_basicos/src/models/card_chat.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  List<CardChat> list = List.empty(growable: true);
  
  @override
  Widget build(BuildContext context) {
    list.clear();
    list.add(CardChat("Roberto Garcia Martinez", "Abraham Olvera Santos", "Deb. Backend", "Claro que si, podemos programar reuniones semanales para poder mostrarte avances. De igual manera sirve para que repondas dudas de funcionalidad que puedan surgirme",
     "Trabajador", true,"https://cdn-icons-png.flaticon.com/512/3135/3135768.png"));
      list.add(CardChat("Margarita de Jesus Vela Cruz", "Abraham Olvera Santos", "Pintura", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel tempus massa, eu egestas neque. Nunc quis erat nulla. Nulla libero lectus, vulputate vitae laoreet nec, lacinia id augue. Morbi ut ultrices ipsum. Cras quis viverra est, ac eleifend purus.",
     "Trabajador", true,"https://cdn-icons-png.flaticon.com/512/3135/3135768.png"));
      list.add(CardChat("Eduardo Soriano Lopez", "Abraham Olvera Santos", "Carpintero", "Sed eget tincidunt erat. Vivamus consectetur sagittis nunc, eu sagittis ligula elementum in. Morbi ut fringilla nisi, a faucibus lectus. ",
     "Trabajador", true,"https://cdn-icons-png.flaticon.com/512/3135/3135768.png"));
    return SingleChildScrollView(
      child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(25.0, 15.0, 0, 15.0),
                child: Text("Historial de chats",style: StaticAttributesUtils.estiloTitulos())
              ),
              for(var i in list)
                _cardChat(i)
      
              
          ],
        ),
    );

  }

  Widget _cardChat(CardChat cardChat){
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context,"/conversacion"),
      child: Container(
        margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
        height: 140.0,
        child: Badge.count(count: 2,
          child: Card(
            color: Colors.grey.shade300,
            elevation: 2.0,
            child: Container(
              margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: Image.network(cardChat.urlImage,width: width/5,height:(height/8))
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cardChat.nombreTrabajador,style: StaticAttributesUtils.estiloTitulos(),maxLines: 1,overflow: TextOverflow.ellipsis),
                        Text(cardChat.especialidad,style: StaticAttributesUtils.estilosSimpleTexto()),
                        Text(cardChat.ultimoMensaje,style: StaticAttributesUtils.estilosSimpleTexto(),maxLines: 1,overflow: TextOverflow.ellipsis)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:componentes_basicos/src/models/usuarios_ultima_busqueda.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
  List<UsuariosUltimaBusqueda> usuariosUltimaBusqueda = List.empty(growable: true);

  String valueOficioInput = "";
  String valueOfSpeciality = "";
  TextEditingController oficioController = TextEditingController();
  final List<String> _listOfEspecialization = List.empty(growable: true);
  String _dropdownValue = "Seleccione una opción";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConectaLabores', textAlign: TextAlign.end, style: TextStyle(color: Colors.black87)),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _createFirstInputRow(),
                  _createSecondInputRow(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        valueOficioInput == ""?Container():createChip(valueOficioInput),
                        valueOfSpeciality == ""?Container():createChip(valueOfSpeciality),
                        
                      ],
                    ),
                  ),
                   valueOficioInput == "" || valueOfSpeciality == ""?Center(
                    child: Image.asset("assets/images/busqueda_gif.gif"),
                     ):_listarTrabajadores()
                  
                ],
              ),
          ),
      ),
      
    );
  }

  Widget createChip(String value){
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Chip(
        elevation: 10.0,
        backgroundColor: Colors.amber.shade400,
        deleteButtonTooltipMessage: "Eliminar filtro",
        deleteIcon: const Icon(Icons.highlight_remove_sharp),
        label: Text(value,style: StaticAttributesUtils.estilosSimpleTexto(),maxLines: 1,overflow: TextOverflow.ellipsis),
        deleteIconColor: Colors.black,
        onDeleted: () {
          
        },
        labelStyle:  StaticAttributesUtils.estilosSimpleTexto(),
        ),
    );
  }

  Widget _listarTrabajadores(){
    usuariosUltimaBusqueda.clear();
    usuariosUltimaBusqueda.add(UsuariosUltimaBusqueda("Abraham Olvera Santos", "Programador", 4.3, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Doctor"));
    usuariosUltimaBusqueda.add(UsuariosUltimaBusqueda("Eduardo Soriano Lopez", "Programador", 4.5, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Maestro"));
    usuariosUltimaBusqueda.add(UsuariosUltimaBusqueda("Roberto Garcia Martinez", "Programador", 4.0, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Fontanero"));
    usuariosUltimaBusqueda.add(UsuariosUltimaBusqueda("Jose Angel Gonzalez Terron", "Programador", 5.0, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Fotografo"));
    usuariosUltimaBusqueda.add(UsuariosUltimaBusqueda("Margarita de Jesus Vela Cruz", "Programador", 4.3, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Pintor"));
    usuariosUltimaBusqueda.add(UsuariosUltimaBusqueda("Karen de Soriano ", "Programador", 4.5, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Arquitecto"));
    usuariosUltimaBusqueda.add(UsuariosUltimaBusqueda("Guadalupe Janet Romero Garcia", "Programador", 4.0, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Repartidor"));
    usuariosUltimaBusqueda.add(UsuariosUltimaBusqueda("Daniel Guadalupe Romero Sainz", "Programador", 5.0, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Contratista"));
    
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    return Column(
        children: [
          for(var index in usuariosUltimaBusqueda)
            _cardBusquedaPorUsuario(index, width, height)
        ],
      );
  }

  Widget _cardBusquedaPorUsuario(UsuariosUltimaBusqueda index, double width, double height) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detalles_servicio_usuario',arguments: index),
      child: Card(
        elevation: 2.0,
        color: Colors.grey.shade300,
        child: Row(
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(index.imagen,width: width/5,height:(height/8)),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(index.nombre,style: StaticAttributesUtils.estiloTitulos(),maxLines: 1,overflow: TextOverflow.ellipsis,),
                Text(index.oficio,style: StaticAttributesUtils.estilosSimpleTexto()),
                Text(index.especialidad,style: StaticAttributesUtils.estilosSimpleTexto()),
                _crearRankingCalificacion(index.calificacion),
              ],
            ),
          )
          ],
        ),
      ),
    );
  }

    void _onRatingUpdate(double rating){

}

  Widget _crearRankingCalificacion(double val){
    return RatingBar(itemSize: 30.0,
      ratingWidget: RatingWidget(
        full:  Icon(Icons.star_outlined,
        color: (val <= 3.5)?Colors.red: Colors.amber
        ), 
        half: Icon(
          Icons.star_half_outlined,
          color: (val <= 3.5)?Colors.red: Colors.amber
        ), 
        empty: const Icon(
          Icons.star_outline,
          color: Colors.grey,
        )
        ),
         onRatingUpdate: _onRatingUpdate,
         allowHalfRating: true,
         ignoreGestures: true,
         itemPadding: const EdgeInsets.all(0.7),
         minRating: 0.0,
         maxRating: 5.0,
         unratedColor: Colors.grey.shade200,
         itemCount: 5,
         initialRating: val,
         );
  }

  Row _createSecondInputRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Especialidad: ",style: StaticAttributesUtils.estilosSimpleTexto()),
        const SizedBox(width: 10.0),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: DropdownButton(
              isExpanded: true,
              menuMaxHeight: 300.0,
              value: _dropdownValue,
              disabledHint: Text(_dropdownValue),
              icon: const Icon(Icons.arrow_drop_down),
              items: _listOfEspecialization.map<DropdownMenuItem<String>>(
                (String elem) => _createDropDowmMenuItem(elem)).toList(),
              onChanged: (String? value) {
                setState(() {
                  _dropdownValue = value!;
                  valueOfSpeciality = value;
                });
              },
            ),
          ),
        )       
      ],
    );
  }

  Row _createFirstInputRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12.0),
          child: Text("Buscar: ",style: StaticAttributesUtils.estilosSimpleTexto())),
        const SizedBox(width: 10.0),
        Expanded(
          child: TextField(
            controller: oficioController,
              autocorrect: false,
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text("Oficio / Profesión")
              ),
            ),
        ),
        const SizedBox(width: 10.0),
          Container(
            margin: const EdgeInsets.only(top: 12.0,right: 10.0),
            child: IconButton(onPressed: () => _llenarLista(),
            color: Colors.black,
             icon: const Icon(Icons.search),
             tooltip: "Buscar",
             ),
          )
          
      ],
    );
  }

  DropdownMenuItem<String> _createDropDowmMenuItem(String item){
    bool enabled = item != "Seleccione una opción";
    return DropdownMenuItem(value:item, enabled: enabled, child: Text(item,style: StaticAttributesUtils.estilosSimpleTexto()));
  }  

  void _llenarLista(){
    valueOficioInput = oficioController.text;
    _dropdownValue = "Seleccione una opción";
    _listOfEspecialization.clear();
    _listOfEspecialization.add("Seleccione una opción");
    _listOfEspecialization.add("Backend developer");
    _listOfEspecialization.add("Frontend developer");
    _listOfEspecialization.add("Fullstack developer");
    _listOfEspecialization.add("Cloud developer");
    _listOfEspecialization.add("BigData developer");
    _listOfEspecialization.add("Support developer");
    _listOfEspecialization.add("Networking developer");
    setState(() {
      _dropdownValue;
      _listOfEspecialization;
      valueOficioInput;
    });
  }
}
import 'package:componentes_basicos/src/connections/http_request.dart';
import 'package:componentes_basicos/src/models/especialidades_por_servicio.dart';
import 'package:componentes_basicos/src/models/usuarios_ultima_busqueda.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  HttpRequest httpRequest = HttpRequest();
  final GlobalKey<DropdownSearchState> dropDownKeyOficios =
      GlobalKey<DropdownSearchState>();
  List<UsuariosUltimaBusqueda> usuariosUltimaBusqueda = List.empty(growable: true);

  String valueOficioInput = "";
  String valueOfSpeciality = "";
  TextEditingController oficioController = TextEditingController();
  final List<String> _listOfEspecialization = List.empty(growable: true);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  const SizedBox(height: 10.0),
                  _createSecondInputRow(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        valueOficioInput == ""?Container():createChip(valueOficioInput,funcionLimpiarJob),
                        valueOfSpeciality == ""?Container():createChip(valueOfSpeciality,funcionLimpiarEspecialidad),
                        
                      ],
                    ),
                  ),
                   valueOficioInput == "" && valueOfSpeciality == ""?Center(
                    child: Image.asset("assets/images/busqueda_gif.gif"),
                     ):_listarTrabajadores()
                ],
              ),
          ),
      ),
    );
  }

  void funcionLimpiarJob(){
    valueOficioInput = "";
    valueOfSpeciality = "";
    oficioController.text = "";
    usuariosUltimaBusqueda.clear();
    _listOfEspecialization.clear();
    _listOfEspecialization.add("Seleccione una opción");

    setState(() {
      _listOfEspecialization;
      usuariosUltimaBusqueda;
      valueOficioInput;
    });
  }

  void funcionLimpiarEspecialidad() async{
    valueOfSpeciality = "";
    usuariosUltimaBusqueda.clear();
    usuariosUltimaBusqueda.addAll(await actualizarListaTrabajadores(oficioController.text, ""));

    setState(() {
      usuariosUltimaBusqueda;
      valueOfSpeciality;
    });

    //Actualizat la lista de los trabajadores
  }

  Widget createChip(String value, VoidCallback onDeleteEvent){
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Chip(
        elevation: 10.0,
        backgroundColor: Colors.amber.shade400,
        deleteButtonTooltipMessage: "Eliminar filtro",
        deleteIcon: const Icon(Icons.highlight_remove_sharp),
        label: Text(value,style: StaticAttributesUtils.estilosSimpleTexto(),maxLines: 1,overflow: TextOverflow.ellipsis),
        deleteIconColor: Colors.black,
        onDeleted: onDeleteEvent,
        labelStyle:  StaticAttributesUtils.estilosSimpleTexto(),
        ),
    );
  }

  Widget _listarTrabajadores(){
    
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;
    if(usuariosUltimaBusqueda.isEmpty){
      return Container();
    }
    return Column(
        children: [
          for(var index in usuariosUltimaBusqueda)
            _cardBusquedaPorUsuario(index, width, height)
        ],
      );
  }

  Widget _cardBusquedaPorUsuario(UsuariosUltimaBusqueda index, double width, double height) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detalles_servicio_usuario',arguments: index.id),
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
                Text(index.oficio,style: StaticAttributesUtils.estilosSimpleTexto(),maxLines: 1,overflow: TextOverflow.ellipsis,),
                Text(index.especialidad,style: StaticAttributesUtils.estilosSimpleTexto(),maxLines: 1,overflow: TextOverflow.ellipsis,),
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

  Widget _createSecondInputRow(){
    return DropdownSearch<String>(
            key: dropDownKeyOficios,
            selectedItem: valueOfSpeciality,
            onChanged: (value) async {
              valueOfSpeciality = value!;
               await actualizarListaTrabajadoresPorEspecialidad(value);
              setState(() {
                valueOfSpeciality;
                
              });
            },
            enabled: true,
            filterFn: (item, filter) {
              return item.toLowerCase().contains(filter.toLowerCase());
            },
            items: (filter, infiniteScrollProps) => _listOfEspecialization,
            decoratorProps: const DropDownDecoratorProps(   
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                labelText: 'Especialidades:',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black),
                fillColor: Colors.black,
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            popupProps: const PopupProps.menu(
                showSearchBox: false,
                cacheItems: true,
                showSelectedItems: true,
                fit: FlexFit.loose,
                constraints: BoxConstraints(maxHeight: 400.0)),
          );
  }

  Future<void> actualizarListaTrabajadoresPorEspecialidad(String value)async {
    usuariosUltimaBusqueda.clear();
    usuariosUltimaBusqueda.addAll(await actualizarListaTrabajadores(oficioController.text, value));
    setState(() {
      usuariosUltimaBusqueda;
    });
  }

  Widget _createFirstInputRow(){
    return TextField(
            controller: oficioController,
              autocorrect: false,
              onSubmitted: (value) {
                _llenarLista();
              },
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Oficio / Profesión")
              ),
        );
  }  

  void _llenarLista() async {
    if(oficioController.text.trim().isNotEmpty){
      valueOficioInput = oficioController.text.trim();
      _listOfEspecialization.clear();
      List<EspecialidadesPorServicio> lista = await httpRequest.getEspecialidadesByFilter(valueOficioInput);
      _listOfEspecialization.addAll(lista.map((e) => e.nombre).toSet().toList());
      usuariosUltimaBusqueda.clear();
      usuariosUltimaBusqueda.addAll(await actualizarListaTrabajadores(valueOficioInput, ""));
      setState(() {
        _listOfEspecialization;
        valueOficioInput;
        usuariosUltimaBusqueda;
      });
    }
  }

  Future<List<UsuariosUltimaBusqueda>> actualizarListaTrabajadores(String oficio, String especialidad) async {
    List<UsuariosUltimaBusqueda> usuariosTmp = await httpRequest.obtenerUsuariosPorBusqueda(oficio, especialidad);
    return usuariosTmp;
  }
}
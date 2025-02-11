import 'package:componentes_basicos/src/connections/http_request.dart';
import 'package:componentes_basicos/src/models/especialidades_por_servicio.dart';
import 'package:componentes_basicos/src/models/usuarios_ultima_busqueda.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  HttpRequest httpRequest = HttpRequest();
  final GlobalKey<DropdownSearchState> dropDownKeyOficios =
      GlobalKey<DropdownSearchState>();
  List<UsuariosUltimaBusqueda> usuariosUltimaBusqueda =
      List.empty(growable: true);

  String valueOficioInput = "";
  String valueOfSpeciality = "";
  TextEditingController oficioController = TextEditingController();
  final List<String> _listOfEspecialization = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ConectaLabores',
            textAlign: TextAlign.end, style: TextStyle(color: Colors.black87)),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
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
                  valueOficioInput == ""
                      ? Container()
                      : createChip(valueOficioInput, funcionLimpiarJob),
                  valueOfSpeciality == ""
                      ? Container()
                      : createChip(
                          valueOfSpeciality, funcionLimpiarEspecialidad),
                ],
              ),
            ),
            valueOficioInput == "" && valueOfSpeciality == ""?Expanded(
              child: SingleChildScrollView(
                      child: Center(
                      child: Image.asset("assets/images/busqueda_gif.gif"),
                    ),
                  )
            ): const SizedBox.shrink(),
            valueOficioInput == "" && valueOfSpeciality == ""
                ? const SizedBox.shrink()
                : _listarTrabajadores()
          ],
        ),
      ),
    );
  }

  void funcionLimpiarJob() {
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

  void funcionLimpiarEspecialidad() async {
    valueOfSpeciality = "";
    usuariosUltimaBusqueda.clear();
    usuariosUltimaBusqueda
        .addAll(await actualizarListaTrabajadores(oficioController.text, ""));

    setState(() {
      usuariosUltimaBusqueda;
      valueOfSpeciality;
    });

    //Actualizat la lista de los trabajadores
  }

  Widget createChip(String value, VoidCallback onDeleteEvent) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Chip(
        elevation: 10.0,
        backgroundColor: Colors.amber.shade400,
        deleteButtonTooltipMessage: "Eliminar filtro",
        deleteIcon: const Icon(Icons.highlight_remove_sharp),
        label: Text(value,
            style: StaticAttributesUtils.estilosSimpleTexto(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        deleteIconColor: Colors.black,
        onDeleted: onDeleteEvent,
        labelStyle: StaticAttributesUtils.estilosSimpleTexto(),
      ),
    );
  }

  Widget _listarTrabajadores() {
    if (usuariosUltimaBusqueda.isEmpty) {
      return Container();
    }

    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: usuariosUltimaBusqueda.length,
          itemBuilder: (BuildContext buildContext, int index) {
            return itemBuilder(usuariosUltimaBusqueda[index]);
          }),
    );
  }

  Widget itemBuilder(UsuariosUltimaBusqueda usuariosUltimaBusqueda) {
    return Container(
      margin: const EdgeInsets.only(left: 9, right: 9, top: 7),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(width: 3, color: Colors.grey.shade300),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, '/detalles_servicio_usuario',
            arguments: usuariosUltimaBusqueda.id),
        contentPadding: const EdgeInsets.only(top: 3, bottom: 3),
        isThreeLine: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 5, top: 5),
          child: CircleAvatar(
              backgroundImage: NetworkImage(usuariosUltimaBusqueda.imagen)),
        ),
        title: Text(usuariosUltimaBusqueda.nombre,
            style: StaticAttributesUtils.estilosSimpleTexto22(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        subtitle: Text(usuariosUltimaBusqueda.oficio,
            style: StaticAttributesUtils.estilosSimpleTexto(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        dense: true,
        trailing: Container(
            width: 50,
            margin: const EdgeInsets.only(right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${usuariosUltimaBusqueda.calificacion}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                )
              ],
            )),
      ),
    );
  }

  Widget _createSecondInputRow() {
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

  Future<void> actualizarListaTrabajadoresPorEspecialidad(String value) async {
    usuariosUltimaBusqueda.clear();
    usuariosUltimaBusqueda.addAll(
        await actualizarListaTrabajadores(oficioController.text, value));
    setState(() {
      usuariosUltimaBusqueda;
    });
  }

  Widget _createFirstInputRow() {
    return TextField(
      controller: oficioController,
      autocorrect: false,
      onSubmitted: (value) {
        _llenarLista();
      },
      autofocus: false,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Oficio / Profesión")),
    );
  }

  void _llenarLista() async {
    if (oficioController.text.trim().isNotEmpty) {
      valueOficioInput = oficioController.text.trim();
      _listOfEspecialization.clear();
      List<EspecialidadesPorServicio> lista =
          await httpRequest.getEspecialidadesByFilter(valueOficioInput);
      _listOfEspecialization
          .addAll(lista.map((e) => e.nombre).toSet().toList());
      usuariosUltimaBusqueda.clear();
      usuariosUltimaBusqueda
          .addAll(await actualizarListaTrabajadores(valueOficioInput, ""));
      setState(() {
        _listOfEspecialization;
        valueOficioInput;
        usuariosUltimaBusqueda;
      });
    }
  }

  Future<List<UsuariosUltimaBusqueda>> actualizarListaTrabajadores(
      String oficio, String especialidad) async {
    List<UsuariosUltimaBusqueda> usuariosTmp =
        await httpRequest.obtenerUsuariosPorBusqueda(oficio, especialidad);
    return usuariosTmp;
  }
}

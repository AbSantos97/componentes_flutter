import 'package:componentes_basicos/src/connections/http_request.dart';
import 'package:componentes_basicos/src/models/contract_list.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ListaContratosWidget extends StatefulWidget {
  const ListaContratosWidget({super.key});

  @override
  State<ListaContratosWidget> createState() => _ListaContratosWidgetState();
}

class _ListaContratosWidgetState extends State<ListaContratosWidget> {
  final _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));
  final GlobalKey<DropdownSearchState> dropDownKeyOficios =
      GlobalKey<DropdownSearchState>();

  HttpRequest httpRequest = HttpRequest();
  String? userId = "";

  @override
  void initState() {
    startUser();
    super.initState();
  }

  Future<void> startUser() async {
    userId = await _storage.read(key: "id");
    setState(() {
      userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null || userId!.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return FutureBuilder(future: httpRequest.obtenerContratosPorIdUsuario(userId!), builder: screenBody);
  }

  Widget screenBody(
      BuildContext context, AsyncSnapshot<List<ContractList>> snapshot) {
    if (snapshot.hasData) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('ConectaLabores',
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.black87)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text("Mis contratos en proceso",
                    style: StaticAttributesUtils.estiloTitulos())),
            const SizedBox(height: 10),
            _createSecondInputRow(),
            const SizedBox(height: 10),
            Expanded(child: listViewItem(snapshot)),
          ],
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }

  ListView listViewItem(AsyncSnapshot<List<ContractList>> snapshot) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        },
        itemCount: snapshot.data!.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return itemBuilder(snapshot.data![index]);
        });
  }

  Widget itemBuilder(ContractList contractList) {
    return Container(
      margin: const EdgeInsets.only(left: 9, right: 9, top: 7),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(width: 3, color: Colors.grey.shade300),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context,'/detalles_contratos'),
        contentPadding: const EdgeInsets.only(top: 3, bottom: 3),
        isThreeLine: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 5, top: 5),
          child: CircleAvatar(
              backgroundImage: NetworkImage(contractList.logotipo)),
        ),
        title: Text(contractList.nombreCompania,
            style: StaticAttributesUtils.estilosSimpleTexto22(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        subtitle: Text(contractList.tituloContrato,
            style: StaticAttributesUtils.estilosSimpleTexto(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        dense: true,
        trailing: Container(
          height: 25,
          width: 100,
          margin: const EdgeInsets.only(right: 5, top: 5),
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: selectColor(contractList.estatusContrato),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Text(contractList.estatusContrato,
          textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: StaticAttributesUtils.estilosSimpleTextoNegritasCustom(13,
              contractList.estatusContrato == "Pendiente firma"?Colors.black:Colors.white)),
        ),
      ),
    );
  }

  Color selectColor(String estatus) {
    if (estatus == "En proceso") {
      return Colors.lightBlue.shade200;
    }
    if (estatus == "Cancelado") {
      return Colors.red.shade200;
    }
    if (estatus == "Pendiente firma") {
      return Colors.yellow.shade200;
    }
    return Colors.green.shade200;
  }

  String valueOfFilter = "Todos";

  Widget _createSecondInputRow() {
    List<String> listaFiltros = List.empty(growable: true);
    listaFiltros.add("Cancelado");
    listaFiltros.add("En proceso");
    listaFiltros.add("Pendiente firma");
    listaFiltros.add("Finalizado");
    listaFiltros.add("Todos");

    return Container(
      margin: const EdgeInsets.only(left: 10,right: 10),
      
      child: DropdownSearch<String>(
        key: dropDownKeyOficios,
        selectedItem: valueOfFilter,
        onChanged: (value) async {
          valueOfFilter = value!;
        },
        enabled: true,
        items: (filter, infiniteScrollProps) => listaFiltros,
        decoratorProps: const DropDownDecoratorProps(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(),
            labelText: 'Estatus:',
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
      ),
    );
  }
}

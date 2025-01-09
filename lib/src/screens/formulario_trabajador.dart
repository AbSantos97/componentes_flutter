import 'dart:io';

import 'package:componentes_basicos/src/connections/http_request.dart';
import 'package:componentes_basicos/src/models/especialidades_por_servicio.dart';
import 'package:componentes_basicos/src/models/job_list.dart';
import 'package:componentes_basicos/src/models/modelo_simple_campo_texto.dart';
import 'package:componentes_basicos/src/models/worker_data.dart';
import 'package:componentes_basicos/src/services/alta_trabajador_service.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:componentes_basicos/src/widgets/loading_simple_page.dart';
import 'package:componentes_basicos/src/widgets/simple_campo_texto.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class FormularioTrabajador extends StatefulWidget {
  const FormularioTrabajador({super.key});

  @override
  State<FormularioTrabajador> createState() => _FormularioTrabajadorState();
}

class _FormularioTrabajadorState extends State<FormularioTrabajador> {
  HttpRequest httpRequest = HttpRequest();
  SimpleCampoTexto compania = SimpleCampoTexto(
      ModeloSimpleCampoTexto.mensajeJustLecture(
          "Nombre de la compañia", TextInputType.name, 25, true));
  SimpleCampoTexto alias = SimpleCampoTexto(
      ModeloSimpleCampoTexto.campoNoRequerido(
          "Alias del oficio", TextInputType.name, 25, true));
  SimpleCampoTexto resumen = SimpleCampoTexto(
      ModeloSimpleCampoTexto.mensajeErrorPorDefecto(
          "Resumen", TextInputType.multiline, 300, true));
  SimpleCampoTexto location = SimpleCampoTexto(
      ModeloSimpleCampoTexto.campoNoRequerido(
          "Ubicación", TextInputType.text, 300, true));
  SimpleCampoTexto nuevaEspecialidad = SimpleCampoTexto(
      ModeloSimpleCampoTexto.mensajeJustLecture(
          "Especialidad", TextInputType.name, 100, true));

  List<String> itemsTrabajos = List.empty(growable: true);
  List<JobList> jobList = List.empty(growable: true);
  AltaTrabajadorService altaTrabajadorService = AltaTrabajadorService();
  List<EspecialidadesPorServicio> listaEspecialidades =
      List.empty(growable: true);
  List<String> itemsEspecialidades = List.empty(growable: true);
  String oficioSeleccionado = "";
  String especialidadSeleccionada = "";
  final _formKeyStepUno = GlobalKey<FormState>();
  final _formKeyStepDos = GlobalKey<FormState>();
  TextEditingController fechaInicioController = TextEditingController();
   DateTime? fechaInicio;

  bool showLoading = false;
  bool popAvailable = false;

  final List<XFile?> imagenes = List.empty(growable: true);

  final GlobalKey<DropdownSearchState> dropDownKeyOficios =
      GlobalKey<DropdownSearchState>();
  final GlobalKey<DropdownSearchState> dropDownKeyEspecialdes =
      GlobalKey<DropdownSearchState>();
  bool isChecked = false;
  int _index = 0;
  final _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));

  @override
  Widget build(BuildContext context) {
    return dataBody();
  }

  Scaffold dataBody() {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () async => buildDialog(context),
              icon: const Icon(Icons.arrow_back)),
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: httpRequest.obtenerListaOficios(), builder: cuerpo));
  }

  Widget cuerpo(BuildContext context, AsyncSnapshot<List<JobList>> response) {
    if (response.hasData) {
      itemsTrabajos.clear();
      jobList.clear();
      jobList.addAll(response.data!);
      itemsTrabajos.addAll(jobList.map((e) => e.nombre).toList());
      return Stack(
        children: [
          screenWidgets(),
          showLoading? const LoadingSimplePage(): const SizedBox.shrink()
        ],
      );
    }
    if (response.hasError) {
      

    }
    return const LoadingSimplePage();
  }

  Widget screenWidgets() {
    return Stepper(
        type: StepperType.vertical,
        currentStep: _index,
        onStepCancel: () => onStepController(_index - 1, "back"),
        onStepContinue: () => onStepController(_index + 1, "next"),
        onStepTapped: (int indexTaped) => onStepController(indexTaped, ""),
        steps: <Step>[
          Step(
              title: const Text("Datos Generales"),
              isActive: true,
              state: estadoDadoIndex(0),
              content: stepUno()),
          Step(
              title: const Text("Datos Adicionales"),
              content: setpDos(),
              isActive: true,
              state: estadoDadoIndex(1)),
          Step(
              title: const Text("Evidencias de trabajo"),
              content: stepTres(),
              isActive: true,
              state: estadoDadoIndex(2)),
        ]);
  }

  StepState estadoDadoIndex(int currentIndex) {
    if (currentIndex == _index) {
      return StepState.editing;
    }
    if (currentIndex < _index) {
      return StepState.complete;
    }
    return StepState.indexed;
  }

  void onStepController(int newIndex, String function) {
    if (function != "back" && function != "next" && function.isNotEmpty) {
      return;
    }

    bool respuestaValidacion = true;
    if(_index == 0){
      respuestaValidacion = validarFormularioUno();
    }else if(_index == 1){
      respuestaValidacion = validarFormularioDos();
    }

    if(respuestaValidacion == false)return;

    if (function == "back" && _index > 0) {
      _index = newIndex;
    }

    if (function == "next" && _index < 2) {
      _index = newIndex;
    }

    if (function.isEmpty) {
      _index = newIndex;
    }

    if(newIndex == 3){
      showLoading = true;
      setState(() {
        showLoading;
      });
      callSaveFunction();
    }

    setState(() {
      _index;
    });
    return;
  }

  bool validarFormularioUno() => (_formKeyStepUno.currentState!.validate() && oficioSeleccionado.isNotEmpty);

  bool validarFormularioDos() {
    if(isChecked){
      return _formKeyStepDos.currentState!.validate();
    }
    return true;
  }
        

  Widget stepUno() {
    return Form(
        key: _formKeyStepUno,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 10.0),
          DropdownSearch<String>(
            key: dropDownKeyOficios,
            validator: (value) {
              if(value == null || value.isEmpty)return "El campo Oficio es requerido";
              return null;
            },
            selectedItem: oficioSeleccionado,
            onChanged: (value) async {
              oficioSeleccionado = value!;
              updateListaEspecialidades();
            },
            enabled: true,
            filterFn: (item, filter) {
              return item.toLowerCase().contains(filter.toLowerCase());
            },
            items: (filter, infiniteScrollProps) => itemsTrabajos,
            decoratorProps: const DropDownDecoratorProps(   
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                labelText: 'Oficios:',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black),
                fillColor: Colors.black,
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            popupProps: const PopupProps.menu(
                showSearchBox: true,
                cacheItems: true,
                showSelectedItems: true,
                fit: FlexFit.loose,
                constraints: BoxConstraints(maxHeight: 400.0)),
          ),
          const SizedBox(height: 30.0),
          Container(
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: compania),
          Container(
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: resumen),
          Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: TextFormField(
                controller: fechaInicioController,
                showCursor: false,
                readOnly: true,
                autocorrect: false,
                validator: (value) => validateText(value, "Fecha de inicio"),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime ?fecha = await _selectDateInicio(context);
                  if(fecha != null){
                      String month = fecha.month < 10
                        ? '0${fecha.month}'
                        : fecha.month.toString();
                    String day =
                        fecha.day < 10 ? '0${fecha.day}' : fecha.day.toString();
                    fechaInicioController.text = '${fecha.year}-$month-$day';
                    fechaInicio = fecha;
                  }
                  
                },
                keyboardType: null,
                decoration: const InputDecoration(
                    labelText: "Fecha de inicio del servicio *",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    focusedBorder: OutlineInputBorder(),
                    ),
              ))
        ]));
  }

  Widget setpDos() {
    return Form(
        key: _formKeyStepDos,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 30.0,
          ),
          dropdownEspecialidades(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: oficioSeleccionado.isEmpty
                      ? null
                      : (bool? value) {
                          prepararInput(value!);
                          setState(() {
                            isChecked;
                          });
                        }),
              GestureDetector(
                  onTap: () => oficioSeleccionado.isEmpty
                      ? null
                      : prepararInput(!isChecked),
                  child: const Text("Nueva especialidad")),
            ],
          ),
          isChecked ? inputCrearEspecialidad() : const SizedBox.shrink(),
          Container(
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: alias),
          Container(
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: location),
        ]));
  }

  Widget stepTres() {
     Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height/2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(onPressed: () async {openGallery();}, 
          style: StaticAttributesUtils.estiloOutlineButton(60.0, Colors.white),
          child: const Text("Agregar imagen")
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
            itemCount: imagenes.length,
            itemBuilder: (BuildContext buildContext, int index){
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(File(imagenes[index]!.path))
                ),
                title: Text(imagenes[index]!.name),
                subtitle: Text(imagenes[index]!.path),
                trailing: const Icon(Icons.menu_outlined),
              );
            }
            ),
          ),
        ],
      ),
    );
  }

  void openGallery() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile?> image = await picker.pickMultiImage();
    if (image.isEmpty) {
      return;
    }
    List<String> nombreImagenes = imagenes.map((e) => e!.name).toList();
    image.removeWhere((element) => nombreImagenes.contains(element!.name));
    imagenes.addAll(image);
    setState(() {
      imagenes;
    });
  }

  DropdownSearch<String> dropdownEspecialidades() {
    return DropdownSearch<String>(
      key: dropDownKeyEspecialdes,
      onChanged: (String? value) => especialidadSeleccionada = value ?? "",
      selectedItem: especialidadSeleccionada,
      enabled: !isChecked && itemsEspecialidades.isNotEmpty,
      filterFn: (item, filter) {
        return item.toLowerCase().contains(filter.toLowerCase());
      },
      items: (filter, infiniteScrollProps) => itemsEspecialidades,
      decoratorProps: const DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: 'Especialidades:',
          border: OutlineInputBorder(),
        ),
      ),
      popupProps: const PopupProps.menu(
          showSearchBox: true,
          cacheItems: true,
          showSelectedItems: true,
          fit: FlexFit.loose,
          constraints: BoxConstraints(maxHeight: 400.0)),
    );
  }

  void prepararInput(bool currentStatus) {
    isChecked = currentStatus;
    dropDownKeyEspecialdes.currentState?.clear();
    nuevaEspecialidad.modeloCampo.defaultController.text = "";
    especialidadSeleccionada = "";
    setState(() {
      itemsEspecialidades;
      especialidadSeleccionada;
    });
  }

  Widget inputCrearEspecialidad() {
    return Container(
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: nuevaEspecialidad);
  }

  void updateListaEspecialidades() async {
    listaEspecialidades.clear();
    itemsEspecialidades.clear();
    listaEspecialidades =
        await httpRequest.getEspecialidadesByFilter(oficioSeleccionado);
    itemsEspecialidades
        .addAll(listaEspecialidades.map((e) => e.nombre).toList());
    setState(() {
      itemsEspecialidades;
    });
  }

  Future<void> callSaveFunction() async {
    if (validarFormularioUno() && validarFormularioDos()) {
      String? id = await _storage.read(key: "id");
      int jobId = jobList
          .firstWhere((element) => element.nombre == oficioSeleccionado)
          .id;

      int? speciality;
      if (especialidadSeleccionada.isEmpty && isChecked) {
        speciality = await altaTrabajadorService.crearEspecialidadNueva(
            nuevaEspecialidad.modeloCampo.defaultController.text);
      } else if(especialidadSeleccionada.isNotEmpty){
        speciality = listaEspecialidades
            .firstWhere((element) => element.nombre == especialidadSeleccionada)
            .id;
      }
      List<String> urlImages = List.empty(growable: true);
      if(imagenes.isNotEmpty){
        List<File> tmpImg = imagenes.map((e) => File(e!.path)).toList();
        for (var indexFile in tmpImg) {
         
          String url = await altaTrabajadorService.crearRutaImagenes(indexFile);
          urlImages.add(url);
        }
      }

      WorkerData worker = WorkerData.success(
          workerId: id!,
          specialityId: speciality,
          jobId: jobId,
          companyName: compania.modeloCampo.defaultController.text,
          startDate: fechaInicioController.text,
          jobAlias: alias.modeloCampo.defaultController.text,
          location: location.modeloCampo.defaultController.text,
          resume: resumen.modeloCampo.defaultController.text);

      int response = await altaTrabajadorService.altaUsuario(worker);

      if(urlImages.isNotEmpty && response != 0){
        for (String element in urlImages) {
           await altaTrabajadorService.relacionerWorkerEvidenceConWorkerExperience(element, response.toString());
        } 
      }

      if (context.mounted && 
        response != 0
          ) {
            popAvailable = true;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Su perfil de trabajador se ha completado satisfactoriamente.")));
      }
    }
    showLoading = false;
    setState(() {
      popAvailable;
      showLoading;
    });
  }

  Future<DateTime?> _selectDateInicio(BuildContext context) async {
    DateTime ?tmpFecha = (await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime.now().subtract(const Duration(days: 29200)),
      currentDate: fechaInicio ?? DateTime.now(),
      helpText: "Fecha de inicio",
      confirmText: "Aceptar",
      cancelText: "Cancelar",
      lastDate: DateTime.now(),
    ));
    return tmpFecha;
  }

  String? validateText(String? param, String campo) {
    if (param == null || param.isEmpty) {
      return 'El campo $campo es requerido';
    }
    return null;
  }

  Future<void> buildDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Desea abandonar el formulario?',
              style: StaticAttributesUtils.estiloTitulos()),
          content: Text(
            'Al dar clic en si, ningun dato modificado sera guardado',
            style: StaticAttributesUtils.estilosSimpleTexto(),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Si'),
              onPressed: () {
                popAvailable = true;
                setState(() {
                  popAvailable;
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

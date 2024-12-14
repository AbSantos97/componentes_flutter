import 'package:componentes_basicos/src/connections/http_request.dart';
import 'package:componentes_basicos/src/models/modelo_simple_campo_texto.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:componentes_basicos/src/widgets/simple_campo_texto.dart';
import 'package:flutter/material.dart';

class DatosGeneralesContratos extends StatefulWidget {
  const DatosGeneralesContratos({super.key});

  @override
  State<DatosGeneralesContratos> createState() => _DatosGeneralesContratosState();
}

class _DatosGeneralesContratosState extends State<DatosGeneralesContratos> {

   HttpRequest httpRequest = HttpRequest();
  SimpleCampoTexto trabajador = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeJustLecture("Trabajador", TextInputType.name, 25, true));
  SimpleCampoTexto empleador = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeJustLecture("Empleador", TextInputType.name, 25, true));
  SimpleCampoTexto precioEstimado = SimpleCampoTexto(ModeloSimpleCampoTexto.mensajeErrorPorDefecto("Precio estimado", TextInputType.number, 10, true));
  final _formKey = GlobalKey<FormState>();
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();
  DateTime fechaInicio = DateTime.now();
  DateTime fechaFin = DateTime.now();
  bool inicialize = false;
  bool popAvailable = false;

  @override
  Widget build(BuildContext context) {
    return dataBody();
  }

  Scaffold dataBody() {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    if(!inicialize){
      String month = fechaInicio.month <10?'0${fechaInicio.month}':fechaInicio.month.toString();
      String day = fechaInicio.day < 10?'0${fechaInicio.day}':fechaInicio.day.toString();
      fechaInicioController.text = '${fechaInicio.year}-$month-$day';
    }
    inicialize = true;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: ()async => buildDialog(context), icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.amber.shade400,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 40.0),
                child: Text('Crear contrato',style: StaticAttributesUtils.estilosSimpleTextoNegritas(22))),
              const SizedBox(height: 20.0),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      color: Colors.white,
                      width: width - 50,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                            margin: const EdgeInsets.only(top: 35.0,bottom: 5.0),
                            child: trabajador
                            ),
                            Container(
                            margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                            child: empleador
                            ),
                            Container(
                            margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                            child: precioEstimado
                            ),
                            Container(
                            margin: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                            child: TextFormField(
                              controller: fechaInicioController,
                              showCursor: false,
                              readOnly: true,
                              autocorrect: false,
                              validator: (value) => validateText(value, "Fecha de inicio"),
                              onTap: () async {
                                FocusScope.of(context).requestFocus(FocusNode());
                                DateTime fecha = await _selectDateInicio(context);
                                String month = fecha.month <10?'0${fecha.month}':fecha.month.toString();
                                String day = fecha.day < 10?'0${fecha.day}':fecha.day.toString();
                                fechaInicioController.text = '${fecha.year}-$month-$day';
                              },
                              keyboardType: null,
                              decoration: const InputDecoration(
                                labelText: "Fecha de inicio del servicio *",
                                border: OutlineInputBorder()
                              ),
                            )
                            ),

                            Container(
                            margin: const EdgeInsets.only(top: 15.0,bottom: 10.0),
                            child: TextFormField(
                              controller: fechaFinController,
                              showCursor: false,
                              readOnly: true,
                              autocorrect: false,
                              validator: (value) => validateText(value, "Fecha fin"),
                              onTap: () async {
                                FocusScope.of(context).requestFocus(FocusNode());
                                DateTime fecha = await _selectDateFin(context);
                                String month = fecha.month <10?'0${fecha.month}':fecha.month.toString();
                                String day = fecha.day < 10?'0${fecha.day}':fecha.day.toString();
                                fechaFinController.text = '${fecha.year}-$month-$day';
                                                             
                              },
                              keyboardType: null,
                              decoration: const InputDecoration(
                                labelText: "Fecha fin aproximada del servicio *",
                                border: OutlineInputBorder()
                              ),
                            )
                            ),

                            OutlinedButton(
                              style: StaticAttributesUtils.estiloOutlineButton(45),
                              onPressed: callSaveFunction, 
                              child: Text("Generar contrato",style: StaticAttributesUtils.estilosSimpleTextoColorAlternativo())
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  void callSaveFunction() async {
    if (_formKey.currentState!.validate()) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: const Text("TODO OK")));
      }
    }
  }

  Future<DateTime> _selectDateInicio(BuildContext context) async{
    fechaInicio = (await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime.now(),
      currentDate: fechaInicio,
      helpText: "Fecha de inicio",
      confirmText: "Aceptar",
      cancelText: "Cancelar",
      lastDate: DateTime.now().add(const Duration(days: 89)), 
    ))!;
    return fechaInicio;
  }

  Future<DateTime> _selectDateFin(BuildContext context) async{
    fechaFin = (await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      currentDate: fechaFin,
      helpText: "Fecha fin",
      confirmText: "Aceptar",
      cancelText: "Cancelar",
      lastDate: DateTime.now().add(const Duration(days: 90)), 
    ))!;
    return fechaFin;
  }

    String? validateText(String ?param , String campo){
    if(param == null || param.isEmpty){
      return 'El campo $campo es requerido';
    }
    return null;
  }

  Future<void> buildDialog(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Desea abandonar el formulario?',style: StaticAttributesUtils.estiloTitulos()),
          content: Text(
            'Al dar clic en si, ningun dato modificado sera guardado', style: StaticAttributesUtils.estilosSimpleTexto(),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
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
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
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
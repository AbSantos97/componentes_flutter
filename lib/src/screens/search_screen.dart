import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DateTime fechaSeleccionada = DateTime.now();
  @override
  Widget build(BuildContext context) {
  ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    shadowColor: Colors.black87,
    backgroundColor: Colors.blue,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(50)),
  ),
);

    return  SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () { },
            child: Text('TextButton',style: StaticAttributesUtils.estilosSimpleTexto()),
          ),

          ElevatedButton(
            style: raisedButtonStyle,
            onPressed: () { },
            child: Text('ElevatedButton',style: StaticAttributesUtils.estilosSimpleTexto()),
          ),
          
          OutlinedButton(
            onPressed: () {
              debugPrint('Received click');
            },
            child: Text('OutlinedButton',style: StaticAttributesUtils.estilosSimpleTexto(),),
          ),
          //Opcion que se podra utilizar para las opciones del filtro
          Chip(
            elevation: 10.0,
            backgroundColor: Colors.amber.shade400,
            deleteButtonTooltipMessage: "Eliminar filtro",
            deleteIcon: const Icon(Icons.highlight_remove_sharp),
            label: const Text("Chip"),
            deleteIconColor: Colors.black,
            onDeleted: () {
              
            },
            labelStyle:  StaticAttributesUtils.estilosSimpleTexto(),
            ),

          OutlinedButton(
            onPressed: () => _dialogBuilder(context),
            child: Text('Alerta',style: StaticAttributesUtils.estilosSimpleTexto(),),
          ),

          OutlinedButton(
            onPressed: () => _selectDate(context),
            child: Text('Fecha',style: StaticAttributesUtils.estilosSimpleTexto(),),
          ),
          Text(fechaSeleccionada.toString(),style: StaticAttributesUtils.estilosSimpleTexto(),),
        ],
        ),
    );
  }

  _selectDate(BuildContext context) async{
    print(fechaSeleccionada.toString());
  fechaSeleccionada = (await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      currentDate: fechaSeleccionada,
      helpText: "Selecciona la fecha de inicio",
      confirmText: "Aceptar",
      cancelText: "Cancelar",
      lastDate: DateTime.now().add(const Duration(days: 30)), 
      selectableDayPredicate: _decideWhichDayToEnable,
    ))!;
    setState(() {
      fechaSeleccionada;
    });
  }

   Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Basic dialog title',style: StaticAttributesUtils.estiloTitulos()),
          content: Text(
            'A dialog is a type of modal window that'
            'appears in front of app content to'
            'provide critical information, or prompt'
            'for a decision to be made.', style: StaticAttributesUtils.estilosSimpleTexto(),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool _decideWhichDayToEnable(DateTime day) {
    print(day.isAfter(DateTime.now().subtract(Duration(days: 30))));
    return (day.isAfter(DateTime.now().subtract(Duration(days: 30))));

    
  }
}
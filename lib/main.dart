import 'package:componentes_basicos/src/design/WidgetStatePropertyDatePicker.dart';
import 'package:componentes_basicos/src/design/WidgetStatePropertyOutlineBorderDatePicker.dart';
import 'package:componentes_basicos/src/screens/codigo_verificacion.dart';
import 'package:componentes_basicos/src/screens/conversacion_screen.dart';
import 'package:componentes_basicos/src/screens/counter_screen.dart';
import 'package:componentes_basicos/src/screens/crear_cuenta_inicial.dart';
import 'package:componentes_basicos/src/screens/datos_generales_contratos.dart';
import 'package:componentes_basicos/src/screens/detalles_contrato.dart';
import 'package:componentes_basicos/src/screens/editar_datos_profile_client.dart';
import 'package:componentes_basicos/src/screens/formulario_trabajador.dart';
import 'package:componentes_basicos/src/screens/http_request_widget.dart';
import 'package:componentes_basicos/src/screens/information_service.dart';
import 'package:componentes_basicos/src/screens/lista_contratos_widget.dart';
import 'package:componentes_basicos/src/screens/login_component.dart';
import 'package:componentes_basicos/src/screens/profile_view.dart';
import 'package:componentes_basicos/src/screens/search_screen.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]) .then((_) { runApp(const MyApp()); });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: "/login",
      routes: {
        '/':(context) => const CounterScreen(),
        '/detalles_servicio_usuario': (context) => const InformationService(),
        '/login': (context) => const LoginScreen(),
        '/pagina_busqueda': (context) => const SearchScreen(),
        '/conversacion': (context) => const ConversacionScreen(),
        '/http': (context) => const HttpRequestWidget(),
        '/crear_cuenta': (context) => const CrearCuentaUsuarioComun(),
        '/info_profile': (context) => const ProfileViewUser(),
        '/edit_client_profile': (context) => const EditarDatosProfileClient(),
        '/form_contrato': (context) => const DatosGeneralesContratos(),
        '/formulario_trabajador': (context) => const FormularioTrabajador(),
        '/verificar_codigo_creacion': (context) => const CodigoVerificacionScreen(),
        '/lista_contratos': (context) => const ListaContratosWidget(),
        '/detalles_contratos': (context) => const DetallesContratos()
      },
      supportedLocales: const [
         Locale('es'),
         Locale('en')
      ],
      debugShowCheckedModeBanner: false,    
      theme: ThemeData(
        useMaterial3: true,
            primaryColor: Colors.green,
           
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.amber.shade400,
          seedColor: Colors.amber.shade400,
          ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.amber.shade400,centerTitle: true),
               
        tabBarTheme: TabBarTheme(  
        labelColor: Colors.pink[800],
        labelStyle: TextStyle(color: Colors.pink[800]), // color for text
         indicator:  BoxDecoration(
          color:   Colors.white,
          border: Border.all(width: 1),
          shape: BoxShape.circle,
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.amber.shade400)
        )
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.white,
        headerHeadlineStyle: StaticAttributesUtils.estiloTitulosDatePicker(),
        headerBackgroundColor: Colors.amber.shade400,
        dividerColor: Colors.black,
        headerHelpStyle:  StaticAttributesUtils.estiloTitulosDatePicker(),
        dayForegroundColor: Widgetstatepropertydatepicker(0),
        dayOverlayColor: Widgetstatepropertydatepicker(0),
        weekdayStyle: StaticAttributesUtils.estilosSimpleTexto(),
        yearStyle: StaticAttributesUtils.estilosSimpleTexto(),
        dayStyle: StaticAttributesUtils.estilosSimpleTexto(),
        todayForegroundColor: Widgetstatepropertydatepicker(0),
        dayBackgroundColor: Widgetstatepropertyoutlineborderdatepicker(0),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: StaticAttributesUtils.estilosSimpleTexto()),
        surfaceTintColor: Colors.white,
        locale: const Locale("es","MX"), 
        headerForegroundColor: Colors.black),
      ),
    );
  }
}
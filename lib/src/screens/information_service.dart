import 'package:carousel_slider/carousel_slider.dart';
import 'package:componentes_basicos/src/connections/http_request.dart';
import 'package:componentes_basicos/src/models/experiencia_trabajador.dart';
import 'package:componentes_basicos/src/models/opiniones_servicios.dart';
import 'package:componentes_basicos/src/models/worker_evidence.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:componentes_basicos/src/widgets/loading_simple_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class InformationService extends StatefulWidget {
  
  const InformationService({super.key});

  @override
  State<InformationService> createState() => _InformationServiceState();
}

class _InformationServiceState extends State<InformationService> {
  HttpRequest httpRequest = HttpRequest();
  List<OpinionesServicios> opiniones = List.empty(growable: true);
  
  @override
  void initState() {
    opiniones.add(OpinionesServicios("Excelente servicio", 4.5, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a est lacinia, malesuada leo non, fermentum erat. Nunc eleifend, purus ac vulputate auctor, turpis ipsum viverra nunc, ac sollicitudin tellus nibh eu risus. Donec id hendrerit purus, sed euismod arcu. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."));
    opiniones.add(OpinionesServicios("Trabajo de calidad", 4, "Proin a massa dolor. Integer non ipsum lacus. Sed congue, nisi eget tristique viverra, neque ligula tincidunt mauris, ac euismod dui sapien sed est. "));
    opiniones.add(OpinionesServicios("Regular", 2.5,"Donec sit amet fermentum eros, non porttitor orci. Mauris consequat nulla et aliquet pellentesque. Vivamus vitae porta justo. " ));
    opiniones.add(OpinionesServicios("Buen trabajo!!", 5.0, "Maecenas lobortis, tellus eu fringilla mollis, risus metus dictum dui, et fringilla nunc est nec urna. Etiam varius magna non diam feugiat, et faucibus urna vestibulum."));
    opiniones.add(OpinionesServicios("Pesimo trabajo", 1.5,"Sed sit amet nibh magna. Donec tempus lacus non nisi fermentum, eget semper odio rhoncus. Nullam ultrices bibendum ipsum ac vulputate. Sed viverra tincidunt mollis. " ));
    opiniones.add(OpinionesServicios("Satisfecho", 3.0, "Maecenas lobortis, tellus eu fringilla mollis, risus metus dictum dui, et fringilla nunc est nec urna. Etiam varius magna non diam feugiat, et faucibus urna vestibulum."));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

     int id = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.amber.shade400,
      centerTitle: true,
      title: const Text('ConectaLabores', textAlign: TextAlign.end, style: TextStyle(color: Colors.black87),),
      ),
      body: FutureBuilder(future: httpRequest.obtenerResumenTrabajador(id), builder: buildFutureComponent)
    );
  }

  Widget buildFutureComponent(BuildContext buildContext, AsyncSnapshot<ExperienciaTrabajador> snapshot){
    if(snapshot.hasData){
      return bodyView(snapshot.data);
    }
    if(snapshot.hasError){
      return const Center(
        child: Text("Error"),
      );
    }
    return const LoadingSimplePage();
  }

  Container bodyView(ExperienciaTrabajador? usuario) {
    return Container(
      margin: const EdgeInsets.fromLTRB(17.0, 10.0, 17.0, 10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(items: usuario!.workerEvidences.map((item) => _crearImagenCarrusel(item)).toList(),
             options: CarouselOptions(
              initialPage: usuario.workerEvidences.length,
              viewportFraction: 0.90,
              padEnds: true,
              height: 300.0,
              reverse: true,
              enableInfiniteScroll: false
            ),
            ),
            Text("${usuario.nombre} - ${usuario.especialidad}",style: StaticAttributesUtils.estiloTitulos()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
              _crearBotonIniciarContacto(),
              _crearRankingCalificacion(usuario.calificacion),
            ]
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Colors.black,height: 4),
                Text("Resumen del trajador",style: StaticAttributesUtils.estiloTitulos(),),
                const SizedBox(height: 7.0),
                Text(usuario.resumen,
                  style:  StaticAttributesUtils.estilosSimpleTexto(),
                  textAlign: TextAlign.justify,),
                const Divider(color: Colors.black,height: 4),
                Text("Listado de especialidades",style: StaticAttributesUtils.estiloTitulos(),),
                const SizedBox(height: 7.0),
                _listadoTrabajos(),
                const Divider(color: Colors.black,height: 4),
                  Text("Comentario y reseñas",style: StaticAttributesUtils.estiloTitulos(),),
                  const SizedBox(height: 7.0,),
                for(var i in opiniones)
                _listadoComentariosYResenas(i)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _listadoComentariosYResenas(OpinionesServicios opinion){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(opinion.tituloOpinion,style: StaticAttributesUtils.estiloTitulos(),),
          _crearRankingCalificacion(opinion.calificacion),
          Text(opinion.opinion,style: StaticAttributesUtils.estilosSimpleTexto(),),
          const SizedBox(height: 20.0)
      ],    
    );
  }



  Widget _listadoTrabajos(){
    List<String> especialidades = List.empty(growable: true);
    especialidades.add("Diagnosticos");
    especialidades.add("Inyecciones");
    especialidades.add("Chequeos");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         for(var i in especialidades)
            Text("•$i")
      ],
    );
    
  }

  Widget _crearBotonIniciarContacto(){
    ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      shadowColor: Colors.black87,
      backgroundColor: Colors.grey.shade200,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
    return OutlinedButton(
      style: raisedButtonStyle,
      onPressed: () => Navigator.pushNamed(context,"/conversacion"),
      child: Text('Iniciar contacto.',style: StaticAttributesUtils.estilosSimpleTexto()),
    );
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

  void _onRatingUpdate(double rating){

}

  Widget _crearImagenCarrusel(WorkerEvidence busqueda){
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(borderRadius: BorderRadius.circular(8.0),
      child: Image.network(busqueda.url,width: width,fit:BoxFit.fill)),
    );
  }
}
import 'package:componentes_basicos/src/models/top_busquedas.dart';
import 'package:componentes_basicos/src/models/usuarios_ultima_busqueda.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen>{
  List<TopBusquedas> busquedas = List.empty(growable: true);
  List<UsuariosUltimaBusqueda> ultimaBusqueda = List.empty(growable: true);
  //final _storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true ));
  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    busquedas.add(TopBusquedas("Carpintero", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo3DmCjzo1WHhXzUMblPsP9zZIMAxmvzF6Iw&s"));
    busquedas.add(TopBusquedas("Programador", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSohxFzkTL45WgEzY_fQbegSt2NPDwXfJeq6Q&s"));
    busquedas.add(TopBusquedas("Veterinario", "https://static.vecteezy.com/system/resources/previews/005/520/216/non_2x/cartoon-drawing-of-a-veterinarian-vector.jpg"));
    busquedas.add(TopBusquedas("Carpintero", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo3DmCjzo1WHhXzUMblPsP9zZIMAxmvzF6Iw&s"));
    busquedas.add(TopBusquedas("Veterinario", "https://static.vecteezy.com/system/resources/previews/005/520/216/non_2x/cartoon-drawing-of-a-veterinarian-vector.jpg"));
    busquedas.add(TopBusquedas("Programador", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSohxFzkTL45WgEzY_fQbegSt2NPDwXfJeq6Q&s"));
    busquedas.add(TopBusquedas("Carpintero", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo3DmCjzo1WHhXzUMblPsP9zZIMAxmvzF6Iw&s"));
    busquedas.add(TopBusquedas("Veterinario", "https://static.vecteezy.com/system/resources/previews/005/520/216/non_2x/cartoon-drawing-of-a-veterinarian-vector.jpg"));
    busquedas.add(TopBusquedas("Programador", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSohxFzkTL45WgEzY_fQbegSt2NPDwXfJeq6Q&s"));
    busquedas.add(TopBusquedas("Carpintero", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo3DmCjzo1WHhXzUMblPsP9zZIMAxmvzF6Iw&s"));
    busquedas.add(TopBusquedas("Programador", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSohxFzkTL45WgEzY_fQbegSt2NPDwXfJeq6Q&s"));
    busquedas.add(TopBusquedas("Veterinario", "https://static.vecteezy.com/system/resources/previews/005/520/216/non_2x/cartoon-drawing-of-a-veterinarian-vector.jpg"));
    busquedas.add(TopBusquedas("Carpintero", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo3DmCjzo1WHhXzUMblPsP9zZIMAxmvzF6Iw&s"));
    busquedas.add(TopBusquedas("Veterinario", "https://static.vecteezy.com/system/resources/previews/005/520/216/non_2x/cartoon-drawing-of-a-veterinarian-vector.jpg"));
    busquedas.add(TopBusquedas("Programador", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSohxFzkTL45WgEzY_fQbegSt2NPDwXfJeq6Q&s"));
    busquedas.add(TopBusquedas("Carpintero", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo3DmCjzo1WHhXzUMblPsP9zZIMAxmvzF6Iw&s"));
    busquedas.add(TopBusquedas("Veterinario", "https://static.vecteezy.com/system/resources/previews/005/520/216/non_2x/cartoon-drawing-of-a-veterinarian-vector.jpg"));
    busquedas.add(TopBusquedas("Programador", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSohxFzkTL45WgEzY_fQbegSt2NPDwXfJeq6Q&s"));
    busquedas.add(TopBusquedas("Carpintero", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo3DmCjzo1WHhXzUMblPsP9zZIMAxmvzF6Iw&s"));
    busquedas.add(TopBusquedas("Veterinario", "https://static.vecteezy.com/system/resources/previews/005/520/216/non_2x/cartoon-drawing-of-a-veterinarian-vector.jpg"));
    busquedas.add(TopBusquedas("Programador", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSohxFzkTL45WgEzY_fQbegSt2NPDwXfJeq6Q&s"));
    
    ultimaBusqueda.add(UsuariosUltimaBusqueda("Abraham Olvera Santos", "Programador", 4.3, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Doctor"));
    ultimaBusqueda.add(UsuariosUltimaBusqueda("Eduardo Soriano Lopez", "Programador", 4.5, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Maestro"));
    ultimaBusqueda.add(UsuariosUltimaBusqueda("Roberto Garcia Martinez", "Programador", 4.0, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Fontanero"));
    ultimaBusqueda.add(UsuariosUltimaBusqueda("Jose Angel Gonzalez Terron", "Programador", 5.0, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Fotografo"));
    ultimaBusqueda.add(UsuariosUltimaBusqueda("Margarita de Jesus Vela Cruz", "Programador", 4.3, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Pintor"));
    ultimaBusqueda.add(UsuariosUltimaBusqueda("Karen de Soriano ", "Programador", 4.5, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Arquitecto"));
    ultimaBusqueda.add(UsuariosUltimaBusqueda("Guadalupe Janet Romero Garcia", "Programador", 4.0, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Repartidor"));
    ultimaBusqueda.add(UsuariosUltimaBusqueda("Daniel Guadalupe Romero Sainz", "Programador", 5.0, "https://cdn-icons-png.flaticon.com/512/3135/3135768.png","Contratista"));
    

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Servicios más buscados: ",
            textAlign: TextAlign.left,
            style: StaticAttributesUtils.estiloTitulos(),
            ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: crearGrid(),
          ),
           Container(
            margin: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
             child: Divider(
                height: 4,
                color: Colors.grey.shade300,
              ),
           ),
            crearRowUltimaBusqueda(),
            Container(
            margin: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
             child: Divider(
                height: 4,
                color: Colors.grey.shade300,
              ),
           ),
           crearListViewUltimasContrataciones(),
           const Divider(),
        ],
        ),
      ),
    );
}


Widget crearRowUltimaBusqueda(){
  return  Card(
    elevation: 2.0,
    margin: const EdgeInsets.all(7.0),
    color: Colors.grey.shade100,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
          child: Text("Inspirado en lo ultimo que buscaste: ",
          textAlign: TextAlign.left,
          style: StaticAttributesUtils.estiloTitulos(),
          ),
        ),
       
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for(var i in ultimaBusqueda)
                  crearCardUltimaBusquedasUsuarios(i)
              ],
            ),
          ),

      ],
      ),
  );
}

Widget crearCardUltimaBusquedasUsuarios(UsuariosUltimaBusqueda usuarioActual){
  final Size size = MediaQuery.sizeOf(context);
  final double width = size.width;
  final double height = size.height;

  return  SizedBox(
    width: 250.0,
    child: GestureDetector(
      onTap: () async { 
        //String? token = await _storage.read(key: "token");
        Navigator.pushNamed(context, '/detalles_servicio_usuario',arguments: usuarioActual);
        },
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.all(7.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(usuarioActual.nombre,style: StaticAttributesUtils.estilosSimpleTexto(),maxLines: 1,overflow: TextOverflow.ellipsis),
            Image.network(usuarioActual.imagen,width: width/5,height:(height/8)),
            Text(usuarioActual.especialidad,style: StaticAttributesUtils.estilosSimpleTexto()),
            ratingBarFunction(usuarioActual)
          ],
        ),
      ),
    ),
  );
}

RatingBar ratingBarFunction(UsuariosUltimaBusqueda usuarioActual) {
  return RatingBar(ratingWidget: RatingWidget(
        full: const Icon(Icons.star_outlined,
        color: Colors.amber), 
        half: const Icon(
          Icons.star_half_outlined,
          color: Colors.amber
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
         initialRating: usuarioActual.calificacion,
         );
}

void _onRatingUpdate(double rating){

}
 
Widget crearGrid(){
  final Size size = MediaQuery.sizeOf(context);
  final double width = size.width;
  final double height = size.height;
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for(TopBusquedas i in busquedas)
          cardTopService(width, height,i),
      ],
  );
}

Widget cardTopService(double width, double height, TopBusquedas busqueda) {
  return SizedBox(
    width: 150.0,
    child: Card(
      color: Colors.white,
      margin: const EdgeInsets.all(7.0),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
                      children: [
                        Image.network(busqueda.urlImagen,width: width/5,height:(height/8)),
                        Text(busqueda.nombre,style: StaticAttributesUtils.estilosSimpleTexto(),
                        maxLines: 1,overflow: TextOverflow.ellipsis,)
                      ],
            ),
      ),
    ),
  );
}

  Widget crearListViewUltimasContrataciones() {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    return Card(
        elevation: 2.0,
        margin: const EdgeInsets.all(7.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0, 5.0),
              child: Text("Ultimos servicios contratados",style: StaticAttributesUtils.estiloTitulos()),
            ),
            const Divider(),
            Column(
              children: [
                for(var index in ultimaBusqueda)
                  columnLastCard(index, width, height)
            ]
          )
          ] ,
        )
    );
  }

  Widget columnLastCard(UsuariosUltimaBusqueda index,double width,double height) {
    return Card(

      color: Colors.white,
      elevation: 2.0,
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
                ratingBarFunction(index),
              ],
            ),
          )
        ],
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;


}
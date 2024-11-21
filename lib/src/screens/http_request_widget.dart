import 'package:componentes_basicos/src/connections/http_request.dart';
import 'package:componentes_basicos/src/models/album.dart';
import 'package:flutter/material.dart';

class HttpRequestWidget extends StatefulWidget {
  const HttpRequestWidget({super.key});

  @override
  State<HttpRequestWidget> createState() => _HttpRequestWidgetState();
}

class _HttpRequestWidgetState extends State<HttpRequestWidget> {

  late Future<Album> futureAlbum;
  HttpRequest httpRequest = HttpRequest();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Album>(future: delayFuture(), builder: (context, snapshot){
          if(snapshot.hasData){
            return Text(snapshot.data!.title);
          }
          if(snapshot.hasError){
            return const Text("Salio un error");
          }
          return const CircularProgressIndicator();
        }),
      ),
    );
  }

  Future<Album> delayFuture() async {
    await Future.delayed(const Duration(seconds: 5));
    return httpRequest.fetchAlbum();
  }
}
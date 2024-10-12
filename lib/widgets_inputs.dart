import 'package:flutter/material.dart';

class HeaderWidgetCustom extends StatefulWidget {

  final String name;

  const HeaderWidgetCustom({super.key,required this.name});


  @override
  State<HeaderWidgetCustom> createState() => HeaderWidgetCustomState();
}

class HeaderWidgetCustomState extends State<HeaderWidgetCustom> {

  String name = "";

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
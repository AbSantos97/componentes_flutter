import 'package:flutter/material.dart';

class Widgetstatepropertyoutlineborderdatepicker extends WidgetStateColor {
   
   Widgetstatepropertyoutlineborderdatepicker(super.defaultValue);

  @override
  Color resolve(Set<WidgetState> states) {
    
    if(states.contains(WidgetState.selected)){
      return Colors.amber.shade400;
    }
    return Colors.white;
  }
}
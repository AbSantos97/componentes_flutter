

import 'package:flutter/material.dart';

class Widgetstatepropertydatepicker extends WidgetStateColor  {
  
  Widgetstatepropertydatepicker(super.defaultValue);

  @override
  Color resolve(Set<WidgetState> states) {
    if(states.contains(WidgetState.disabled)){
      return Colors.grey;
    }
    return Colors.black;
  }
 
  
 

}


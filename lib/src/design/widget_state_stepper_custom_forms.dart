import 'package:flutter/material.dart';

class WidgetStateStepperCustomForms extends WidgetStateColor {
  
  WidgetStateStepperCustomForms(super.defaultValue);

  @override
  
  Color resolve(Set<WidgetState> states) {
    if(states.contains(WidgetState.error)){
      return Colors.red;
    }
    if(states.contains(WidgetState.selected)){
      return Colors.black;
    }
    return Colors.blue;
  }

  
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:practica4_tennis_mobil/src/views/dashboard.dart';
import 'package:practica4_tennis_mobil/src/views/splash-screen-web.dart';

Map<String, WidgetBuilder> getAplicacionesRouter(){

  return <String, WidgetBuilder>{
    '/'         :  (BuildContext context) => SplachScreenWeb(),
    // 'dashboard' : ( BuildContext context ) => DashBoard( )
    
  };
  
}

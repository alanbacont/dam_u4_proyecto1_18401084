import 'package:dam_u4_proyecto1_18401084/paginas/bitacoras.dart';
import 'package:dam_u4_proyecto1_18401084/paginas/consulta1.dart';
import 'package:dam_u4_proyecto1_18401084/paginas/consulta2.dart';
import 'package:dam_u4_proyecto1_18401084/paginas/insertar_vehiculo.dart';
import 'package:dam_u4_proyecto1_18401084/paginas/update.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'paginas/home.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coche Tec',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              )
          )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => PaginaPrincipal(),
        '/add': (context) => InsertarVehiculo(),
        '/update': (context) => ActualizarVehiculo(),
        '/searchByDate': (context) => BusquedaPorFechaScreen(),
        '/searchByPlate': (context) => BusquedaPorPlacaScreen(),
      },
    );
  }
}

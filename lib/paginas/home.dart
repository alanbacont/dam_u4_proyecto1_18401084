import 'package:dam_u4_proyecto1_18401084/paginas/vehiculos.dart';
import 'package:flutter/material.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("cocheTec"),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: PaginaVehiculos(),
    );
  }
}

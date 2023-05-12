import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class ActualizarVehiculo extends StatefulWidget {
  const ActualizarVehiculo({Key? key}) : super(key: key);

  @override
  State<ActualizarVehiculo> createState() => _ActualizarVehiculoState();
}

class _ActualizarVehiculoState extends State<ActualizarVehiculo> {
  TextEditingController  dptocontroller = TextEditingController(text: "");
  TextEditingController  combustiblecontroller = TextEditingController(text: "");
  TextEditingController  nseriecontroller = TextEditingController(text: "");
  TextEditingController  placacontroller = TextEditingController(text: "");
  TextEditingController  resguardadocontroller = TextEditingController(text: "");
  TextEditingController  tanquecontroller = TextEditingController(text: "");
  TextEditingController  trabajadorcontroller = TextEditingController(text: "");

  String? selectedTipo;

  @override
  Widget build(BuildContext context) {


    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    if (arguments.isNotEmpty) {
      combustiblecontroller.text = arguments['combustible'] ?? '';
      dptocontroller.text = arguments['depto'] ?? '';
      nseriecontroller.text = arguments['numeroserie'] ?? '';
      placacontroller.text = arguments['placa'] ?? '';
      resguardadocontroller.text = arguments['resguardadopor'] ?? '';
      tanquecontroller.text = arguments['tanque'].toString() ?? '';
      trabajadorcontroller.text = arguments['trabajador'] ?? '';
    }

    String? tipo = arguments['tipo'];
    List<String> tiposVehiculo = ['Camion', 'Coche', 'Camioneta', 'Tractor', 'Motocicleta', 'Bicicleta'];

    if (!tiposVehiculo.contains(tipo)) {
      tipo = tiposVehiculo[0]; // establece a un valor por defecto
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Vehiculo'),
        elevation: 0,
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: combustiblecontroller,
              decoration: InputDecoration(
                labelText: 'Tipo de Combustible',
                prefixIcon: Icon(Icons.local_gas_station, color: Colors.indigo[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: dptocontroller,
              decoration: InputDecoration(
                labelText: 'Departamento',
                prefixIcon: Icon(Icons.work, color: Colors.indigo[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: nseriecontroller,
              decoration: InputDecoration(
                labelText: 'Numero de serie',
                prefixIcon: Icon(Icons.abc, color: Colors.indigo[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: placacontroller,
              decoration: InputDecoration(
                labelText: 'Placa',
                prefixIcon: Icon(Icons.abc_sharp, color: Colors.indigo[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: resguardadocontroller,
              decoration: InputDecoration(
                labelText: 'Resguardado por',
                prefixIcon: Icon(Icons.person_search, color: Colors.indigo[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: tanquecontroller,
              decoration: InputDecoration(
                labelText: 'Tanque',
                prefixIcon: Icon(Icons.car_crash, color: Colors.indigo[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10,),
            DropdownButtonFormField<String>(
              value: tipo,
              decoration: InputDecoration(
                labelText: "Tipo de Vehiculo",
                prefixIcon: Icon(Icons.car_repair, color: Colors.indigo[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              items: <String>['Camion', 'Coche', 'Camioneta',
                'Tractor', 'Motocicleta', 'Bicicleta'].map((String value){
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedTipo = newValue;
                });
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: trabajadorcontroller,
              decoration: InputDecoration(
                labelText: 'Nombre Trabajador',
                prefixIcon: Icon(Icons.person, color: Colors.indigo[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[400],
                textStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              onPressed: () async{
                await actualizarVehiculo(arguments['uid'], int.parse(tanquecontroller.text), combustiblecontroller.text,
                    dptocontroller.text, nseriecontroller.text, placacontroller.text,
                    resguardadocontroller.text, selectedTipo, trabajadorcontroller.text)
                    .then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text("Actualizar"),
            )
          ],
        ),
      ),
    );
  }
}

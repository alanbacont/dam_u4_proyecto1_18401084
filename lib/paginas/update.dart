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
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: combustiblecontroller,
              decoration: const InputDecoration(
                  icon: Icon(Icons.local_gas_station),
                  labelText: 'Tipo de Combustible'
              ),
            ),
            TextField(
              controller: dptocontroller,
              decoration: const InputDecoration(
                  icon: Icon(Icons.work),
                  labelText: 'Departamento'
              ),
            ),
            TextField(
              controller: nseriecontroller,
              decoration: const InputDecoration(
                  icon: Icon(Icons.abc),
                  labelText: 'Numero de serie'
              ),
            ),
            TextField(
              controller: placacontroller,
              decoration: const InputDecoration(
                  icon: Icon(Icons.abc_sharp),
                  labelText: 'Placa'
              ),
            ),
            TextField(
              controller: resguardadocontroller,
              decoration: const InputDecoration(
                  icon: Icon(Icons.person_search),
                  labelText: 'Resguardado por'
              ),
            ),
            TextField(
              controller: tanquecontroller,
              decoration: const InputDecoration(
                  icon: Icon(Icons.car_crash),
                  labelText: 'Tanque'
              ),
            ),
            SizedBox(height: 10,),
            DropdownButtonFormField<String>(
              value: tipo,
              decoration: InputDecoration(
                icon: Icon(Icons.car_repair),
                labelText: "Tipo de Vehiculo",
                border: OutlineInputBorder(),
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
            TextField(
              controller: trabajadorcontroller,
              decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Nombre Trabajador'
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () async{
              await actualizarVehiculo(arguments['uid'], int.parse(tanquecontroller.text), combustiblecontroller.text,
                  dptocontroller.text, nseriecontroller.text, placacontroller.text,
                  resguardadocontroller.text, selectedTipo, trabajadorcontroller.text)
                  .then((_) {
                Navigator.pop(context);
              });
            }, child: const Text("Actualizar"), )
          ],
        ),
      ),
    );
  }
}

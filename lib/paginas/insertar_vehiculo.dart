import 'package:dam_u4_proyecto1_18401084/services/firebase_service.dart';
import 'package:flutter/material.dart';

class InsertarVehiculo extends StatefulWidget {
  const InsertarVehiculo({Key? key}) : super(key: key);

  @override
  State<InsertarVehiculo> createState() => _InsertarVehiculoState();
}

class _InsertarVehiculoState extends State<InsertarVehiculo> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar Vehiculo'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: combustiblecontroller,
              decoration: InputDecoration(
                icon: Icon(Icons.local_gas_station, color: Colors.indigo[400]),
                labelText: 'Tipo de Combustible',
                labelStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: dptocontroller,
              decoration: InputDecoration(
                icon: Icon(Icons.business, color: Colors.indigo[400]),
                labelText: 'Departamento',
                labelStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: nseriecontroller,
              decoration: InputDecoration(
                icon: Icon(Icons.confirmation_num, color: Colors.indigo[400]),
                labelText: 'Numero de serie',
                labelStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: placacontroller,
              decoration: InputDecoration(
                icon: Icon(Icons.car_rental, color: Colors.indigo[400]),
                labelText: 'Placa',
                labelStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: resguardadocontroller,
              decoration: InputDecoration(
                icon: Icon(Icons.shield, color: Colors.indigo[400]),
                labelText: 'Resguardado por',
                labelStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: tanquecontroller,
              decoration: InputDecoration(
                icon: Icon(Icons.local_gas_station_rounded, color: Colors.indigo[400]),
                labelText: 'Tanque',
                labelStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            DropdownButtonFormField<String>(
              value: selectedTipo,
              decoration: InputDecoration(
                icon: Icon(Icons.car_repair, color: Colors.indigo[400]),
                labelText: "Tipo de Vehiculo",
                labelStyle: TextStyle(fontSize: 16),
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
              decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.indigo[400]),
                labelText: 'Nombre Trabajador',
                labelStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
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
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () async {
                await insertarVehiculo(
                  int.parse(tanquecontroller.text),
                  combustiblecontroller.text,
                  dptocontroller.text,
                  nseriecontroller.text,
                  placacontroller.text,
                  resguardadocontroller.text,
                  selectedTipo,
                  trabajadorcontroller.text,
                ).then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text("Insertar"),
            )
          ],
        ),
      ),
    );
  }
}

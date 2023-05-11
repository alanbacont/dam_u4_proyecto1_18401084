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
              value: selectedTipo,
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
            ElevatedButton(onPressed: () async{
              await insertarVehiculo(int.parse(tanquecontroller.text), combustiblecontroller.text,
                  dptocontroller.text, nseriecontroller.text, placacontroller.text,
                  resguardadocontroller.text, selectedTipo, trabajadorcontroller.text)
              .then((_) {
                Navigator.pop(context);
              });
            }, child: const Text("Insertar"))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class BusquedaPorDepartamentoScreen extends StatefulWidget {
  @override
  _BusquedaPorDepartamentoScreenState createState() =>
      _BusquedaPorDepartamentoScreenState();
}

class _BusquedaPorDepartamentoScreenState
    extends State<BusquedaPorDepartamentoScreen> {
  TextEditingController controller = TextEditingController();
  Future<List<Map<String, dynamic>>>? vehiculosFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buscar Vehículo por Departamento',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'SanFrancisco',
          ),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 350,
              height: 50,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Nombre del departamento',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text('Buscar'),
              onPressed: () {
                setState(() {
                  vehiculosFuture = getVehiculosPorDepartamento(controller.text)
                  as Future<List<Map<String, dynamic>>>?;
                });
              },
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: vehiculosFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Ha ocurrido un error'));
                  } else {
                    final vehiculos = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: vehiculos.length,
                      itemBuilder: (context, index) {
                        final vehiculo = vehiculos[index];
                        return ListTile(
                          title: Text('Placa: ${vehiculo['placa']}'),
                          subtitle: Text('Tipo: ${vehiculo['tipo']}'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

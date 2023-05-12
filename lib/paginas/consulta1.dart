import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class BusquedaPorPlacaScreen extends StatefulWidget {
  @override
  _BusquedaPorPlacaScreenState createState() => _BusquedaPorPlacaScreenState();
}

class _BusquedaPorPlacaScreenState extends State<BusquedaPorPlacaScreen> {
  TextEditingController controller = TextEditingController();
  Future<List<Map<String, dynamic>>>? bitacorasFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buscar bitácoras por placa',
          style: TextStyle(
            color: Colors.black,  // change the color of the title
            fontFamily: 'SanFrancisco', // change the font family
          ),
        ),
        backgroundColor: Colors.grey[200],  // change the background color
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Placa del vehículo',
              ),
            ),
            Padding(padding: EdgeInsets.all(20)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Borde redondeado
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Cambiar el padding
                textStyle: TextStyle(
                  fontSize: 18, // Cambiar el tamaño del texto
                  fontWeight: FontWeight.bold, // Cambiar la negrita
                ),
              ),
              child: Text('Buscar'),
              onPressed: () {
                setState(() {
                  bitacorasFuture = getBitacorasPorPlaca(controller.text);
                });
              },
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: bitacorasFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Ha ocurrido un error'));
                  } else {
                    final bitacoras = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: bitacoras.length,
                      itemBuilder: (context, index) {
                        final bitacora = bitacoras[index];
                        return ListTile(
                          title: Text('Evento: ${bitacora['evento']}'),
                          subtitle: Text('Fecha: ${bitacora['fecha']}'),
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


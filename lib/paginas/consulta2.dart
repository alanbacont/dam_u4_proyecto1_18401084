import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto1_18401084/services/firebase_service.dart';

class BusquedaPorFechaScreen extends StatefulWidget {
  @override
  _BusquedaPorFechaScreenState createState() => _BusquedaPorFechaScreenState();
}

class _BusquedaPorFechaScreenState extends State<BusquedaPorFechaScreen> {
  DateTime selectedDate = DateTime.now();
  Future<List<Map<String, dynamic>>>? bitacorasFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar bitácoras por fecha',
          style: TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.grey[200],
      elevation: 0,
        ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Fecha seleccionada: ${selectedDate.toLocal()}'),
              trailing: const Icon(Icons.keyboard_arrow_down),
              onTap: _selectDate,
            ),
            Padding(padding: EdgeInsets.all(8)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text('Buscar'),
              onPressed: () {
                setState(() {
                  bitacorasFuture = getBitacorasPorFecha(selectedDate) as Future<List<Map<String, dynamic>>>?;
                });
              },
            ),
            Padding(padding: EdgeInsets.all(20)),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: bitacorasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('Sin Datos');
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Evento: ${snapshot.data![index]['evento']}'),
                        //subtitle: Text('Fecha: ${snapshot.data![index]['fecha']}'),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _selectDate() async {
    final DateTime? seleccion = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2025),
    );
    if (seleccion != null && seleccion != selectedDate)
      setState(() {
        selectedDate = seleccion;
      });
  }
}

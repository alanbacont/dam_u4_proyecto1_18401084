import 'package:dam_u4_proyecto1_18401084/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InsertarBitacora extends StatefulWidget {
  final String vehiculoId;

  const InsertarBitacora({Key? key, required this.vehiculoId}) : super(key: key);

  @override
  State<InsertarBitacora> createState() => _InsertarBitacoraState();
}

class _InsertarBitacoraState extends State<InsertarBitacora> {
  TextEditingController  eventocontroller = TextEditingController(text: "");
  TextEditingController  recursoscontroller = TextEditingController(text: "");
  TextEditingController  verificocontroller = TextEditingController(text: "");

  DateTime selectedFecha = DateTime.now();
  DateTime selectedFechaVerificacion = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar Bitacora'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: eventocontroller,
              decoration: InputDecoration(
                icon: Icon(Icons.event, color: Colors.indigo[400]),
                labelText: 'Evento',
                labelStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: recursoscontroller,
              decoration: InputDecoration(
                icon: Icon(Icons.format_list_bulleted, color: Colors.indigo[400]),
                labelText: 'Recursos',
                labelStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: verificocontroller,
              decoration: InputDecoration(
                icon: Icon(Icons.verified_user, color: Colors.indigo[400]),
                labelText: 'Verificó',
                labelStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[400],
              ),
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedFecha,
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedFecha)
                  setState(() {
                    selectedFecha = picked;
                  });
              },
              child: Text('Seleccionar Fecha: ${DateFormat.yMd().format(selectedFecha)}'),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[400],
              ),
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedFechaVerificacion,
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedFechaVerificacion)
                  setState(() {
                    selectedFechaVerificacion = picked;
                  });
              },
              child: Text('Seleccionar Fecha de Verificación: ${DateFormat.yMd().format(selectedFechaVerificacion)}'),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[400],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () async{
                await insertarBitacora(widget.vehiculoId, {
                  "evento": eventocontroller.text,
                  "recursos": recursoscontroller.text,
                  "verifico": verificocontroller.text,
                  "fecha": selectedFecha,
                  "fechaverificacion": selectedFechaVerificacion,
                }).then((_) {
                  Navigator.pop(context);
                });
              },
              child: Text(
                "Insertar",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

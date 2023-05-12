import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto1_18401084/paginas/insertar_bitacora.dart';
import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class PaginaBitacoras extends StatefulWidget {
  final String vehiculoId;

  const PaginaBitacoras({Key? key, required this.vehiculoId}) : super(key: key);

  @override
  State<PaginaBitacoras> createState() => _PaginaBitacorasState();
}

class _PaginaBitacorasState extends State<PaginaBitacoras> {
  TextEditingController verificoController = TextEditingController();
  DateTime fechaverificacion = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String vehiculoId = widget.vehiculoId;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bitácora de uso Vehicular"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: FutureBuilder(
          future: getBitacoras(widget.vehiculoId),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print("Card seleccionada: ${snapshot.data?[index]['uid']}");
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(60),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextField(
                                  controller: verificoController,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.verified_user, color: Colors.indigo[400]),
                                    labelText: 'Verificó',
                                    labelStyle: TextStyle(fontSize: 18),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo[400],
                                  ),
                                  child: Text('Seleccionar fecha de verificación'),
                                  onPressed: () async {
                                    DateTime? selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: fechaverificacion,
                                      firstDate: DateTime(2018),
                                      lastDate: DateTime.now(),
                                    );
                                    if (selectedDate != null) {
                                      setState(() {
                                        fechaverificacion = selectedDate;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(height: 30,),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo[400],
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  ),
                                  child: Text('Actualizar Bitácora', style: TextStyle(fontSize: 18)),
                                  onPressed: () async {
                                    await actualizarBitacora(
                                      vehiculoId,
                                      snapshot.data?[index]['uid'],
                                      verificoController.text,
                                      fechaverificacion,
                                    );
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 8.0, // Agrega una sombra a la tarjeta
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)), // Agrega bordes redondeados
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Fecha: ${(snapshot.data?[index]['fecha'] as Timestamp)?.toDate().toString() ?? 'No disponible'}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo[400]),
                            ),
                            Divider(color: Colors.grey),
                            Text(
                              'Evento: ${snapshot.data?[index]['evento'] ?? 'No disponible'}',
                              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'Recursos: ${snapshot.data?[index]['recursos'] ?? 'No disponible'}',
                              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'Verificó: ${snapshot.data?[index]['verifico'] ?? 'No disponible'}',
                              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'Fecha Verificación: ${(snapshot.data?[index]['fechaverificacion'] as Timestamp).toDate().toString() ?? 'No disponible'}',
                              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => InsertarBitacora(vehiculoId: vehiculoId),
            ),
          );
          setState(() {});
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

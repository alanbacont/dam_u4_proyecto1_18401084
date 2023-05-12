import 'package:flutter/material.dart';

import '../services/firebase_service.dart';
import 'bitacoras.dart';

class PaginaVehiculos extends StatefulWidget {
  const PaginaVehiculos({Key? key}) : super(key: key);

  @override
  State<PaginaVehiculos> createState() => _PaginaVehiculosState();
}

class _PaginaVehiculosState extends State<PaginaVehiculos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vehículos ITTepic',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'SanFrancisco',
          ),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body:Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage('assets/images/ITTepic.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.05), BlendMode.dstATop)
                ),
              ),
            ),
        FutureBuilder(
          future: getVehiculos(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(30),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.directions_car, size: 50, color: Colors.black,),
                    title: Text('Placa: ${snapshot.data?[index]['placa'] ?? 'No disponible'}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Departamento: ${snapshot.data?[index]['depto'] ?? 'No disponible'}'),
                        Text('Trabajador: ${snapshot.data?[index]['trabajador'] ?? 'No disponible'}'),
                        Text('Tipo: ${snapshot.data?[index]['tipo'] ?? 'No disponible'}'),
                        Divider(color: Colors.grey),
                      ],
                    ),
                    isThreeLine: true,
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Vehículo: ${snapshot.data?[index]['placa']}'),
                            content: Text('¿Qué desea hacer?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Actualizar'),
                                onPressed: () async {
                                  await Navigator.pushNamed(context, '/update', arguments: {
                                    "combustible": snapshot.data?[index]['combustible'],
                                    "depto":snapshot.data?[index]['depto'],
                                    "numeroserie":snapshot.data?[index]['numeroserie'],
                                    "placa":snapshot.data?[index]['placa'],
                                    "resguardadopor":snapshot.data?[index]['resguardadopor'],
                                    "tanque":snapshot.data?[index]['tanque'],
                                    "tipo":snapshot.data?[index]['tipo'],
                                    "trabajador":snapshot.data?[index]['trabajador'],
                                    "uid":snapshot.data?[index]['uid'],
                                  });
                                  setState(() {const Center(
                                    child: CircularProgressIndicator(),
                                  );});
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Eliminar'),
                                onPressed: () async{
                                  await borrarVehiculo(snapshot.data?[index]['uid']);
                                  setState(() {const Center(
                                    child: CircularProgressIndicator(),
                                  );});
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Ver Bitácora de Uso'),
                                onPressed: () async{
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaginaBitacoras(vehiculoId: snapshot.data?[index]['uid'] ?? ''),
                                    ),
                                  );
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
    ]
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

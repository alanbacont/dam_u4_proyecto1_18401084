import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getVehiculos() async {
  List vehiculo = [];
  QuerySnapshot queryVehiculo = await db.collection('vehiculo').get();
  for(var doc in queryVehiculo.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final car = {
      "combustible": data['combustible'],
      "depto":data['depto'],
      "numeroserie":data['numeroserie'],
      "placa":data['placa'],
      "resguardadopor":data['resguardadopor'],
      "tanque":data['tanque'],
      "tipo":data['tipo'],
      "trabajador":data['trabajador'],
      "uid":doc.id,
    };
    vehiculo.add(car);
  }
  await Future.delayed(const Duration(seconds: 1));
  return vehiculo;
}

Future<void> insertarVehiculo(int tanque, String combustible, depto, numeroserie, placa, resguardadopor, tipo, trabajador) async{
  await db.collection("vehiculo").add({
    "combustible": combustible,
    "depto":depto,
    "numeroserie":numeroserie,
    "placa":placa,
    "resguardadopor":resguardadopor,
    "tanque":tanque,
    "tipo":tipo,
    "trabajador":trabajador
  });
}

Future<void> actualizarVehiculo(String uid, int newtanque, String newcombustible, newdepto,
    newnumeroserie, newplaca, newresguardadopor, newtipo, newtrabajador) async{
  await db.collection("vehiculo").doc(uid).set({
    "combustible": newcombustible,
    "depto":newdepto,
    "numeroserie":newnumeroserie,
    "placa":newplaca,
    "resguardadopor":newresguardadopor,
    "tanque":newtanque,
    "tipo":newtipo,
    "trabajador":newtrabajador});
}

Future<void> borrarVehiculo(String uid) async {
  await db.collection('vehiculo').doc(uid).delete();
}

Future<List> getBitacoras(String vehiculoId) async {
  List bitacora = [];
  QuerySnapshot queryBitacora = await db.collection('vehiculo').doc(vehiculoId).collection('bitacora').get();
  for(var doc in queryBitacora.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final bitacoraDoc = {
      "fecha": data['fecha'],
      "evento":data['evento'],
      "recursos":data['recursos'],
      "verifico":data['verifico'],
      "fechaverificacion":data['fechaverificacion'],
      "uid":doc.id,
    };
    bitacora.add(bitacoraDoc);
  }
  await Future.delayed(const Duration(seconds: 2));
  return bitacora;
}

Future<void> insertarBitacora(String vehiculoId, Map<String, dynamic> bitacoraData) async{
  await db.collection('vehiculo').doc(vehiculoId).collection('bitacora').add(bitacoraData);
}

Future<void> actualizarBitacora(String vehiculoId, String bitacoraId, String verifico, DateTime fechaverificacion) async {
  await db.collection('vehiculo').doc(vehiculoId).collection('bitacora').doc(bitacoraId).update({
    'verifico': verifico,
    'fechaverificacion': fechaverificacion,
  });
}

Future<List<Map<String, dynamic>>> getBitacorasPorFecha(DateTime fecha) async {
  List<Map<String, dynamic>> bitacorasPorFecha = [];
  QuerySnapshot vehiculosSnapshot = await FirebaseFirestore.instance.collection('vehiculo').get();

  for (var vehiculo in vehiculosSnapshot.docs) {
    QuerySnapshot bitacorasSnapshot = await vehiculo.reference.collection('bitacora').where('fecha', isEqualTo: Timestamp.fromDate(fecha)).get();
    for (var bitacora in bitacorasSnapshot.docs) {
      bitacorasPorFecha.add(bitacora.data() as Map<String, dynamic>);
    }
  }
  return bitacorasPorFecha;
}


Future<List<Map<String, dynamic>>> getBitacorasPorPlaca(String placa) async {
  List<Map<String, dynamic>> bitacoraPorPlaca = [];
  QuerySnapshot queryVehiculo = await db.collection('vehiculo').where('placa', isEqualTo: placa).get();
  if(queryVehiculo.docs.isNotEmpty){
    String vehiculoId = queryVehiculo.docs.first.id;
    QuerySnapshot queryBitacora = await db.collection('vehiculo').doc(vehiculoId).collection('bitacora').get();
    for(var doc in queryBitacora.docs){
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final bitacoraDoc = {
        "fecha": DateFormat('yyyy-MM-dd – kk:mm').format(data['fecha'].toDate()),
        "evento":data['evento'],
        "recursos":data['recursos'],
        "verifico":data['verifico'],
        "fechaverificacion":data['fechaverificacion'],
        "uid":doc.id,
      };
      bitacoraPorPlaca.add(bitacoraDoc);
    }
  }
  await Future.delayed(const Duration(seconds: 2));
  return bitacoraPorPlaca;
}

Future<List<Map<String, dynamic>>> getVehiculosPorDepartamento(String depto) async {
  List<Map<String, dynamic>> vehiculosPorDepartamento = [];
  QuerySnapshot queryVehiculo = await db.collection('vehiculo').where('depto', isEqualTo: depto).get();
  if(queryVehiculo.docs.isNotEmpty){
    for(var doc in queryVehiculo.docs){
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final vehiculoDoc = {
        "combustible": data['combustible'],
        "depto":data['depto'],
        "numeroserie":data['numeroserie'],
        "placa":data['placa'],
        "resguardadopor":data['resguardadopor'],
        "tanque":data['tanque'],
        "tipo":data['tipo'],
        "trabajador":data['trabajador'],
        "uid":doc.id,
      };
      vehiculosPorDepartamento.add(vehiculoDoc);
    }
  }
  await Future.delayed(const Duration(seconds: 2));
  return vehiculosPorDepartamento;
}

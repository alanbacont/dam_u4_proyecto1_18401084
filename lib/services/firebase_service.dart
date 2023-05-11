import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getVehiculos() async {
  List vehiculo = [];
  //CollectionReference collectionReferenceVehiculo = db.collection('vehiculo');
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
  await Future.delayed(const Duration(seconds: 2));
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
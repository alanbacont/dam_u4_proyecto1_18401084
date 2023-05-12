import 'package:dam_u4_proyecto1_18401084/paginas/consulta1.dart';
import 'package:dam_u4_proyecto1_18401084/paginas/consulta2.dart';
import 'package:dam_u4_proyecto1_18401084/paginas/vehiculos.dart';
import 'package:flutter/material.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PaginaVehiculos(),
    BusquedaPorFechaScreen(),
    BusquedaPorPlacaScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("cocheTec",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        leading: Container(
          width: 90, // Define el ancho de la imagen
          height: 90, // Define la altura de la imagen
          child: Image.asset('assets/images/Logo TecNM.png'),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 100, // Define el ancho de la imagen
              height: 100, // Define la altura de la imagen
              child: Image.asset('assets/images/ITTepic.png'),
            ),
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0 ?
            Icon(Icons.car_repair, size: 35) :
            Icon(Icons.car_repair, size: 20),
            label: 'Vehículos',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1 ?
            Icon(Icons.date_range, size: 35) :
            Icon(Icons.date_range, size: 20),
            label: 'Por fecha',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2 ?
            Icon(Icons.manage_search, size: 35) :
            Icon(Icons.manage_search, size: 20),
            label: 'Por placa',
          ),
        ],
        selectedItemColor: Colors.indigo[800],
        unselectedItemColor: Colors.grey,
        selectedFontSize: 16,
        unselectedFontSize: 12,
      ),
    );
  }
}


import 'package:dam_u4_proyecto1_18401084/paginas/buscar_por_depto.dart';
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
    BusquedaPorDepartamentoScreen(),
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
        toolbarHeight: 100,
        title: const Text("cocheTec",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 32
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              width: 90,
              height: 90,
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
            label: 'Bitacora Por fecha',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2 ?
            Icon(Icons.manage_search, size: 35) :
            Icon(Icons.manage_search, size: 20),
            label: 'Bitacora Por placa',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3 ?
            Icon(Icons.apartment, size: 35) :
            Icon(Icons.apartment, size: 20),
            label: 'Vehiculo por Depto.',
          )
        ],
        selectedItemColor: Colors.indigo[800],
        unselectedItemColor: Colors.grey,
        selectedFontSize: 16,
        unselectedFontSize: 12,
      ),
    );
  }
}


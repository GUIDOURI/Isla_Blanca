import 'package:flutter/material.dart';
import 'web_map_screen.dart'; // Pantalla de mapa
import 'inventory_screen.dart'; // Pantalla de inventario
import 'messages_alerts_screen.dart'; // Pantalla de mensajes y alertas
import 'informe_screen.dart'; // Pantalla del informe
import 'plan_routes_screen.dart'; // Pantalla de planificación de rutas

class MainInterface extends StatefulWidget {
  const MainInterface({Key? key}) : super(key: key);

  @override
  _MainInterfaceState createState() => _MainInterfaceState();
}

class _MainInterfaceState extends State<MainInterface> {
  Widget _currentScreen = Container(); // Pantalla actual dentro del contenedor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo.png'), // Fondo
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: Image.asset(
                          'assets/logo.png',
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildButton(
                              'SEGUIR VEHÍCULO',
                              onTap: () {
                                setState(() {
                                  _currentScreen = WebMapScreen();
                                });
                              },
                            ),
                            _buildDivider(),
                            _buildButton(
                              'REGISTRO DE\nINVENTARIO VEHICULAR',
                              onTap: () {
                                setState(() {
                                  _currentScreen = InventoryScreen();
                                });
                              },
                            ),
                            _buildDivider(),
                            _buildButton(
                              'PLANIFICAR RUTAS',
                              onTap: () {
                                setState(() {
                                  _currentScreen = PlanRoutesScreen();
                                });
                              },
                            ),
                            _buildDivider(),
                            _buildButton(
                              'MENSAJES Y ALERTAS',
                              onTap: () {
                                setState(() {
                                  _currentScreen = const MessagesAlertsScreen();
                                });
                              },
                            ),
                            _buildDivider(),
                            _buildButton('VER REGISTRO DE VENTAS'),
                            _buildDivider(),
                            _buildButton(
                              'INFORME',
                              onTap: () {
                                setState(() {
                                  _currentScreen = InformeScreen();
                                });
                              },
                            ),
                            _buildDivider(),
                            _buildButton(
                              'CERRAR SESIÓN',
                              isLogout: true,
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/login');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple.shade200,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: _currentScreen,
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentScreen = Container(); // Limpia la pantalla
                              });
                            },
                            child: Image.asset(
                              'assets/cerrar.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, {bool isLogout = false, VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          color: isLogout ? const Color(0xFF87CEEB) : Colors.transparent,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isLogout ? Colors.white : Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 2,
      color: Colors.black,
    );
  }
}

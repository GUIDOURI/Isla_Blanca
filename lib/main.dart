import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
<<<<<<< HEAD
import 'screens/menu_screen.dart'; // Menú principal
import 'screens/web_map_screen.dart'; // Pantalla de mapa
import 'screens/inventory_screen.dart'; // Pantalla de inventario
import 'screens/messages_alerts_screen.dart'; // Pantalla de mensajes y alertas
=======
import 'screens/menu_screen.dart';
import 'screens/web_map_screen.dart'; // Importa la nueva pantalla del mapa
import 'screens/inventory_screen.dart'; // Importa la pantalla de inventario
>>>>>>> 3e0880f43603d3daaf178209080407ee660af9c1

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isla Blanca App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
<<<<<<< HEAD
        '/menu': (context) => const MainInterface(), // Ruta al menú principal
        '/map': (context) => WebMapScreen(), // Ruta al mapa
        '/inventory': (context) => InventoryScreen(), // Ruta al inventario
        '/messages_alerts': (context) => const MessagesAlertsScreen(), // Ruta a mensajes y alertas
=======
        '/menu': (context) => MainInterface(),
        '/map': (context) => WebMapScreen(), // Nueva ruta para la pantalla del mapa
        '/inventory': (context) => InventoryScreen(), // Ruta para la pantalla de inventario
>>>>>>> 3e0880f43603d3daaf178209080407ee660af9c1
      },
    );
  }
}

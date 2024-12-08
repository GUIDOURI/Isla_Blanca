import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/menu_screen.dart'; // Menú principal
import 'screens/web_map_screen.dart'; // Pantalla de mapa
import 'screens/inventory_screen.dart'; // Pantalla de inventario
import 'screens/messages_alerts_screen.dart'; // Pantalla de mensajes y alertas

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
        '/menu': (context) => const MainInterface(), // Ruta al menú principal
        '/map': (context) => WebMapScreen(), // Ruta al mapa
        '/inventory': (context) => InventoryScreen(), // Ruta al inventario
        '/messages_alerts': (context) => const MessagesAlertsScreen(), // Ruta a mensajes y alertas
      },
    );
  }
}

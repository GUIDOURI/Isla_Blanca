import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/menu_screen.dart'; // Menú principal
import 'screens/web_map_screen.dart'; // Pantalla de mapa
import 'screens/inventory_screen.dart'; // Pantalla de inventario
import 'screens/messages_alerts_screen.dart'; // Pantalla de mensajes y alertas
import 'screens/driver_menu_screen.dart'; // Menú para el chofer
import 'screens/sales_screen.dart'; // Pantalla de ventas
import 'screens/route_screen.dart'; // Pantalla del camino a seguir
import 'screens/chat_screen.dart'; // Pantalla del chat
import 'screens/informe_screen.dart'; // Pantalla del informe

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
        '/driverMenu': (context) => const DriverMenuScreen(), // Ruta al menú del chofer
        '/sales': (context) => SalesScreen(), // Ruta a ventas del chofer
        '/route': (context) => RouteScreen(), // Ruta al camino a seguir
        '/chat': (context) => ChatScreen(), // Ruta al chat con administrador
        '/informe': (context) => InformeScreen(), // Ruta al informe
      },
    );
  }
}

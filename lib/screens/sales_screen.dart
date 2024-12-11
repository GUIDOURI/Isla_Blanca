import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  LocationData? currentLocation;
  Location location = Location();
  String? selectedProduct; // Producto seleccionado
  bool isPreSale = false; // Indica si es pre-venta

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Verificar si el servicio de ubicación está habilitado
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    // Verificar permisos de ubicación
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    // Obtener ubicación actual
    currentLocation = await location.getLocation();
    setState(() {});
  }

  void _registerSale() {
    if (selectedProduct == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor selecciona un producto')),
      );
      return;
    }

    // Registrar la venta
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Venta registrada: $selectedProduct en ubicación: ${currentLocation?.latitude}, ${currentLocation?.longitude}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Realizar Venta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              "Registrar Venta o Pre-venta",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Selección de tipo de venta
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tipo de venta:",
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: isPreSale,
                  onChanged: (value) {
                    setState(() {
                      isPreSale = value;
                    });
                  },
                ),
                Text(isPreSale ? "Pre-venta" : "Venta"),
              ],
            ),
            SizedBox(height: 20),

            // Selección de producto
            DropdownButtonFormField<String>(
              value: selectedProduct,
              hint: Text("Selecciona un producto"),
              items: [
                DropdownMenuItem(
                  value: "Agua embolsada",
                  child: Text("Agua embolsada"),
                ),
                DropdownMenuItem(
                  value: "Agua empaquetada",
                  child: Text("Agua empaquetada"),
                ),
                DropdownMenuItem(
                  value: "Agua embotellada",
                  child: Text("Agua embotellada"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedProduct = value;
                });
              },
              decoration: InputDecoration(
                labelText: "Producto",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Ubicación actual
            if (currentLocation == null)
              Center(child: CircularProgressIndicator())
            else
              Text(
                "Ubicación actual:\nLatitud: ${currentLocation!.latitude}, Longitud: ${currentLocation!.longitude}",
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),

            // Botón para registrar venta
            ElevatedButton(
              onPressed: _registerSale,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Registrar ${isPreSale ? "Pre-venta" : "Venta"}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

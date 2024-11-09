import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  int _bottledQuantity = 0;
  int _baggedQuantity = 0;

  void _updateQuantity(String label, int value) {
    setState(() {
      if (label == 'Embotellado') {
        _bottledQuantity = (_bottledQuantity + value).clamp(0, 999); // Limita entre 0 y 999
      } else if (label == 'Embolsado') {
        _baggedQuantity = (_baggedQuantity + value).clamp(0, 999);
      }
    });
  }

  void _setQuantity(String label, String value) {
    setState(() {
      int parsedValue = int.tryParse(value) ?? 0;
      parsedValue = parsedValue.clamp(0, 999); // Limita entre 0 y 999
      if (label == 'Embotellado') {
        _bottledQuantity = parsedValue;
      } else if (label == 'Embolsado') {
        _baggedQuantity = parsedValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SELECCIÓN DE VEHÍCULO',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            items: [
              DropdownMenuItem(value: 'Vehículo 1', child: Text('Vehículo 1')),
              DropdownMenuItem(value: 'Vehículo 2', child: Text('Vehículo 2')),
            ],
            onChanged: (value) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'PRODUCTO DE AGUA',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildProductCounter('Embotellado', _bottledQuantity),
          const SizedBox(height: 10),
          _buildProductCounter('Embolsado', _baggedQuantity),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Acción de registro
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                shadowColor: Colors.black54,
                elevation: 6.0,
              ),
              child: Text(
                'REGISTRAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCounter(String label, int quantity) {
    TextEditingController _controller = TextEditingController(text: quantity.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove, color: Colors.black, size: 24),
              onPressed: () {
                _updateQuantity(label, -1);
              },
            ),
            Container(
              width: 50,
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _setQuantity(label, value);
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.black, size: 24),
              onPressed: () {
                _updateQuantity(label, 1);
              },
            ),
          ],
        ),
      ],
    );
  }
}


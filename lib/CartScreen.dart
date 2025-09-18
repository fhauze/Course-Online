import 'package:flutter/material.dart';
import 'package:online_course/HomeScreen.dart';
import 'package:online_course/services/ApiService.dart';

class CartScreen extends StatefulWidget {
  // final Map<int, int> cart; // key = id/index produk, value = quantity

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Map<int, int> _cart;
  final tempCart = <int, int>{};

  @override
  void initState() {
    super.initState();
    _fetchCart();
  }

  void _fetchCart() async {
    final cartcollections = await ApiService.getCollections();
    for (var item in cartcollections) {
      final productId = item['product_id'] as int;
      tempCart[productId] = (tempCart[productId] ?? 0) + 1;
    }
    setState(() {
      _cart = tempCart;
    });
  }

  void _addItem(int index) {
    setState(() {
      _cart[index] = (_cart[index] ?? 0) + 1;
    });
  }

  void _removeItem(int index) {
    setState(() {
      if (_cart.containsKey(index)) {
        if (_cart[index]! > 1) {
          _cart[index] = _cart[index]! - 1;
        } else {
          _cart.remove(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasItems = _cart.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Saya 🛒"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Tambah Produk",
            onPressed: () async {
              // Buka halaman produk, biarkan user pilih
              final newItem = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );

              if (newItem != null && newItem is int) {
                setState(() {
                  _cart[newItem] = (_cart[newItem] ?? 0) + 1;
                });
              }
            },
          ),
        ],
      ),
      body:
          hasItems
              ? ListView.builder(
                itemCount: _cart.length,
                itemBuilder: (context, i) {
                  final productIndex = _cart.keys.elementAt(i);
                  final quantity = _cart.values.elementAt(i);

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://picsum.photos/seed/p$productIndex/120/80",
                        ),
                      ),
                      title: Text("Produk $productIndex"),
                      subtitle: Text("Jumlah: $quantity"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _removeItem(productIndex),
                          ),
                          Text("$quantity"),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => _addItem(productIndex),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
              : const Center(
                child: Text(
                  "Keranjang masih kosong 🛒\nTambahkan produk dulu!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
      bottomNavigationBar:
          hasItems
              ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    // Arahkan ke halaman checkout
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Lanjut ke Checkout 🚀")),
                    );
                  },
                  child: const Text(
                    "Checkout",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
              : null,
    );
  }
}

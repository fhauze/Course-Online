import 'package:flutter/material.dart';
import 'package:online_course/AddressPickerScreen.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedCourier = "JNE - Reguler (2-3 hari)";
  String selectedPayment = "QRIS";
  bool useVoucher = false;
  String selectedAddress = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FB),
      appBar: AppBar(
        title: Text("Checkout"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Alamat
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(Icons.location_on, color: Colors.blueAccent),
              title: Text("Alamat Utama"),
              subtitle: Text(selectedAddress ?? "Belum ada alamat"),
              trailing: TextButton(
                onPressed: () async {
                  final newAddress = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddressPickerScreen()),
                  );
                  if (newAddress != null) {
                    setState(() => selectedAddress = newAddress);
                  }
                },
                child: Text("Ubah"),
              ),
            ),
          ),
          SizedBox(height: 12),

          // Ringkasan Produk
          ExpansionTile(
            leading: Icon(Icons.shopping_bag),
            title: Text("Produk (2)"),
            children: [
              ListTile(
                title: Text("Kopi Gayo Premium"),
                subtitle: Text("x2"),
                trailing: Text("Rp 120.000"),
              ),
              ListTile(
                title: Text("Roti Sourdough"),
                subtitle: Text("x1"),
                trailing: Text("Rp 45.000"),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Jasa Kirim
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pilih Jasa Kirim",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RadioListTile(
                    title: Text("JNE - Reguler (2-3 hari) • Rp 20.000"),
                    value: "JNE - Reguler (2-3 hari)",
                    groupValue: selectedCourier,
                    onChanged: (v) => setState(() => selectedCourier = v!),
                  ),
                  RadioListTile(
                    title: Text("SiCepat - Express (1-2 hari) • Rp 25.000"),
                    value: "SiCepat - Express (1-2 hari)",
                    groupValue: selectedCourier,
                    onChanged: (v) => setState(() => selectedCourier = v!),
                  ),
                  RadioListTile(
                    title: Text("Grab/Gojek Instant (3 jam) • Rp 35.000"),
                    value: "Grab/Gojek Instant (3 jam)",
                    groupValue: selectedCourier,
                    onChanged: (v) => setState(() => selectedCourier = v!),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),

          // Voucher
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SwitchListTile(
              title: Text("Gunakan Voucher Diskon"),
              value: useVoucher,
              onChanged: (v) => setState(() => useVoucher = v),
              secondary: Icon(Icons.local_offer, color: Colors.orange),
            ),
          ),
          SizedBox(height: 12),

          // Metode Pembayaran
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(Icons.payment, color: Colors.green),
              title: Text("Metode Pembayaran"),
              subtitle: Text(selectedPayment),
              trailing: TextButton(
                child: Text("Pilih"),
                onPressed: () {
                  _showPaymentOptions();
                },
              ),
            ),
          ),
          SizedBox(height: 12),

          // Ringkasan Pembayaran
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _priceRow("Subtotal", "Rp 165.000"),
                  _priceRow("Ongkir", "Rp 20.000"),
                  if (useVoucher) _priceRow("Diskon", "-Rp 10.000"),
                  Divider(),
                  _priceRow("Total Bayar", "Rp 175.000", bold: true),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: () {
              // TODO: Proses pembayaran
            },
            child: Text("Bayar Sekarang", style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.qr_code),
                title: Text("QRIS"),
                onTap: () => setState(() => selectedPayment = "QRIS"),
              ),
              ListTile(
                leading: Icon(Icons.account_balance),
                title: Text("Transfer Bank"),
                onTap: () => setState(() => selectedPayment = "Transfer Bank"),
              ),
              ListTile(
                leading: Icon(Icons.wallet),
                title: Text("E-Wallet (OVO/DANA/GoPay)"),
                onTap: () => setState(() => selectedPayment = "E-Wallet"),
              ),
              ListTile(
                leading: Icon(Icons.money),
                title: Text("COD (Cash On Delivery)"),
                onTap: () => setState(() => selectedPayment = "COD"),
              ),
            ],
          ),
    );
  }
}

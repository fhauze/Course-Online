library;

import 'package:postgres/postgres.dart';

class CreateTable {
  static Future<void> createTable() async {
    final conn = await Connection.open(
      Endpoint(
        host: '10.5.50.231',
        database: 'postgres',
        username: 'postgres',
        password: 'asalada123',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );
    // Buat tabel
    await conn.execute('''
    CREATE TABLE IF NOT EXISTS store (
      id SERIAL PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      category VARCHAR(100) NOT NULL,
      lat DOUBLE PRECISION NOT NULL,
      lng DOUBLE PRECISION NOT NULL,
      rating DOUBLE PRECISION NOT NULL, 
      price_level INT NOT NULL,
      price INT NOT NULL,
      hero_image VARCHAR(200) NOT NULL
    );
    CREATE TABLE IF NOT EXISTS mycollection (
      id SERIAL PRIMARY KEY,
      product_id int NOT NULL,

      is_fav BOOLEAN NOT NULL,
      is_cart BOOLEAN NOT NULL
    );
  ''');

    print("Tabel categories berhasil dibuat ✅");

    await conn.close();
  }
}

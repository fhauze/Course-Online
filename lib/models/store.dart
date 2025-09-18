import 'dart:math';

class Store {
  final String id;
  final String name;
  final String category;
  final double lat;
  final double lng;
  final double rating;
  final int priceLevel; // 1=cheap,2=medium,3=expensive
  final int price;
  final String heroImage;

  Store({
    required this.id,
    required this.name,
    required this.category,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.priceLevel,
    required this.heroImage,
    required this.price,
  });
}

List<Store> mockStores = List.generate(12, (i) {
  final rnd = Random(100 + i);
  final price = 10000 + rnd.nextInt(1000000 - 10000);
  return Store(
    id: 's\$i',
    name:
        ['Kafe Aurora', 'Warung Nebula', 'Bistro Luna', 'Toko Pixel'][i % 4] +
        ' #\$i',
    category: ['Coffee', 'Food', 'Bakery', 'Groceries'][i % 4],
    lat: -6.2 + rnd.nextDouble() * 0.02,
    lng: 106.8 + rnd.nextDouble() * 0.02,
    rating: (3.5 + rnd.nextDouble() * 1.5),
    priceLevel: 1 + (i % 3),
    price: price,
    heroImage: 'https://picsum.photos/seed/store\$i/600/400',
  );
});

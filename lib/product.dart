class Product {
  final String id;
  final String name;
  double _price; // private: encapsulated
  int _stock;    // private: encapsulated

  Product({
    required this.id,
    required this.name,
    required double price,
    int initialStock = 0,
  })  : assert(price >= 0, 'Price must be non-negative'),
        assert(initialStock >= 0, 'Initial stock must be non-negative'),
        _price = price,
        _stock = initialStock;

  // Getter for price (read access)
  double get price => _price;

  // Setter for price (validation)
  set price(double value) {
    if (value < 0) {
      throw ArgumentError('Price cannot be negative.');
    }
    _price = value;
  }

  // Getter for stock
  int get stock => _stock;

  // Method: sell some quantity. Returns total sale value or -1 on failure.
  double sell(int quantity) {
    if (quantity <= 0) {
      print('Sell failed: quantity must be positive.');
      return -1;
    }
    if (quantity > _stock) {
      print('Sell failed: insufficient stock for $name (requested: $quantity, available: $_stock).');
      return -1;
    }
    _stock -= quantity;
    final total = _price * quantity;
    print('Sold $quantity x $name at \$${_price.toStringAsFixed(2)} → Total: \$${total.toStringAsFixed(2)} (Remaining stock: $_stock)');
    return total;
  }

  // Method: restock
  void restock(int quantity) {
    if (quantity <= 0) {
      print('Restock failed: quantity must be positive.');
      return;
    }
    _stock += quantity;
    print('Restocked $quantity x $name → New stock: $_stock');
  }

  String info() => 'Product($id) $name — Price: \$${_price.toStringAsFixed(2)}, Stock: $_stock';
}

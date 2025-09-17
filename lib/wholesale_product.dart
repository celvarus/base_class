import 'product.dart';

class WholesaleProduct extends Product {
  final int minOrder;          // minimum quantity for wholesale
  double bulkDiscountRate;     // percent applied when orderQty >= minOrderThreshold
  final int minOrderThreshold; // threshold quantity to trigger bulkDiscountRate

  WholesaleProduct({
    required String id,
    required String name,
    required double price,
    int initialStock = 0,
    this.minOrder = 10,
    this.minOrderThreshold = 50,
    this.bulkDiscountRate = 5.0,
  })  : assert(minOrder > 0),
        assert(minOrderThreshold >= minOrder),
        assert(bulkDiscountRate >= 0),
        super(id: id, name: name, price: price, initialStock: initialStock);

  // Unique method: provide a quote without mutating stock
  double quote(int orderQty) {
    if (orderQty <= 0) {
      print('Quote failed: order quantity must be positive.');
      return -1;
    }
    if (orderQty < minOrder) {
      print('Quote: order qty $orderQty is below min order ($minOrder).');
      return -1;
    }
    var effectivePrice = price;
    if (orderQty >= minOrderThreshold) {
      effectivePrice = price * (1 - bulkDiscountRate / 100.0);
      print('Quote: bulk discount ${bulkDiscountRate.toStringAsFixed(2)}% applied for $orderQty units.');
    }
    final total = effectivePrice * orderQty;
    print('Quote for $orderQty x $name at \$${effectivePrice.toStringAsFixed(2)} → Total: \$${total.toStringAsFixed(2)}');
    return total;
  }

  // Override sell: require minOrder and apply bulk discount if meeting threshold
  @override
  double sell(int quantity) {
    if (quantity < minOrder) {
      print('Sell failed: wholesale order must be at least $minOrder units.');
      return -1;
    }
    double effectivePrice = price;
    if (quantity >= minOrderThreshold) {
      effectivePrice = price * (1 - bulkDiscountRate / 100.0);
    }

    if (quantity > stock) {
      print('Sell failed: insufficient stock for $name (requested: $quantity, available: $stock).');
      return -1;
    }

    // Temporarily set price to effectivePrice to reuse super.sell stock handling and printing
    final originalPrice = price;
    try {
      price = effectivePrice;
      final result = super.sell(quantity);
      price = originalPrice;
      return result;
    } catch (e) {
      price = originalPrice;
      rethrow;
    }
  }

  String wholesaleInfo() => 'WholesaleProduct($name) — MinOrder: $minOrder, Bulk if >= $minOrderThreshold units';
}

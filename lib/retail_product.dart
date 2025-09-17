import 'product.dart';

class RetailProduct extends Product {
  double discountRate; // percent, e.g., 10.0 => 10%

  RetailProduct({
    required String id,
    required String name,
    required double price,
    int initialStock = 0,
    this.discountRate = 0.0,
  })  : assert(discountRate >= 0),
        super(id: id, name: name, price: price, initialStock: initialStock);

  // Unique method to apply a temporary discount (reduces price for calculation only)
  double applyDiscount(double rate) {
    if (rate <= 0) {
      print('Discount not applied: rate must be positive.');
      return 0;
    }
    if (rate > 100) {
      print('Discount capped at 100%.');
      rate = 100;
    }
    final discountedPrice = price * (1 - rate / 100.0);
    print('Applied discount $rate% on $name: New effective price \$${discountedPrice.toStringAsFixed(2)}');
    return discountedPrice;
  }

  // Override sell to optionally use the instance's discountRate if > 0
  @override
  double sell(int quantity) {
    if (discountRate > 0) {
      final discounted = price * (1 - discountRate / 100.0);
      // reduce stock using base behavior but avoid duplicate prints: call base to adjust stock only
      if (quantity <= 0) {
        print('Sell failed: quantity must be positive.');
        return -1;
      }
      if (quantity > stock) {
        print('Sell failed: insufficient stock for $name (requested: $quantity, available: $stock).');
        return -1;
      }
      // mutate stock (can't access _stock directly) — use restock with negative? No. Use super.sell but that will use regular price.
      // So call super.sell to handle stock but compute prints ourselves and then adjust by difference.
      // Simpler: temporarily store price, set price to discounted to call super.sell(), then restore.
      final originalPrice = price;
      try {
        // use setter to change price temporarily (setter validates)
        price = discounted;
        final result = super.sell(quantity);
        // restore original price
        price = originalPrice;
        // result is already printed by super.sell (it used discounted price), return it
        return result;
      } catch (e) {
        // restore price if any exception
        price = originalPrice;
        rethrow;
      }
    } else {
      return super.sell(quantity); // no discount, normal flow
    }
  }

  String retailInfo() => 'RetailProduct($name) — Discount: ${discountRate.toStringAsFixed(2)}%';
}

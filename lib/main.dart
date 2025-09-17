// lib/main.dart
import 'product.dart';
import 'retail_product.dart';
import 'wholesale_product.dart';

void main() {
  print('--- Base Product Demo ---');
  var base = Product(id: 'P001', name: 'Notebook', price: 2.50, initialStock: 20);
  print(base.info());

  // Encapsulation: use setter with validation
  try {
    base.price = 3.0; // valid
    print('Price updated: \$${base.price}');
    base.price = -1.0; // invalid — should throw
  } catch (e) {
    print('Caught error when setting price: $e');
  }

  // Encapsulation: sell / restock
  base.sell(5);     // valid
  base.sell(100);   // invalid: insufficient stock
  base.restock(50); // restock
  base.sell(10);    // valid

  print('\n--- Retail Product Demo ---');
  var retail = RetailProduct(
    id: 'R100',
    name: 'Almond Cookies',
    price: 4.00,
    initialStock: 30,
    discountRate: 10.0, // 10% store-wide discount
  );
  print(retail.retailInfo());
  print(retail.info());
  retail.sell(3);           // should use discountRate
  retail.applyDiscount(20); // apply a one-off discount quote, does not change instance discountRate
  retail.restock(10);
  retail.sell(100);         // fail: insufficient stock

  print('\n--- Wholesale Product Demo ---');
  var wholesale = WholesaleProduct(
    id: 'W500',
    name: 'Bulk Sugar (25kg bag)',
    price: 20.0,
    initialStock: 200,
    minOrder: 5,
    minOrderThreshold: 50,
    bulkDiscountRate: 8.0,
  );
  print(wholesale.wholesaleInfo());
  print(wholesale.info());
  wholesale.quote(3);   // below minOrder → invalid
  wholesale.quote(60);  // quote with bulk discount
  wholesale.sell(4);    // fail (below min order)
  wholesale.sell(60);   // succeed with bulk discount applied
  wholesale.sell(500);  // fail: insufficient stock

  print('\n--- Final stock summary ---');
  print(base.info());
  print(retail.info());
  print(wholesale.info());
}
// Output:
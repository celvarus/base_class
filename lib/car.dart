
import 'vehicle.dart';

class Car extends Vehicle {
  double fuelLevel; // unique property

  Car({
    required String brand,
    required String model,
    this.fuelLevel = 50.0,
    int initialSpeed = 0,
  }) : super(brand: brand, model: model, initialSpeed: initialSpeed);

  // Unique method
  void refuel(double amount) {
    if (amount <= 0) {
      print('Refuel amount must be positive.');
      return;
    }
    fuelLevel += amount;
    if (fuelLevel > 100) fuelLevel = 100;
    print('$brand $model refueled by $amount%. Fuel level: $fuelLevel%');
  }

  String carInfo() => 'Car($brand $model) — Fuel: $fuelLevel%';
}

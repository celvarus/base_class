import 'vehicle.dart';

class ElectricCar extends Vehicle {
  double batteryLevel;

  ElectricCar({
    required String brand,
    required String model,
    this.batteryLevel = 100.0,
    int initialSpeed = 0,
  }) : super(brand: brand, model: model, initialSpeed: initialSpeed);

  // Unique method
  void charge(double amount) {
    if (amount <= 0) {
      print('Charge amount must be positive.');
      return;
    }
    batteryLevel += amount;
    if (batteryLevel > 100) batteryLevel = 100;
    print('$brand $model charged by $amount%. Battery: $batteryLevel%');
  }

  // Override accelerate to consume battery
  @override
  void accelerate(int amount) {
    if (batteryLevel <= 0) {
      print('$brand $model cannot accelerate: battery empty.');
      return;
    }
    super.accelerate(amount); // call parent
    batteryLevel -= amount * 0.5; // battery drain
    if (batteryLevel < 0) batteryLevel = 0;
    print('$brand $model battery after acceleration: $batteryLevel%');
  }

  String evInfo() => 'ElectricCar($brand $model) — Battery: $batteryLevel%';
}

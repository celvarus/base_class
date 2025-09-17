
// lib/main.dart
import 'vehicle.dart';
import 'car.dart';
import 'electric_car.dart';

void main() {
  print('--- Base Class: Vehicle ---');
  var v1 = Vehicle(brand: 'Toyota', model: 'Hilux', initialSpeed: 20);
  print(v1.info());
  v1.accelerate(30);
  v1.brake(15);

  print('\n--- Derived Class: Car ---');
  var car = Car(brand: 'Honda', model: 'Civic', fuelLevel: 70, initialSpeed: 10);
  print(car.carInfo());
  car.accelerate(40);
  car.refuel(20);
  car.brake(30);

  print('\n--- Derived Class: ElectricCar ---');
  var tesla = ElectricCar(brand: 'Tesla', model: 'Model 3', batteryLevel: 80, initialSpeed: 0);
  print(tesla.evInfo());
  tesla.accelerate(50); // uses overridden method
  tesla.charge(15);
  tesla.brake(20);
}
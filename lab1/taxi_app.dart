void main() {
  // Tariffs
  final double firstTariff = 250.0; // less than 10 km
  final double secondTariff = 200.0; // between 10 and 20 km
  final double thirdTariff = 150.0; // greather than 20 km

  // Tariff coeficients
  final double economyCoefficient = 1.0;
  final double standardCoefficient = 2.0;
  final double premiumCoefficient = 3.0;

  // Total distance travelled 
  double distanceTraveled = 15.0;

  // Current coeficient selected by user
  double currentCoefficient = standardCoefficient;

  // Total cost
  double totalCost = 0.0;

  for (int i = 1; i <= distanceTraveled; i++) {
    if (i > 0 && i <= 10) {
      totalCost += firstTariff;
    } else if (i > 10 && i <= 20) {
      totalCost += secondTariff;
    } else {
      totalCost += thirdTariff;
    }
  }

  totalCost *= currentCoefficient;

  print('Distance travelled: $distanceTraveled km');
  print('Tariff: ${currentCoefficient == economyCoefficient ? 'Economy' : (currentCoefficient == standardCoefficient ? 'Standard' : 'Premium')}');
  print('Total cost: $totalCost kzt');
}
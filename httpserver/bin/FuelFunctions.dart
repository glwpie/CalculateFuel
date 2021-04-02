part of 'basic_writer_server.dart';

int calculateFuel(Map json) {
  int intRaceTime = int.parse(json['raceTime']);
  double doubleFuelLap = double.parse(json['fuelLap']);
  int intStartingFuel = int.parse(json['startingFuel']);

  int intLapMin = lapTimeMin(json['lapTime']);
  int intLapSec = lapTimeSec(json['lapTime']);
  int intLapSeconds = lapSeconds(intLapMin, intLapSec);

  double doubleTotalLaps = totalLaps(intRaceTime, intLapSeconds);

  int result = fuelCalc(doubleTotalLaps, doubleFuelLap, intStartingFuel);

  print(result.toString());

  return result;
}

int lapTimeMin(String lapTime) {
  return int.parse(lapTime.split(':')[0]);
}

int lapTimeSec(String lapTime) {
  return int.parse(lapTime.split(':')[1]);
}

int lapSeconds(int intLapMin, int intLapSec) {
  return (intLapMin * 60 + intLapSec);
}

double totalLaps(int intRaceTime, int intLapSeconds) {
  return ((intRaceTime * 60) / intLapSeconds);
}

int fuelCalc(
    double doubleTotalLaps, double doubleFuelLap, int intStartingFuel) {
  return (((doubleTotalLaps + 2) * doubleFuelLap) - intStartingFuel + 1)
      .round();
}

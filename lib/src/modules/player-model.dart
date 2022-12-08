import 'dart:core';

class Player {
  String name;
  String picture;
  List<int>? setPoints;
  int matchPoints = 0;
  bool? isWinner;
  bool? isServe;

  Player({required this.name, required this.picture}) {
    this.setPoints = [0, 0, 0];
    this.matchPoints = 0;
    this.isWinner = false;
    this.isServe = false;
  }
  // suma puntos a el jugador
  void setMatchPoint(int point) {
    this.matchPoints = point;
  }

  // set winner
  setWinner() {
    isServe = true;
  }

  // get el valor de los puntos del partido
  int getMatchPoint() {
    return this.matchPoints;
  }

  // setea los puntos del jugador a cero
  void resetMatchPoint() {
    this.matchPoints = 0;
  }

  // guarda los datos de los set pasandole sienpre el valor y el set que se esta jugando
  void setSetsPoint(int point, int numSet) {
    this.setPoints![numSet] = point;
  }

  // get la lista de los puntos del set
  List<int>? getSetsPoints() {
    return this.setPoints;
  }

  get isWinnerPlayers {
    return this.isWinner;
  }

  // retorna los datos
}

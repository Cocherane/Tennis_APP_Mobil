import 'package:practica4_tennis_mobil/src/modules/player-model.dart';

class ControllerMatch {
  // los jugadores objeto del partido
  List<Player>? players;
  // El set que se eat jugando en el partido
  int numSetPlaying = 0;
  // los valores de los puntos del partido
  List<String> pointTemplate = ["00", "15", "30", "40"];
  // message dashboard [ "Game Point", "Set Point", "Deuce", "Playing.." ]
  String messageDashBoard = 'PLAYING...';

  // controlador
  ControllerMatch();

  // set players
  setPlayers(List<Player> players) {
    this.players = players;
  }

  // suma los puntos del partido
  setMatchPointController(int numPlayer) {
    // suma el punto a el jugador segun la position
    players![numPlayer].setMatchPoint(players![numPlayer].getMatchPoint() + 1);
    // print(players![numPlayer].getMatchPoint());
  }

  // muestra los valores de los puntos del partido
  // retorna 2 parametros para el front [ "40", "40"] los parametros 0 y 1 la puntuacion y
  // puede sen tambien deuce Ex. [ "AD", "40" ]
  List<String>? getMatchPointController() {
    // comrpobar el partido si los dos jugadores llegan a 40 == 40
    // la equivalencia de puntos para el programa es :
    // 0 -> 0  puntos
    // 1 -> 15 puntos
    // 2 -> 30 puntos
    // 3 -> 40 puntos
    // del 4 punto en nuestro sistema juega con el que tenga mejor diferencia
    if (players![0].getMatchPoint() >= 3 && players![1].getMatchPoint() >= 3) {
      print([players![0].getMatchPoint(), players![1].getMatchPoint()]);
      // comprovacion que si la puntuacion de los jugadores es igual se envia una Lista de puntuacion
      if (players![0].getMatchPoint() == players![1].getMatchPoint()) {
        // set dashboard message ["PLAYING...", "GAME POINT", "DEUCE", "SET POINT"]
        actionPlayingMatchMessageDashboard(2);

        return ["40", "40"];
        // comprueba que la puntuacion la diferencia es mayor que 2 puntos para asignar el set
      } else if (players![0].getMatchPoint() - players![1].getMatchPoint() ==
          2) {
        // el ganador es el jugador en la posicion numero 0
        // el ganador es el jugador en la posicion numero 0
        // asignamos un set gando al jugador 0
        _setSetPointController(0);
        // reseteamos los puntos del partido a cero
        _resetPointsMatchToZero();
        // pasamos el servico al jugador
        _setServerToogle();

        // set dashboard message ["PLAYING...", "GAME POINT", "DEUCE", "SET POINT"]
        actionPlayingMatchMessageDashboard(0);

        // retornamos el marcador del partido a cero
        return ["00", "00"];
      } else if (players![1].getMatchPoint() - players![0].getMatchPoint() ==
          2) {
        // el ganador es el jugador en la posicion numero 1
        // el ganador es el jugador en la posicion numero 1
        // asignamos un set gando al jugador 0
        _setSetPointController(1);
        // reseteamos los puntos del partido a cero
        _resetPointsMatchToZero();
        // pasamos el servico al jugador
        _setServerToogle();

        // set dashboard message ["PLAYING...", "GAME POINT", "DEUCE", "SET POINT"]
        actionPlayingMatchMessageDashboard(0);

        // retornamos el marcador del partido a cero
        return ["00", "00"];

        // comprobar si el jugador en la posicion 0 tiene deuce
      } else if (players![0].getMatchPoint() > players![1].getMatchPoint()) {
        // set dashboard message ["PLAYING...", "GAME POINT", "DEUCE", "SET POINT"]
        // if set will be won
        if (players![0].getSetsPoints()![numSetPlaying] == 5) {
          actionPlayingMatchMessageDashboard(3);
          // if game will be won
        } else {
          actionPlayingMatchMessageDashboard(1);
        }

        return ["AD", "40"];
        // comprobar si el jugador en la posicion 1 tiene deuce
      } else {
        // if set will be won
        if (players![1].getSetsPoints()![numSetPlaying] == 5) {
          actionPlayingMatchMessageDashboard(3);
          // if game will be won
        } else {
          actionPlayingMatchMessageDashboard(1);
        }

        return ["40", "AD"];
      }

      // comprobacion de los puntos del partido <= 40 puntos
    } else {
      // comprobacion si los jugadores han llegado a 40
      if (players![0].getMatchPoint() >= 4) {
        // el ganador es el jugador en la posicion numero 0
        // asignamos un set gando al jugador 0
        _setSetPointController(0);
        // reseteamos los puntos del partido a cero
        _resetPointsMatchToZero();
        // pasamos el servico al jugador
        _setServerToogle();

        // set dashboard message ["PLAYING...", "GAME POINT", "DEUCE", "SET POINT"]
        actionPlayingMatchMessageDashboard(0);

        return ["00", "00"];
        // todo hacer el reset de la pointmatch del jugador y asignar el set
      } else if (players![1].getMatchPoint() >= 4) {
        // el ganador es el jugador en la posicion numero 1
        // asignamos un set gando al jugador 0
        _setSetPointController(1);
        // reseteamos los puntos del partido a cero
        _resetPointsMatchToZero();
        // pasamos el servico al jugador
        _setServerToogle();

        // set dashboard message ["PLAYING...", "GAME POINT", "DEUCE", "SET POINT"]
        actionPlayingMatchMessageDashboard(0);

        return ["00", "00"];
        // mostar los datos de los jugadores
      } else {
        // set dashboard message ["PLAYING...", "GAME POINT", "DEUCE", "SET POINT"]

        // check dashboard message action player 0
        // if player 0 will be won a set
        if (players![0].getMatchPoint() == 3 &&
            players![0].getSetsPoints()![numSetPlaying] == 5) {
          actionPlayingMatchMessageDashboard(3);
          // if player 0 will be won a game
        } else if (players![0].getMatchPoint() == 3) {
          actionPlayingMatchMessageDashboard(1);
          // if player 0 add a point to game
        } 

        // check dashboard message action player 1
        // if player 1 will be won a set
        else if (players![1].getMatchPoint() == 3 &&
            players![1].getSetsPoints()![numSetPlaying] == 5) {
          actionPlayingMatchMessageDashboard(3);
          // if player 1 will be won a game
        } else if (players![1].getMatchPoint() == 3) {
          actionPlayingMatchMessageDashboard(1);
          // if player 1 add a point to game
        } else {
          actionPlayingMatchMessageDashboard(0);
        }

        return [
          pointTemplate[players![0].getMatchPoint()],
          pointTemplate[players![1].getMatchPoint()]
        ];
      }
    }
  }

  // controla los puntos del set anade un punto a los set por solo pasarle la posicion del jugador
  void _setSetPointController(int numPlayer) {
    print('numero de set $numSetPlaying');
    // anadimos los puntos del set a el jugador
    this.players![numPlayer].setSetsPoint(
        (players![numPlayer].getSetsPoints()![numSetPlaying] + 1),
        numSetPlaying);
    // llmamos al controlador de los set
    print('Jugador ${players![numPlayer].getSetsPoints().toString()} ');
    print('numero de set $numSetPlaying');
    _ControllerSetMatch();
  }

  // controlador de los puntos de los set solo se llama cada vez que se gana un partido
  void _ControllerSetMatch() {
    // controlar que si algun jugador ya tenga 6 partidos ganados, se suma un el siguiente numero de set
    if (players![0].getSetsPoints()![numSetPlaying] == 6 ||
        players![1].getSetsPoints()![numSetPlaying] == 6) {
      // sumar al set
      numSetPlaying += 1;

      // comprobar si el set esta en el ultimo, mostrar al ganador
      if (numSetPlaying == 3) {
        // ####### mostar al ganador
        // set player winner
        players![whoIsWinner()].isWinner = true;

        // check if there is a winner
      } else if (numSetPlaying == 2 && whoIsWinner() != -1) {
        // set player winner
        players![whoIsWinner()].isWinner = true;
        // set value set to 2
        numSetPlaying -= 1;
      }
      // else {
      //   // sumar al set
      //   numSetPlaying += 1;
      //   // pasamos el servico al jugador
      //   _setServerToogle();
      // }
    }
  }

  // poner los campos de los punto de partido a cero
  void _resetPointsMatchToZero() {
    players![0].matchPoints = 0;
    players![1].matchPoints = 0;
  }

  // retorna una lista de lista de los valores de los set de los jugadores
  List<List<String>> getSetsPointsController() {
    return [
      players![0].getSetsPoints()!.map((point) => '$point').toList(),
      players![1].getSetsPoints()!.map((point) => '$point').toList()
    ];
  }

  // retorna los datos de los jugadores
  List<List<String>> getDataPlayersController() {
    return [
      [players![0].name, players![0].picture],
      [players![1].name, players![1].picture]
    ];
  }

  // manejar el el servicio de los jugadores
  void setServePLayer(int playerPosition) {
    if (players![0].isServe! && players![1].isServe!) {
      // ponemos el primer jugador que va a hacer el servicio del juego
      players![playerPosition].isServe = true;
    } else if (playerPosition == 0) {
      // ponemos al jugador 0 en el servicio
      players![0].isServe = true;
      // ponemos al jugador 1 a false para el servicio
      players![1].isServe = false;
    } else if (playerPosition == 1) {
      // ponemos al jugador 1 a false para el servicio
      players![0].isServe = false;
      // ponemos al jugador 0 en el servicio
      players![1].isServe = true;
    } else {
      // reiniciamos todos los valores de server a false
      players![0].isServe = false;
      players![1].isServe = false;
    }
  }

  // hace un toogle del servicio
  void _setServerToogle() {
    // si el servico esta en el jugador 0 pasamos el servico al jugador 1
    if (players![0].isServe!) {
      // ponemos al jugador 1 a false para el servicio
      players![0].isServe = false;
      // ponemos al jugador 0 en el servicio
      players![1].isServe = true;
    } else {
      // ponemos al jugador 0 en el servicio
      players![0].isServe = true;
      // ponemos al jugador 1 a false para el servicio
      players![1].isServe = false;
    }
  }

  // muestra un bool a comprobar si el servicio no se ha escogido los un jugador
  bool isInitServer() {
    return !players![0].isServe! && !players![1].isServe!;
  }

  // controller Winner each set won
  // retorn num winner 0 -> player 0 | 1 -> player 1 | -1 -> no winner
  int whoIsWinner() {
    // get all player set points
    int setPlusPointPlayer0 =
        players![0].setPoints!.reduce((value, element) => value + element);
    int setPlusPointPlayer1 =
        players![1].setPoints!.reduce((value, element) => value + element);

    // check if players 0 is a winner
    if (setPlusPointPlayer0 >= 12) {
      // return the player 0 won match
      return 0;
    }
    // check if players 1 is a winner
    else if (setPlusPointPlayer1 >= 12) {
      // return the player 0 won match
      return 1;

      // check both players ai't won
    } else {
      return -1;
    }
  }

  // controller if there is a winner
  bool thereIsAPlayerWinner() {
    return players![0].isWinner! || players![1].isWinner!;
  }

  // controller dashboard message
  void actionPlayingMatchMessageDashboard(int messageID) {
    messageDashBoard =
        ["PLAYING...", "GAME POINT", "DEUCE", "SET POINT"][messageID];
  }

  // get dashboard message
  String getDashboardMessage() {
    return messageDashBoard;
  }
}

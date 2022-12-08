import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practica4_tennis_mobil/src/controller/controller-match.dart';
import 'package:practica4_tennis_mobil/src/modules/player-model.dart';

import '../modules/matches-models.dart';

class DashBoard extends StatefulWidget {
  Matches match;

  DashBoard({required this.match, super.key});

  @override
  State<DashBoard> createState() => _DashBoardState(this.match);
}

class _DashBoardState extends State<DashBoard> {
  
  @override
  void initState() {
    super.initState();
    //set orientation device
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }
  
  // instancia del controlador
  final ControllerMatch controller = ControllerMatch();
  List<String> pointsPlayers = ['00', '00'];
  Matches? _match;
  List<Player> playersData = [];
  List<List<String>> pointsSets = [
    [
      '0',
      '0',
      '0',
    ],
    [
      '0',
      '0',
      '0',
    ]
  ];

  _DashBoardState(Matches matchState) {
    this.controller.setPlayers([
      Player(
          name: matchState.player[0].name,
          picture: matchState.player[0].picture),
      Player(
          name: matchState.player[1].name,
          picture: matchState.player[1].picture)
    ]);
    pointsPlayers = controller.getMatchPointController()!;
    pointsSets = controller.getSetsPointsController();
    playersData = controller.players!;
  }

  // to update all state
  _updateStateData() {
    setState(() {});
    pointsPlayers = controller.getMatchPointController()!;
    pointsSets = controller.getSetsPointsController();
    playersData = controller.players!;
  }

  // Stylos de los componentes de los textos
  // retorna los estilo de los puntos del los set
  TextStyle _getSetsTextStyle(int setPosition) {
    return TextStyle(
        fontSize: 60,
        fontFamily: 'GasFont',
        color: controller.numSetPlaying == setPosition
            ? Color.fromARGB(255, 40, 208, 45)
            : controller.numSetPlaying > setPosition
                ? Colors.white
                : Colors.white30);
  }

  // retorna los estilo de los numero de los puntos del partido
  TextStyle _getPointsTextStyle() {
    return TextStyle(fontSize: 180, fontFamily: 'GasFont', color: Colors.white);
  }

  // retorna los estilo del boton serve cuando ha sido selecionado
  TextStyle _getStyleServerButton(bool isServeInit) {
    return GoogleFonts.notoSans(
        fontSize: 20,
        fontWeight: isServeInit ? FontWeight.w700 : FontWeight.w400,
        color: isServeInit ? Color.fromARGB(255, 40, 208, 45) : Colors.white38);
  }

  // retorna los estilo de la advertencia que hay un ganador
  TextStyle _getStyleWinnerButton(bool isWinner) {
    return GoogleFonts.notoSans(
        fontSize: 20,
        fontWeight: isWinner ? FontWeight.w700 : FontWeight.w400,
        color: isWinner
            ? Color.fromARGB(255, 255, 81, 0)
            : Color.fromARGB(158, 222, 134, 84));
  }

  // retorna los estilo del boton de fault
  TextStyle _getStyleFaultButton() {
    return GoogleFonts.notoSans(
        fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white38);
  }

  // retorna los estilo del boton de unforce error
  TextStyle _getStyleUnforceErrorButton() {
    return GoogleFonts.notoSans(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Color.fromARGB(168, 95, 147, 230),
    );
  }

  // color de fondo de la aplicacion
  Color _getColorPointsBackground() {
    return Color.fromARGB(255, 43, 45, 44);
  }

  // color de fondo de la aplicacion
  Color _getColorSideBackground() {
    return Color.fromARGB(255, 67, 69, 68);
  }

  // border de las container 1
  BoxDecoration _getBordersContainer1() {
    return BoxDecoration(
        color: _getColorPointsBackground(),
        border: Border.all(color: Color.fromARGB(255, 8, 8, 8), width: 3));
  }

  // border de las container 2
  BoxDecoration _getBordersContainer2() {
    return BoxDecoration(
        color: _getColorSideBackground(),
        border: Border.all(color: Color.fromARGB(255, 8, 8, 8), width: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          decoration: _getBordersContainer1(),
          height: 194,
          child: Column(
            children: [
              setsDataPlayer(context, pointsSets[0], controller.players![0]),
              setsDataPlayer(context, pointsSets[1], controller.players![1])

              ///###################################### jugador sets
            ],
          ),
        ),
        Container(
          height: 82,
          decoration: _getBordersContainer2(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Text(
                    controller.players![0].name,
                    style: GoogleFonts.notoSans(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: controller.players![0].isServe!
                            ? Color.fromARGB(255, 40, 208, 45)
                            : Colors.white),
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 60),
                  child: Text(
                    controller.players![1].name,
                    style: GoogleFonts.notoSans(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: controller.players![1].isServe!
                            ? Color.fromARGB(255, 40, 208, 45)
                            : Colors.white),
                  )),
            ],
          ),
        ),
        Expanded(
          child: Container(
              color: _getColorPointsBackground(),
              height: 100,
              child: Row(
                children: [
                  sideBarControllerMatch(context, playersData[0], 0),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        controller.thereIsAPlayerWinner()
                            ? 'WINNER'
                            : controller.isInitServer()
                                ? '<<   Who Serves First   >>'
                                : controller.getDashboardMessage(),
                        style: GoogleFonts.notoSans(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: controller.thereIsAPlayerWinner()
                              ? Color.fromARGB(255, 255, 81, 0)
                              : controller.isInitServer()
                                  ? Color.fromARGB(255, 40, 208, 45)
                                  : Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            child: Container(
                              width: 416,
                              height: 320,
                              alignment: Alignment.center,
                              child: Text(pointsPlayers[0],
                                  style:
                                      _getPointsTextStyle()), /////// puntuacion del jugador 1
                            ),
                            onTap: () {
                              // controller to add points just if there isn't a winner and the serves is selected
                              if (!controller.isInitServer() && !controller.thereIsAPlayerWinner()) {
                                // add points to player 1
                                controller.setMatchPointController(0);
                                // update data
                                _updateStateData();
                              }
                            },
                          ),
                          Expanded(
                              child: Container(
                            height: 300,
                            color: Color.fromARGB(255, 8, 8, 8),
                          )),
                          GestureDetector(
                            child: Container(
                              width: 416,
                              height: 320,
                              alignment: Alignment.center,
                              child: Text(
                                pointsPlayers[1],
                                style: _getPointsTextStyle(),
                              ), /////// puntuacion del jugador 2
                            ),
                            onTap: () {
                              // controller to add points just if there isn't a winner and the serves is selected
                              if (!controller.isInitServer() &&
                                  !controller.thereIsAPlayerWinner()) {
                                // add points to player 2
                                controller.setMatchPointController(1);
                                // update data
                                _updateStateData();
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  )),
                  sideBarControllerMatch(context, playersData[1], 1),
                ],
              )),
        )
      ],
    ));
  }

  /// player data from sets
  Row setsDataPlayer(
      BuildContext context, List<String> pointsSetsPlayer, Player dataPlayers) {
    return Row(
      //###################################### primer jugador
      children: [
        Stack(
          children: [
            Positioned(
                child: Image.network(
              dataPlayers.picture,
              width: 100,
            ))
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 90,
          alignment: Alignment.center,
          // color: Colors.blue,
          child: Text(dataPlayers.name,
              style: GoogleFonts.notoSans(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: dataPlayers.isServe!
                      ? Color.fromARGB(255, 40, 208, 45)
                      : Colors.white70)),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 90,
                height: 90,
                alignment: Alignment.center,
                // color: Colors.red,
                child: Text(
                  pointsSetsPlayer[0],
                  style: _getSetsTextStyle(0),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 90,
                height: 90,
                // color: Colors.red,
                child: Text(
                  pointsSetsPlayer[1],
                  style: _getSetsTextStyle(1),
                ),
              ),
              Container(
                width: 90,
                height: 90,
                alignment: Alignment.center,
                // color: Colors.red,
                child: Text(
                  pointsSetsPlayer[2],
                  style: _getSetsTextStyle(2),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // barra de control del juego don de esta el server
  Container sideBarControllerMatch(
      BuildContext context, Player dataPlayer, int numPLayer) {
    return Container(
      width: 150,
      color: _getColorSideBackground(),
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              width: 150,
              height: 95,
              child: Center(
                  child: Text(
                'SERVES',
                style: _getStyleServerButton(controller.isInitServer()),
              )),
            ),
            onTap: () {
              // inicia el servico para el jugador 1
              controller.setServePLayer(numPLayer);
              // update data
              _updateStateData();
            },
          ),
          Container(
            width: 150,
            height: 95,
            child: Center(
                child: Text(
              'WINNER',
              style: _getStyleWinnerButton(dataPlayer.isWinnerPlayers!),
            )),
          ),
          Container(
            width: 150,
            height: 95,
            child: Center(
                child: Text(
              'FAULT',
              style: _getStyleFaultButton(),
            )),
          ),
          Container(
            width: 150,
            height: 100,
            child: Center(
                child: Text(
              'UNFORCED ERROR',
              style: _getStyleUnforceErrorButton(),
              textAlign: TextAlign.center,
            )),
          ),
        ],
      ),
    );
  }
}

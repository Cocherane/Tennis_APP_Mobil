import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practica4_tennis_mobil/src/modules/matches-models.dart';
import 'package:practica4_tennis_mobil/src/modules/player-model.dart';
import 'package:practica4_tennis_mobil/src/views/dashboard.dart';

class ListMatches extends StatelessWidget {
  List<Matches> matches = [];
  ListMatches({required this.matches, super.key});

  @override
  Widget build(BuildContext context) {
    //set orientation device
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/logo-nav-2.png',
          height: 200,
          ),
          leadingWidth: 200,
          title: Text(
            'Managing tennis tournaments',
            style: GoogleFonts.kanit(
              fontSize: 35
            )
            ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 120, 19, 250),
          elevation: 20,
      ),
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: ((context, index) {
          // return all listTile
          return _rowListTitle(context, matches[index]);
        }),
      ),
    );
  }

  // return a listTile with the match
  Widget _rowListTitle(BuildContext context, Matches match) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 60, vertical: 10),
      child: GestureDetector(
        child: Card(
          
            
          elevation: 30,
          shadowColor: Color.fromARGB(255, 156, 32, 177),
          child: Container(
            height: 200,
            decoration:  BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: Image.asset(
                  'assets/images/bg-playes.png',
                ).image, 
              ) 
            ),
    
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //imagen player 0
                FadeInImage(
                  placeholder: Image.asset('assets/images/loading-1.gif', width: 100,).image, 
                  image: NetworkImage( match.player[0].picture),
                  height: 200,
                  fadeOutCurve: Curves.bounceInOut,
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( 
                      '${match.player[0].name}   VS  ${match.player[1].name}',
                      style: GoogleFonts.kdamThmor(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Referee the game, click here')
                  ],
                ),
                FadeInImage(
                  placeholder: Image.asset('assets/images/loading-1.gif', height: 100,).image, 
                  image: NetworkImage( match.player[1].picture),
                  height: 200,
                  ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DashBoard( match: match )));
        },

      ),
    );

   
  }
}


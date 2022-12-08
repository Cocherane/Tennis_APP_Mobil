
import 'package:flutter/material.dart';
import 'package:practica4_tennis_mobil/src/modules/matches-models.dart';
import 'package:practica4_tennis_mobil/src/services/service-manager.dart';
import 'package:practica4_tennis_mobil/src/views/dashboard.dart';
import 'package:practica4_tennis_mobil/src/views/list-matches.dart';

class SplachScreenWeb extends StatefulWidget {
  const SplachScreenWeb({super.key});

  @override
  State<SplachScreenWeb> createState() => _SplachScreenWebState();
}

class _SplachScreenWebState extends State<SplachScreenWeb> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: serviceManager.getAllMatches(),
        initialData: [],
        builder:
            ((BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              
              Future.delayed(Duration(seconds: 3), () {
                // Navigator.popAndPushNamed(context, 'dashboard',
                //     arguments: snapshot.data![0]);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ListMatches( matches: snapshot.data! as List<Matches> )));
                            // DashBoard(match: snapshot.data![1] )));
              });

              // en caso de error
            } else if (snapshot.hasError != null) {
              return Text(snapshot.toString());
            }
          }

          return loadSplashScreen();
        }));
  }

  // pagina de espera de los datos
  Widget loadSplashScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 130,
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 400,
            ),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 150),
              child: LinearProgressIndicator(
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

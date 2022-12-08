// To parse this JSON data, do
//
//     final matchesData = matchesDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MatchesData matchesDataFromJson(String str) => MatchesData.fromJson(json.decode(str));

String matchesDataToJson(MatchesData data) => json.encode(data.toJson());

class MatchesData {
    MatchesData({
        required this.status,
        required this.data,
    });

    int status;
    List<Matches> data;

    factory MatchesData.fromJson(Map<String, dynamic> json) => MatchesData(
        status: json["status"],
        data: List<Matches>.from(json["data"].map((x) => Matches.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Matches {
    Matches({
        required this.player,
        required this.status,
        required this.id,
    });

    List<PlayerMatch> player;
    bool status;
    String id;

    factory Matches.fromJson(Map<String, dynamic> json) => Matches(
        player: List<PlayerMatch>.from(json["player"].map((x) => PlayerMatch.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "player": List<dynamic>.from(player.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class PlayerMatch {
    PlayerMatch({
        required this.name,
        required this.picture,
        required this.serve,
        required this.gameScore,
        required this.setsWon,
        required this.set1,
        required this.set2,
        required this.set3,
        required this.winner,
        required this.id,
    });

    String name;
    String picture;
    bool serve;
    String gameScore;
    String setsWon;
    String set1;
    String set2;
    String set3;
    bool winner;
    int id;

    factory PlayerMatch.fromJson(Map<String, dynamic> json) => PlayerMatch(
        name: json["name"],
        picture: json["picture"],
        serve: json["serve"],
        gameScore: json["game_score"],
        setsWon: json["sets_won"] == null ? '' : json["sets_won"],
        set1: json["set1"],
        set2: json["set2"],
        set3: json["set3"],
        winner: json["winner"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "picture": picture,
        "serve": serve,
        "game_score": gameScore,
        "sets_won": setsWon == null ? '' : setsWon,
        "set1": set1,
        "set2": set2,
        "set3": set3,
        "winner": winner,
        "id": id,
    };
}

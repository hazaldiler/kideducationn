import 'dart:async' show Future;
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_ornek/entities/alphabet.dart';
import 'package:firebase_ornek/widgets/page_header.dart';
import 'package:firebase_ornek/widgets/tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_sound/flutter_sound.dart';

import '../helper.dart';

Future<List<AlphabetEntity>> _fetchAlphabets() async {
  String jsonString = await rootBundle.loadString('assets/data/alphabets.json');
  final jsonParsed = json.decode(jsonString);

  return jsonParsed
      .map<AlphabetEntity>((json) => new AlphabetEntity.fromJson(json))
      .toList();
}

class AlphabetsScreen extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;

  AlphabetsScreen({
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  _AlphabetsScreenState createState() => _AlphabetsScreenState();
}

class _AlphabetsScreenState extends State<AlphabetsScreen> {
  late Future<List<AlphabetEntity>> _alphabetsFuture;
  late FlutterSoundPlayer _soundPlayer;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();

    _alphabetsFuture = _fetchAlphabets();
    _soundPlayer = new FlutterSoundPlayer();
  }

  void _playAudio(String audioPath) async {
    // Load a local audio file and get it as a buffer
    Uint8List buffer = (await rootBundle.load(audioPath)).buffer.asUint8List();
    await _soundPlayer.startPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          PageHeader(
            title: widget.title,
            primaryColor: widget.primaryColor,
            secondaryColor: widget.secondaryColor,
          ),
          Expanded(
            child: FutureBuilder(
              future: _alphabetsFuture,
              builder: (context, dynamic snapshot) {
                if (snapshot.hasData) {
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                      ),
                      //itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: index % 2 == 0
                              ? const EdgeInsets.only(bottom: 20, left: 20)
                              : const EdgeInsets.only(bottom: 20, right: 20),
                          child: TileCard(
                            isActive: _selectedIndex == index,
                            title: snapshot.data[index].text,
                            textColor: getIndexColor(index),
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                              _playAudio(snapshot.data[index].audio);
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text('Loading...'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _soundPlayer.isPlaying;
    super.dispose();
  }
}

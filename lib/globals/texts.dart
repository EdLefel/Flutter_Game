import 'package:flutter/material.dart';
import 'package:jogodacobrinha/caverncboard.dart';
import 'package:jogodacobrinha/globals/globals.dart';

Widget MyTextCustom(String text, int fontSize, Color color, FontWeight fontWeight, bool backg, Color backgroundcolor) {
  if (backg == true){
    return Text(
    text,
    style: TextStyle(
      fontSize: fontSize.toDouble(),
      color: color,
      fontWeight: fontWeight,
      fontFamily: 'PixelifySans',
      backgroundColor: backgroundcolor,
    ),
  );
      }
  else{
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize.toDouble(),
        color: color,
        fontWeight: fontWeight,
        fontFamily: 'PixelifySans'
      ),
    );
  }
}

String intro = "Earth 3027 AD, 627 years since the Great Nuclear War, Earth's surface is a barren, irradiated expanse. Humanity has retreated into the depths, finding refuge in subterranean cities carved by colossal machines. These relics of war now sustain isolated underground nations, each vying for dominance. But a sinister force is stirring in the darkness below.";
String mission1title = "Come to the Capital City";
String mission1 = "We have a serious problem. Come to the capital and we'll give you an investigative mission. We need to understand what happened to the city of Abyss, on the border.";


  void showCustomDialogMission(BuildContext context, int missionnumber) {
      String missiontittle = "Inital Call";
      String missiontext = 'inital mission';
      bool imgshow = false;
      String imgshowed = "";
      bool premio = false;
      
      if (playermissionvalue == 0){
        missiontext = mission1;
      }
    showDialog(
      context: context,
      barrierDismissible: false,  // Fecha o diálogo ao clicar fora
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.9),  // Fundo translucido
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextCustom( missiontittle, 16, Colors.amber,FontWeight.normal ,true, Colors.black),
                const SizedBox(height: 5),
                MyTextCustom( missiontext, 14, Colors.white,FontWeight.normal ,false, Colors.white),
                 
                const SizedBox(height: 20),
                Center(
                  child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const Padding(padding: EdgeInsets.all(10),),
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(1),
                        child: Text('Start', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'PixelifySans')),
                        )
                    ),
                    ]
                    )
                )
                  ],
            ),
          ),);}
        );
      }

     void showCustomDialNewMap(BuildContext context, String newmap) {
  
    showDialog(
      context: context,
      barrierDismissible: false,  // Fecha o diálogo ao clicar fora
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.5),  // Fundo translucido
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextCustom( 'Novo Mapa', 16, Colors.black,FontWeight.normal ,true, Colors.white),
                const SizedBox(height: 5),
                MyTextCustom( newmap, 14, Colors.black,FontWeight.normal ,true, Colors.white),
                 
                const SizedBox(height: 20),
                Center(
                  child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const Padding(padding: EdgeInsets.all(10),),
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(1),
                        child: Text('Start', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'PixelifySans')),
                        )
                    ),
                    ]
                    )
                )
                  ],
            ),
          ),);}
        );
      }
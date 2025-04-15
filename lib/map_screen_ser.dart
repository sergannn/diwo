import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:yandex_maps_mapkit/yandex_maps_mapkit.dart';

class MapScreenS extends StatefulWidget {
  const MapScreenS({super.key});

  @override
  State<MapScreenS> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AppBar with hamburger button'),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: myDrawer(),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                color: Colors.red,
                child: Column(children: [
                  SizedBox(height: 20),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        //shape: BoxShape.circle,
                        color: Colors.blue,
                        border: Border.all(
                          // добавление границы
                          color: Colors.white,
                          //width: 2.0,
                        ),
                        boxShadow: [
                          // добавление тени
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        // Горизонтальная линия с двумя кнопками
                        //crossAxisAlignment: ,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                              border: Border.all(
                                // добавление границы
                                color: Colors.white,
                                width: 2.0,
                              ),
                              boxShadow: [
                                // добавление тени
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Джек"),
                                Row(children: [
                                  Text("a"),
                                  Text("followers"),
                                  Text("b|"),
                                  Text("Following")
                                ])
                              ]),
                        ],
                      )),
                ]))));
  }

  Widget Collection1() {
    return Container(
        //  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          //shape: BoxShape.circle,
          color: Colors.white.withOpacity(0),
          border: Border.all(
            // добавление границы
            color: Colors.green.withOpacity(1),
            //width: 2.0,
          ),
          boxShadow: [
            // добавление тени
            BoxShadow(
              color: Colors.black.withOpacity(0),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          // Горизонтальная линия с двумя кнопками
          //crossAxisAlignment: ,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                border: Border.all(
                  // добавление границы
                  color: Colors.white,
                  width: 2.0,
                ),
                boxShadow: [
                  // добавление тени
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 14),
              alignment: Alignment.centerLeft,
              height: 50.0,
              //  padding:
              //      EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                //shape: BoxShape.circle,
                color: Colors.purple,
                border: Border.all(
                  // добавление границы
                  color: Colors.green,
                  //width: 2.0,
                ),
                boxShadow: [
                  // добавление тени
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text("Джек"),
            ))
          ],
        ));
  }

  Widget HeaderOfDrawer() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          //shape: BoxShape.circle,
          color: Colors.blue,
          border: Border.all(
            // добавление границы
            color: Colors.green,
            //width: 2.0,
          ),
          boxShadow: [
            // добавление тени
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          // Горизонтальная линия с двумя кнопками
          //crossAxisAlignment: ,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                border: Border.all(
                  // добавление границы
                  color: Colors.white,
                  width: 2.0,
                ),
                boxShadow: [
                  // добавление тени
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Джек"),
                  Row(children: [
                    Text("a"),
                    Text("followers"),
                    Text("b|"),
                    Text("Following")
                  ])
                ]),
          ],
        ));
  }
Widget FooterOfDrawer() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
       Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.blue.withOpacity(0),
            border: Border.all(
              color: Colors.white,
              //width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
              ),
            ],
          ),
          child:   Column(
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //  mainAxisSize: MainAxisSize.max,
            children: [
              Text("NFT"),
               Container(
                width: 150,
                child:
        Text(style:TextStyle(fontSize: 10),"""In the diagram above:
Orange demonstrates how Expanded widgets work inside a Column
The key thing to understand is that mainAxisSize controls how""")
            
          ),
         TextButton(onPressed:  null,child: Text("aaa"))]
          )),
      
    
      Column(
        children: [
          TextButton(
            child:         Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                              border: Border.all(
                                // добавление границы
                                color: Colors.white,
                                width: 2.0,
                              ),
                              boxShadow: [
                                // добавление тени
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
            onPressed: () {},
          ),
          TextButton(
            child:         Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                              border: Border.all(
                                // добавление границы 
                                color: Colors.white,
                                width: 2.0,
                              ),
                              boxShadow: [
                                // добавление тени
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
            onPressed: () {},
          ),
          TextButton(
            child:        Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                              border: Border.all(
                                // добавление границы
                                color: Colors.white,
                                width: 2.0,
                              ),
                              boxShadow: [
                                // добавление тени
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
            onPressed: () {},
          )
        ],
      )
    ],
  );
}

  Widget myDrawer() {
    return Drawer(
//      elevation: -1,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
        child:Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Important: Remove any padding from the ListView.
       // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),

        children: [
          SizedBox(height: 100),
          HeaderOfDrawer(),
          SizedBox(height: 100),
          Column(children:[Collection1(),
          SizedBox(height: 20),
          Collection1(),
          SizedBox(height: 20),
          Collection1()]),
          SizedBox(height: 50),
          FooterOfDrawer(),
          SizedBox(height:20)
        ],
      )),
    );
  }
}

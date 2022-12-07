import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widget/linechart.dart';
import 'page_dua.dart';

import 'package:get/get.dart';
import '../controllers/controller.dart';

class PageSatu extends StatefulWidget {
  @override
  State<PageSatu> createState() => _PageSatuState();
}

class _PageSatuState extends State<PageSatu> with WidgetsBindingObserver {
  _PageSatuState() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print("inactive");
        break;
      case AppLifecycleState.paused:
        print("paused");
        break;
      case AppLifecycleState.detached:
        print("detached");
        break;
      case AppLifecycleState.resumed:
        print("resume");
        break;
      default:
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final database = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    final mediaqueryHeight = MediaQuery.of(context).size.height;
    final mediaqueryWidth = MediaQuery.of(context).size.width;
    final myappbar = AppBar(
      iconTheme: const IconThemeData(color: Color(0xFFF0F0F0)),
      title: const Text(
        "Status Bendungan",
        style: TextStyle(fontFamily: 'Poppins', color: Color(0xFFF0F0F0)),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text("Peringatan Dini"),
                      content: Text(
                          "Apakah anda ingin mengirim notifikasi ke daerah?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Batal"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return PageDua();
                              },
                            ));
                          },
                          child: Text("Lanjutkan"),
                        ),
                      ],
                    );
                  });
            },
            icon: Icon(Icons.notifications_on_outlined))
      ],
    );
    final bodyheight = mediaqueryHeight -
        myappbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final updatestatus = database.child("WLS");
    final itemController = Get.put(getdataController());
    return Scaffold(
        backgroundColor: const Color(0xFF3E497A),
        appBar: myappbar,
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: 110,
                color: const Color(0xFF21325E),
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text(
                        'NS',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        child: const Text("Nurhadi Sutra",
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                color: Color(0xFFF0F0F0))),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return PageDua();
                    },
                  ));
                },
                leading: const Icon(
                  Icons.location_on_outlined,
                  color: const Color(0xFF002989),
                ),
                title: const Text(
                  "Wilayah Suplay",
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color(0xFF002989)),
                ),
              ),
            ],
          ),
        ),
        body: widgetHome(
            itemController: itemController,
            bodyheight: bodyheight,
            mediaqueryWidth: mediaqueryWidth,
            mediaqueryHeight: mediaqueryHeight));
  }
}

class widgetHome extends StatefulWidget {
  const widgetHome({
    Key? key,
    required this.itemController,
    required this.bodyheight,
    required this.mediaqueryWidth,
    required this.mediaqueryHeight,
  }) : super(key: key);

  final getdataController itemController;
  final double bodyheight;
  final double mediaqueryWidth;
  final double mediaqueryHeight;

  @override
  State<widgetHome> createState() => _widgetHomeState();
}

class _widgetHomeState extends State<widgetHome> {
  List<double>? tempList;
  List<double>? tempList2;
  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final itemController = Get.put(getdataController());

    final List<Widget> myData = [
      Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          height: widget.mediaqueryHeight * 0.8,
          width: widget.mediaqueryWidth * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFF0F0F0)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, bottom: 5, top: 5, right: 40),
                  decoration: const BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomRight: const Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: const Color(0xFF21325E)),
                  child: Text(
                    "Ketinggian air",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: widget.bodyheight * 0.2,
                        width: widget.mediaqueryWidth,
                        child: StreamBuilder<QuerySnapshot<Object?>>(
                            stream: itemController.streamData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                var jumlahSensor = snapshot.data!.docs;
                                String kondisi = (jumlahSensor[0].data()
                                    as Map<String, dynamic>)["status_wls"];
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Text(
                                                  "Titik Tertinggi",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF21325E),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                  "43 Mdpl",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xFF21325E)),
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_upward,
                                                color: Colors.red,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width:
                                                widget.mediaqueryWidth * 0.05,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Text(
                                                  "Titik Terendah",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF21325E)),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                  "32 Mdpl",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xFF21325E)),
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_downward,
                                                color: Colors.green,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width:
                                                widget.mediaqueryWidth * 0.03,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Text(
                                                  "Status",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF21325E)),
                                                ),
                                              ),
                                              FittedBox(
                                                child: Container(
                                                  height: 60,
                                                  width: 80,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                    "${(jumlahSensor[0].data() as Map<String, dynamic>)["status_wls"] ?? "Null"}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            Color(0xFF21325E)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat.yMMMMd().format(DateTime.now()),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: const Color(0xFF21325E)),
                              ),
                              SizedBox(
                                width: widget.mediaqueryWidth * 0.35,
                              ),
                              Text(
                                DateFormat.Hm().format(DateTime.now()),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: const Color(0xFF21325E)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: widget.bodyheight * 0.04,
                      ),
                      Center(
                        child: Container(
                          height: widget.bodyheight * 0.4,
                          width: widget.mediaqueryWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: StreamBuilder<QuerySnapshot<Object?>>(
                                  stream: itemController.streamData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(snapshot.error.toString()),
                                      );
                                    }
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }

                                    final data = snapshot.requireData;
                                    Map<String, dynamic> obj = data.docs.first
                                        .data() as Map<String, dynamic>;
                                    double sensor1 = obj["wls"].toDouble();

                                    if (tempList == null) {
                                      tempList = List.filled(5, sensor1,
                                          growable: true);
                                    } else {
                                      tempList!.add(sensor1);
                                      tempList!.removeAt(0);
                                    }
                                    return chart(
                                      bodyheight: widget.bodyheight,
                                      mediaqueryWidth: widget.mediaqueryWidth,
                                      datasensor: tempList!,
                                    );
                                  })),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      )),
      Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          height: widget.mediaqueryHeight * 0.8,
          width: widget.mediaqueryWidth * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFF0F0F0)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, bottom: 5, top: 5, right: 40),
                  decoration: const BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomRight: const Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: const Color(0xFF21325E)),
                  child: Text(
                    "Curah Hujan",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: widget.bodyheight * 0.2,
                        width: widget.mediaqueryWidth,
                        child: StreamBuilder<QuerySnapshot<Object?>>(
                            stream: itemController.streamData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                var jumlahSensor = snapshot.data!.docs;
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Text(
                                                  "Titik Tertinggi",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF21325E),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                  "150.0 MM",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xFF21325E)),
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_upward,
                                                color: Colors.red,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width:
                                                widget.mediaqueryWidth * 0.05,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Text(
                                                  "Titik Terendah",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF21325E)),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                  "0 MM",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xFF21325E)),
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_downward,
                                                color: Colors.green,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width:
                                                widget.mediaqueryWidth * 0.03,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Text(
                                                  "Status",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF21325E)),
                                                ),
                                              ),
                                              FittedBox(
                                                child: Container(
                                                  width: 80,
                                                  height: 60,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                    "${(jumlahSensor[0].data() as Map<String, dynamic>)["status_rain"] ?? "Null"}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xFF21325E)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat.yMMMMd().format(DateTime.now()),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: const Color(0xFF21325E)),
                              ),
                              SizedBox(width: widget.mediaqueryWidth * 0.35),
                              Text(
                                DateFormat.Hm().format(DateTime.now()),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: const Color(0xFF21325E)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: widget.bodyheight * 0.04,
                      ),
                      Center(
                        child: Container(
                          height: widget.bodyheight * 0.4,
                          width: widget.mediaqueryWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: StreamBuilder<QuerySnapshot<Object?>>(
                                  stream: itemController.streamData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(snapshot.error.toString()),
                                      );
                                    }
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }

                                    final data = snapshot.requireData;
                                    Map<String, dynamic> obj = data.docs.first
                                        .data() as Map<String, dynamic>;
                                    double sensor2 =
                                        obj["raingauge"].toDouble();

                                    if (tempList2 == null) {
                                      tempList2 = List.filled(5, sensor2,
                                          growable: true);
                                    } else {
                                      tempList2!.add(sensor2);
                                      tempList2!.removeAt(0);
                                    }
                                    return chart(
                                      bodyheight: widget.bodyheight,
                                      mediaqueryWidth: widget.mediaqueryWidth,
                                      datasensor: tempList2!,
                                    );
                                  })),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      )),
    ];

    return GetBuilder<getdataController>(
        // initState: (state) => print("initstate"),
        // didChangeDependencies: (state) => print("didChange"),
        // didUpdateWidget: (oldwidget, state) => print("initstate"),
        // dispose: (state) => print("dispose"),
        builder: (c) {
      return Column(children: [
        CarouselSlider(
          items: myData,
          carouselController: _controller,
          options: CarouselOptions(
              viewportFraction: 1,
              height: widget.bodyheight * 0.9,
              autoPlay: false,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: myData.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Color.fromARGB(255, 255, 255, 255))
                        .withOpacity(_current == entry.key ? 0.9 : 0.1)),
              ),
            );
          }).toList(),
        ),
      ]);
    });
  }
}

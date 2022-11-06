import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/page_satu.dart';
import 'package:flutter_application_1/widget/linechart.dart';
import 'package:get/get.dart';
import '../controllers/controller.dart';

import '../widget/linechart.dart';

class PageDua extends StatefulWidget {
  const PageDua({Key? key}) : super(key: key);
  @override
  State<PageDua> createState() => _PageDuaState();
}

class _PageDuaState extends State<PageDua> {
  List<double>? tempList;
  final database = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    final mediaqueryHeight = MediaQuery.of(context).size.height;
    final mediaqueryWidth = MediaQuery.of(context).size.width;
    final myappbar = AppBar(
      iconTheme: const IconThemeData(color: Color(0xFFF0F0F0)),
      title: const Text(
        "Wilayah Suplay",
        style: TextStyle(fontFamily: 'Poppins', color: Color(0xFFF0F0F0)),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return PageSatu();
            },
          ));
        },
        icon: Icon(Icons.arrow_back),
      ),
    );
    final bodyheight = mediaqueryHeight -
        myappbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final updatestatus = database.child("WLS");
    final itemController = Get.put(getdataController());
    return Scaffold(
      appBar: myappbar,
      body: GetBuilder<getdataController>(builder: (c) {
        return Center(
            child: StreamBuilder<QuerySnapshot<Object?>>(
                stream: itemController.streamData(),
                builder: (context, snapshot) {
                  return Center(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFFDEDEDE)),
                          height: bodyheight * 0.40,
                          width: mediaqueryWidth * 0.9,
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
                                  "Kabupaten Wajo",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextButton(
                                  onPressed: () async {
                                    await updatestatus.update({'wilayah': 1});
                                    Get.defaultDialog(
                                      barrierDismissible: false,
                                      textCancel: "Batalkan",
                                      cancelTextColor: Colors.green,
                                      onCancel: () async {
                                        await updatestatus
                                            .update({'status': 0});
                                      },
                                      title: "Kirim Informasi",
                                      titleStyle: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                      middleText:
                                          "Pilih Jenis Informasi yang ingin dikirim",
                                      middleTextStyle: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              await updatestatus
                                                  .update({'status': 1});
                                            },
                                            child: Text(
                                              "Waspada",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  color: Colors.blue),
                                            )),
                                        TextButton(
                                            onPressed: () async {
                                              await updatestatus
                                                  .update({'status': 2});
                                            },
                                            child: Text("Siaga",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: Colors.yellow))),
                                        TextButton(
                                            onPressed: () async {
                                              await updatestatus
                                                  .update({'status': 3});
                                            },
                                            child: Text("Awas",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: Colors.red))),
                                      ],
                                    );
                                  },
                                  child: Text(
                                    "Wilayah Ana'banua",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF21325E)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextButton(
                                    onPressed: () async {
                                      await updatestatus.update({'wilayah': 2});
                                      Get.defaultDialog(
                                        barrierDismissible: false,
                                        onCancel: () async {
                                          await updatestatus
                                              .update({'status': 0});
                                        },
                                        textCancel: "Batalkan",
                                        cancelTextColor: Colors.green,
                                        title: "Kirim Informasi",
                                        titleStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16),
                                        middleText:
                                            "Pilih Jenis Informasi yang ingin dikirim",
                                        middleTextStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                await updatestatus
                                                    .update({'status': 1});
                                              },
                                              child: Text(
                                                "Waspada",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: Colors.blue),
                                              )),
                                          TextButton(
                                              onPressed: () async {
                                                await updatestatus
                                                    .update({'status': 2});
                                              },
                                              child: Text("Siaga",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: Colors.yellow))),
                                          TextButton(
                                              onPressed: () async {
                                                await updatestatus
                                                    .update({'status': 3});
                                              },
                                              child: Text("Awas",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: Colors.red))),
                                        ],
                                      );
                                    },
                                    child: Text("Wilayah Salodua",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF21325E)))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextButton(
                                    onPressed: () async {
                                      await updatestatus.update({'wilayah': 3});
                                      Get.defaultDialog(
                                        barrierDismissible: false,
                                        textCancel: "Batalkan",
                                        cancelTextColor: Colors.green,
                                        onCancel: () async {
                                          await updatestatus
                                              .update({'status': 0});
                                        },
                                        title: "Kirim Informasi",
                                        titleStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16),
                                        middleText:
                                            "Pilih Jenis Informasi yang ingin dikirim",
                                        middleTextStyle: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                await updatestatus
                                                    .update({'status': 1});
                                              },
                                              child: Text(
                                                "Waspada",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: Colors.blue),
                                              )),
                                          TextButton(
                                              onPressed: () async {
                                                await updatestatus
                                                    .update({'status': 2});
                                              },
                                              child: Text("Siaga",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: Colors.yellow))),
                                          TextButton(
                                              onPressed: () async {
                                                await updatestatus
                                                    .update({'status': 3});
                                              },
                                              child: Text("Awas",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: Colors.red))),
                                        ],
                                      );
                                    },
                                    child: Text("Wilayah Tancung",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF21325E)))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextButton(
                                  onPressed: () async {
                                    await updatestatus.update({'wilayah': 4});
                                    Get.defaultDialog(
                                      barrierDismissible: false,
                                      textCancel: "Batalkan",
                                      cancelTextColor: Colors.green,
                                      onCancel: () async {
                                        await updatestatus
                                            .update({'status': 0});
                                      },
                                      title: "Kirim Informasi",
                                      titleStyle: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                      middleText:
                                          "Pilih Jenis Informasi yang ingin dikirim",
                                      middleTextStyle: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              await updatestatus
                                                  .update({'status': 1});
                                            },
                                            child: Text(
                                              "Waspada",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  color: Colors.blue),
                                            )),
                                        TextButton(
                                            onPressed: () async {
                                              await updatestatus
                                                  .update({'status': 2});
                                            },
                                            child: Text("Siaga",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: Colors.yellow))),
                                        TextButton(
                                            onPressed: () async {
                                              await updatestatus
                                                  .update({'status': 3});
                                            },
                                            child: Text("Awas",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: Colors.red))),
                                      ],
                                    );
                                  },
                                  child: Text(
                                    "Wilayah Pajalele",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF21325E)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  );
                }));
      }),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'model/user.dart';

class TodayScreen extends StatefulWidget {


  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  double screenHeight = 0;
  double screenWidth = 0;




  Color primary =  const Color(0xffeef444c);
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 35),
              child: Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "Silkscreen",
                  fontSize: screenWidth / 20,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "User " + User.username ,
                style: TextStyle(
                  color: Colors.black,
                  // fontFamily: "Silkscreen",
                  fontSize: screenWidth / 14,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 35),
              child: Text(
                "Today's Status",
                style: TextStyle(
                  // color: Colors.black54,
                  // fontFamily: "Silkscreen",
                  fontSize: screenWidth / 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 32 ),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2,2),
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "check In",
                            style: TextStyle(
                              fontSize: screenWidth / 20,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                              "09:30",
                            style: TextStyle(
                              fontFamily: "Silkscreen",
                                fontSize: screenWidth / 18,
                            ),
                          ),
                        ],
                      ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "check Out", style: TextStyle(
                      fontSize: screenWidth / 20,
                      color: Colors.black54,
                        ),
                        ),
                        Text(
                          "--:--",
                          style: TextStyle(
                            fontFamily: "Silkscreen",
                            fontSize: screenWidth / 18,
                          ),),
                      ],
                    ),
                  ),
                ],

              )
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: DateTime.now().day.toString(),
                  style: TextStyle(
                    color: primary,
                    fontSize: screenWidth / 18,
                    fontFamily: "Silkscreen",
                  ),
                  children: [
                    TextSpan(
                      text: DateFormat(' MMM yyyy').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth / 20,
                      )
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                  DateFormat('hh:mm:ss a').format(DateTime.now()),
                    style: TextStyle(
                      fontFamily: "Silkscreen",
                      fontSize: screenWidth / 20,
                      color: Colors.black54,
                    ),
                  ),
                );
              }
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Builder(
                  builder: (context) {
                    final GlobalKey<SlideActionState> key = GlobalKey();

                    return SlideAction(
                      text: "Slide to Check In",
                      textStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: screenWidth / 20,
                      ),
                      outerColor: Colors.white,
                      innerColor: primary,

                      key: key,
                      onSubmit: () async {
                        print(DateFormat('hh:mm').format(DateTime.now()));
                        
                        QuerySnapshot snap = await FirebaseFirestore.instance
                        .collection('User')
                        .where('id', isEqualTo: User.username)
                        .get();

                        print(snap.docs[0].id);

                        // StreamBuilder(
                        //   stream: FirebaseFirestore.instance.collection("User")
                        //       .orderBy("id", descending: false).snapshots() ,
                        //
                        //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                        //
                        //     if(snapshot.hasData)
                        //     {
                        //       return ListView.builder(
                        //         itemCount: snapshot.data?.docs.length,
                        //         padding: const EdgeInsets.only( top: 20.0),
                        //         itemBuilder: (BuildContext context, int index)
                        //         {
                        //           DocumentSnapshot ds = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                        //         },
                        //       );
                        //     }
                        //
                        //   },
                        // );

                        // var arr = User.username;
                        //
                        // for (var i=0; i < 4; i++) {
                        //   print(arr[i]);
                        //}
                      },
                    );
                  },
              ),
            ),
          ],
        ),
      )
    );
  }
}

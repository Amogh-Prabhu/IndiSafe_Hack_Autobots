import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:kavach/utils/kavach_theme.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  List<String> num = [
    "100",
    "101",
    "102",
    "103",
    "108",
    "112",
    "182",
    "1073",
    "1098"
  ];
  List<String> details = [
    "Police",
    "Fire Service",
    "Pregnancy Medic",
    "Mahila Helpline Mumbai",
    "Ambulance",
    "National Helpline",
    "Railway Protection",
    "Road Accident",
    "Women Helpline"
  ];
  List<Widget> i = [
    const Icon(Icons.local_police),
    const Icon(Icons.fire_truck),
    const Icon(Icons.child_care),
    const Icon(Icons.woman),
    const Icon(Icons.local_hospital),
    const Icon(Icons.map),
    const Icon(Icons.train),
    const Icon(Icons.car_crash),
    const Icon(Icons.woman_2),
    ];

  _callNumber(String n) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(n);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Kavach",
          style: KavachTheme.titleText(
              size: width / 13,
              weight: FontWeight.w600,
              color: KavachTheme.lightPink),
        ),
        actions: [
          Icon(
            CupertinoIcons.bell,
            color: KavachTheme.nearlyGrey,
            size: width / 16,
          ),
          const SizedBox(
            width: 20,
          ),
          Icon(
            Icons.menu,
            color: KavachTheme.nearlyGrey,
            size: width / 14,
          ),
          const SizedBox(
            width: 20,
          ),
    ],

),
      body: 
      Column(
        children: [Padding(
            padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Track Me",
                  style: KavachTheme.titleText(
                      size: width / 18,
                      weight: FontWeight.normal,
                      color: KavachTheme.nearlyGrey),
                ),
                Text("Share live location with your friends",
                    style: KavachTheme.subtitleText(
                        size: width / 28,
                        weight: FontWeight.normal,
                        color: KavachTheme.nearlyGrey.withOpacity(0.7)))
              ],
           ),
          
),
          Expanded(
            child: ListView.builder(
                itemCount: details.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    
                    child: ListTile(
                        leading: i[index],
                        trailing: IconButton(
                          icon: const Icon(Icons.call),
                          onPressed: () async {
                            await _callNumber(num[index]);
                          },
                        ),
                        title: Text(num[index]),
                        subtitle: Text(details[index])),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

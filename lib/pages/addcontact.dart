import 'package:flutter/material.dart';

class addcontact extends StatefulWidget {
  const addcontact({super.key});

  @override
  State<addcontact> createState() => _addcontactState();
}

class _addcontactState extends State<addcontact> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[900],
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Adding',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange[900]!,
            Colors.orange[800]!,
            Colors.orange[400]!
          ])),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 400,
                width: MediaQuery.sizeOf(context).width,
                // color: Color.fromARGB(255, 253, 253, 253),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const CircleAvatar(
                  radius: 350,
                  backgroundImage: NetworkImage(
                      'https://cdn.discordapp.com/attachments/1035813890535206975/1180443968887078922/connect.png?ex=657d711d&is=656afc1d&hm=f96911fb1aed3c69e089c4bde490aee7ad34f31c1be55e1c930d147bee7b2046&'),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.sizeOf(context).height - 496,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(225, 95, 27, .3),
                            // spreadRadius: 5,
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      height: 40,
                      width: 400,
                      child: const Text(
                        'Enter Email',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Color.fromARGB(255, 230, 81, 0),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(247, 86, 0, 0.298),
                            // spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      height: 40,
                      width: 400,
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

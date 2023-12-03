import 'package:flutter/material.dart';

class groupdisplay extends StatefulWidget {
  final String pfpurl;
  final String username;
  final String email;
  const groupdisplay(
      {super.key,
      required this.pfpurl,
      required this.username,
      required this.email});

  @override
  State<groupdisplay> createState() => _groupdisplayState();
}

class _groupdisplayState extends State<groupdisplay> {
  ElevatedButton iconbutt(IconData a, String b) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
      child: Container(
        color: Colors.white,
        height: 60.0,
        alignment: Alignment.topLeft,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 5,
              top: 20,
              child: Icon(
                a,
                color: Colors.black,
              ),
            ),
            Positioned(
              left: 55,
              top: 20,
              child: Text(
                b,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton ikonbutt(IconData a, String b) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange[400],
      ),
      child: Container(
        color: Colors.orange[400],
        height: 60.0,
        alignment: Alignment.topLeft,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 5,
              top: 20,
              child: Icon(
                a,
                color: Colors.red,
              ),
            ),
            Positioned(
              left: 55,
              top: 20,
              child: Text(
                b,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container pengguna(String url, String nama, String decs) {
    return Container(
      color: Colors.white,
      height: 50.0,
      width: 400,
      alignment: Alignment.centerLeft,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 5,
            left: 5,
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                url,
              ),
            ),
          ),
          Positioned(
            left: 60,
            top: 5,
            child: Text(
              nama,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Positioned(
            left: 60,
            top: 25,
            child: Text(
              decs,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[900],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            children: [
              SizedBox(width: 10.0),
              Text(widget.username),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 220, 220, 220),
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(children: [
              Container(
                color: Colors.orange[700],
                height: 20,
              )
            ]),
            Stack(
              children: [
                Container(
                  color: Colors.orange[700],
                  width: 400,
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.orange[700],
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                      widget.pfpurl,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 70.0,
              width: 400,
              color: Colors.orange[700],
              child: const Stack(
                children: [
                  Positioned(
                    left: 220,
                    top: 10,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  Positioned(
                    left: 220,
                    top: 50,
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 140,
                    top: 10,
                    child: Icon(
                      Icons.add_ic_call_sharp,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  Positioned(
                    left: 135,
                    top: 50,
                    child: Text(
                      'Voice Call',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 3),
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              height: 70.0,
              width: 400,
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Text(
                      widget.username,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 40,
                    child: Text(
                      widget.email,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              height: 30.0,
              width: 400,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Media, links, and docs',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '80>',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            Container(
              color: Colors.orange[500],
              height: 160,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          child: Image.network(
                            'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg',
                            width: 200, // Set the width of the image
                            height: 150,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/RedCat_8727.jpg/1200px-RedCat_8727.jpg',
                            width: 200, // Set the width of the image
                            height: 150,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 3),
            iconbutt(
              Icons.notifications,
              'Mute notifications',
            ),
            iconbutt(
              Icons.music_note,
              'Custom notifications',
            ),
            iconbutt(
              Icons.collections,
              'Media visibility',
            ),
            const SizedBox(height: 3),
            iconbutt(
              Icons.lock,
              'Encryption',
            ),
            iconbutt(
              Icons.timer,
              'Dissapearing meassages',
            ),
            iconbutt(
              Icons.luggage,
              'Chat lock',
            ),
            const SizedBox(height: 3),
            Container(
              color: Colors.white,
              height: 30.0,
              alignment: Alignment.topLeft,
              child: const Row(),
            ),
            const SizedBox(height: 1.0),
          ]),
        ),
      ),
    );
  }
}

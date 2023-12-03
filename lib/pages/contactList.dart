import 'package:chat_app/pages/customer_service.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'add_contact.dart';

void main() {
  runApp(const ContactList());
}

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  Container invite(String url, String nama, String desc) {
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
              desc,
              style: const TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
            ),
          ),
          const Positioned(
            left: 340,
            top: 20,
            child: Text(
              'Invite',
              style: TextStyle(color: Color.fromARGB(255, 0, 109, 4)),
            ),
          ),
        ],
      ),
    );
  }

  Container icon(IconData a, String b) {
    return Container(
      color: Colors.white,
      height: 60.0,
      alignment: Alignment.topLeft,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            top: 20,
            child: Icon(
              a,
              color: Colors.black,
            ),
          ),
          Positioned(
            left: 70,
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
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[900],
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Connect With New People',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 77, 77, 77),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddContact()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: Container(
                  color: Colors.white,
                  height: 60.0,
                  alignment: Alignment.topLeft,
                  child: const Stack(
                    children: <Widget>[
                      Positioned(
                        left: 5,
                        top: 20,
                        child: Icon(
                          Icons.group_add_rounded,
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 20,
                        child: Text(
                          'New contact',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.orange[700],
                height: 35.0,
                alignment: Alignment.centerLeft,
                child: const Text(
                  '   Contacts list',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              //add contacts list

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddContact()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: Container(
                  color: Colors.white,
                  height: 60.0,
                  alignment: Alignment.topLeft,
                  child: const Stack(
                    children: <Widget>[
                      Positioned(
                        left: 5,
                        top: 20,
                        child: Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 20,
                        child: Text(
                          'Share invite link',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => customerservice()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: Container(
                  color: Colors.white,
                  height: 60.0,
                  alignment: Alignment.topLeft,
                  child: const Stack(
                    children: <Widget>[
                      Positioned(
                        left: 5,
                        top: 20,
                        child: Icon(
                          Icons.question_mark_rounded,
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 20,
                        child: Text(
                          'Contacts help',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Container pengguna(String url, String nama, String desc) {
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
        ],
      ),
    );
  }

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[900],
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Contact',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              Text(
                '10 contacts',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
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
              iconbutt(
                Icons.group_rounded,
                'New group',
              ),
              ElevatedButton(
                onPressed: () {},
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
              iconbutt(
                Icons.groups_rounded,
                'New community',
              ),
              Container(
                color: Colors.orange[700],
                height: 30.0,
                alignment: Alignment.centerLeft,
                child: const Text(
                  '   Discover',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              iconbutt(
                Icons.store_rounded,
                'Business',
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
              pengguna(
                  'https://www.the-sun.com/wp-content/uploads/sites/6/2023/10/www-instagram-com-monkeycatluna-hl-851711797.jpg',
                  'Wilson Alfando',
                  'Hey there!'),
              pengguna(
                'https://i.kym-cdn.com/entries/icons/facebook/000/043/403/cover3.jpg',
                'Jason Wiedardi',
                'Available',
              ),
              pengguna(
                'https://i.chzbgr.com/full/9627057664/h1D0FB5A3/cat',
                'Daffa Prawira',
                'Cant talk right now',
              ),
              pengguna(
                'https://i.pinimg.com/736x/4d/8e/cc/4d8ecc6967b4a3d475be5c4d881c4d9c.jpg',
                'Gerry Dominiki',
                'Ahli Telepati',
              ),
              pengguna(
                'https://i.pinimg.com/736x/12/56/00/1256000a71e6e0fbcd09c8505529889f.jpg',
                'Willy Michael',
                'Halo',
              ),
              pengguna(
                'https://www.newshub.co.nz/home/lifestyle/2019/08/the-top-five-cat-memes-of-all-time-rated/_jcr_content/par/video/image.dynimg.1280.q75.jpg/v1565234972425/KNOWYOURMEME-sad-cat-crying-1120.jpg',
                'Benevito Kevin',
                'Sibuk',
              ),
              pengguna(
                'https://pbs.twimg.com/media/C4kfypsW8AAGQD-.jpg',
                'Muhammad Raffi hermawan',
                'This is cogil !!',
              ),
              pengguna(
                  'https://i.pinimg.com/236x/19/1e/7d/191e7dae2ca6c26759c35bf54d4dd0ff.jpg',
                  'Randy Censon',
                  'The official Demon Lord'),
              pengguna(
                'https://imgb.ifunny.co/images/585dd6ce4d23c7e3d913e05e4b5d6305fe5f50384e2b595e1101361f9bcc8e9f_1.jpg',
                'Christ Thadeus',
                'Halo',
              ),
              pengguna(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxKEQMYN4n98-VGxFG_s4lWpe0p3XfDtmOrQ&usqp=CAU',
                'Pentung G',
                'Pohon',
              ),
              Container(
                color: Colors.orange[700],
                height: 35.0,
                alignment: Alignment.centerLeft,
                child: const Text(
                  '   Recommended people',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              invite(
                'https://videogames.si.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_700/MTk0NDYyNDk4NzQ4MTE0NDM3/elden-ring-general-radahn-boss-k.webp',
                'Starscourge Radahn',
                'Naik kuda pony',
              ),
              invite(
                'https://videogames.si.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_700/MTk0NDYyNDk4NzQ3OTgzMzY1/godfrey-first-elden-lord-hoarah.webp',
                'Godfrey, First Elden Lord and Hoarah Loux',
                'Macan ngaung',
              ),
              invite(
                'https://videogames.si.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_700/MTk0NDYyNDk4NDc5NDgyMzcz/elden-beast-boss-elden-ring-wiki.webp',
                'Elden Beast',
                '...',
              ),
              iconbutt(
                Icons.share,
                'Share invite link',
              ),
              iconbutt(
                Icons.question_mark_rounded,
                'Contacts help',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

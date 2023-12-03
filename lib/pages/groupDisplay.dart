import 'package:flutter/material.dart';

void main() {
  runApp(const groupDisplay());
}

class groupDisplay extends StatelessWidget {
  const groupDisplay({super.key});

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
          title: const Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                  'https://t4.ftcdn.net/jpg/05/59/37/55/360_F_559375590_3iHYtFS3pAFtBnH5pq65jH5t3d6VkjPD.jpg',
                ),
              ),
              SizedBox(width: 10.0),
              Text('Grup Mob Prog'),
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
          child: Column(
            children: [
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
                alignment: Alignment.centerLeft,
                height: 70.0,
                width: 400,
                child: const Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 10,
                      child: Text(
                        'Add group description',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 40,
                      child: Text(
                        'Group created by: Wilson Alfando, 13/06/20',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
                    Text(
                      'Media, links, and docs',
                      style: TextStyle(color: Colors.black),
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
                child: const Row(
                  children: [
                    Text(
                      '6 participants',
                      style: TextStyle(color: Colors.black),
                    ),
                    Spacer(),
                    Icon(
                      Icons.search,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 1.0),
              Container(
                color: Colors.white,
                height: 50.0,
                width: 400,
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: <Widget>[
                    const Positioned(
                      top: 5,
                      left: 5,
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          'https://www.the-sun.com/wp-content/uploads/sites/6/2023/10/www-instagram-com-monkeycatluna-hl-851711797.jpg',
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 60,
                      top: 5,
                      child: Text(
                        'Wilson Alfando',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const Positioned(
                      left: 60,
                      top: 25,
                      child: Text(
                        'Hey There!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Positioned(
                      left: 280,
                      top: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.orange[400],
                        ),
                        height: 20.0,
                        width: 100,
                        child: const Row(
                          children: [
                            Text(
                              '   Group Admin',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 1.0),
              pengguna(
                'https://i.kym-cdn.com/entries/icons/facebook/000/043/403/cover3.jpg',
                'Jason Wiedardi',
                'Available',
              ),
              const SizedBox(height: 1.0),
              pengguna(
                'https://i.chzbgr.com/full/9627057664/h1D0FB5A3/cat',
                'Daffa Prawira',
                'Cant talk right now',
              ),
              const SizedBox(height: 1.0),
              pengguna(
                'https://i.pinimg.com/736x/4d/8e/cc/4d8ecc6967b4a3d475be5c4d881c4d9c.jpg',
                'Gerry Dominiki',
                'Ahli Telepati',
              ),
              const SizedBox(height: 1.0),
              pengguna(
                'https://i.pinimg.com/736x/12/56/00/1256000a71e6e0fbcd09c8505529889f.jpg',
                'Willy Michael',
                'Halo',
              ),
              const SizedBox(height: 1.0),
              pengguna(
                'https://www.newshub.co.nz/home/lifestyle/2019/08/the-top-five-cat-memes-of-all-time-rated/_jcr_content/par/video/image.dynimg.1280.q75.jpg/v1565234972425/KNOWYOURMEME-sad-cat-crying-1120.jpg',
                'Benevito Kevin',
                'Sibuk',
              ),
              const SizedBox(height: 3.0),
              ikonbutt(
                Icons.exit_to_app,
                'Exit Group',
              ),
              ikonbutt(
                Icons.thumb_down,
                'Report group',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
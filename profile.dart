import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0.0,
        leading: Container(
          margin: const EdgeInsets.all(10),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 2, 2, 2),
            ),
          ),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              //
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 220,
            height: 200,
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 25,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fpin%2Fgregor-limbus-in-2023--139541288446844516%2F&psig=AOvVaw3BXv9kdnPY-5tVvCwpmQ40&ust=1701531618629000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCJCV8a7J7oIDFQAAAAAdAAAAABAE"),
                    radius: 90,
                  ),
                ),
                Positioned(
                    top: 150,
                    left: 150,
                    child: Container(

                ),
                ),
              ],
            ),
          ),
          Container(
            width: 400,
            height: 80,
            // decoration: BoxDecoration(color: Colors.grey),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 150,
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 135,
                  child: Text(
                    'telolet@gmail',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              
              
              ],
            ),
          ),
          Container(
            width: 400,
            height: 200,
            // decoration: BoxDecoration(color: const Color.fromARGB(255, 176, 76, 76)),
            child:
            Stack(
              children: [
                
                Positioned(
                  top: 10,
                  left: 100,
                  child: Text("status........",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                 

                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

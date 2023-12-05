import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ).copyWith(top: 75),
                child: Text(
                  "Maya",
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.teal,
                    fontFamily: "Cera Pro",
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ///Text Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  width: size.width * 0.82,
                  padding: EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: _searchController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (value){
                      setState(() {

                      });
                    },
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: "Ask anything.",
                      hintStyle: TextStyle(
                        color: Colors.white54,
                        fontFamily: "Cera Pro",
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                      border: InputBorder.none,
                    ),
                  ),
                ),

                ///Button
                _searchController.text.length == 0
                    ? mic()
                    : IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.send,size: 35,),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mic(){
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.mic,size: 35,),
    );
  }
}

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/screens/homescreen.dart';
import 'package:friendly_gaming/src/widgets/avatar.dart';
import 'package:friendly_gaming/src/widgets/game_selector.dart';
import 'package:friendly_gaming/src/widgets/score_selector.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Add Post', style: TextStyle(color: Colors.black)),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Select Persons',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Form(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: TextField(
                              decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'Search Persons',
                                  border: InputBorder.none,
                                  // focusedBorder: InputBorder.none,
                                  prefixIcon: Icon(Icons.search),
                                  fillColor: Colors.grey[100])),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 24.0),
              Container(
                height: 80,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) =>
                        Avatar(size: 50, image: 'img1.jpg', name: 'James')),
              ),
              SizedBox(height: 24.0),
              Text(
                'Above Selected',
                style: TextStyle(
                    color: Colors.yellow[700],
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Avatar(size: 100, image: 'img4.png', name: 'James'),
                  Text(
                    'VS',
                    style: TextStyle(
                        color: Colors.yellow[700],
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800),
                  ),
                  Avatar(size: 100, image: 'img6.png', name: 'Zubby'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Score',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'Score',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      width: 130,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0)),
                      child: ScoreSelector(
                        onSelect: (int s) {
                          print(s);
                        },
                      )),
                  SizedBox.shrink(),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      width: 130,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0)),
                      child: ScoreSelector(
                        onSelect: (int s) {
                          print(s);
                        },
                      )),
                ],
              ),
              SizedBox(height: 32.0),
              Row(
                children: [
                  Text(
                    'Select Games',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Form(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: TextField(
                              decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'Search Game',
                                  border: InputBorder.none,
                                  // focusedBorder: InputBorder.none,
                                  prefixIcon: Icon(Icons.search),
                                  fillColor: Colors.grey[100])),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: GameSelector(
                    onGameSelected: (game) {
                      print(game);
                    },
                  )),
              SizedBox(
                height: 16.0,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Add Images',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18))),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: DottedBorder(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.grey,
                        child: Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: DottedBorder(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.grey,
                        child: Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: DottedBorder(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.grey,
                        child: Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 32),
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text(
                    'POST',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

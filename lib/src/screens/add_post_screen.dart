import 'package:flutter/material.dart';
import 'package:friendly_gaming/src/widgets/avatar.dart';

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
            onPressed: () {}),
      ),
      body: Container(
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
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                  color: Colors.yellow[300],
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
                      color: Colors.yellow[300],
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800),
                ),
                Avatar(size: 100, image: 'img6.png', name: 'Zubby'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Score', textAlign: TextAlign.center, style: TextStyle(color:Colors.blue,fontSize: 16.0,fontWeight: FontWeight.w800),),
                Text('Score',textAlign:TextAlign.center, style: TextStyle(color:Colors.blue,fontSize: 16.0,fontWeight: FontWeight.w800),),
              ],
            )
          ],
        ),
      ),
    );
  }
}

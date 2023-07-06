import 'package:flutter/material.dart';

class DudPage extends StatelessWidget {
  const DudPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.amber],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Container(
              child: IconButton(
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                mouseCursor: MouseCursor.defer,
                icon: Icon(Icons.favorite_outline_rounded,
                    color: Colors.transparent),
                onPressed: () {
                  print("object");
                },
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(50),
                constraints:
                    BoxConstraints(maxWidth: 400.0, minHeight: screenHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 12),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "",
                        style: TextStyle(
                          color: Colors.amber,
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          decorationThickness: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

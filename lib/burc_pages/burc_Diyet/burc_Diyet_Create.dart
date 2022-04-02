import 'package:flutter/material.dart';

class BurcDiyetCreate extends StatelessWidget {
  final List baslikDetayAd;
  BurcDiyetCreate({required List<String> this.baslikDetayAd, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(baslikDetayAd[0]),
      ),
      body: Container(
        color: Colors.orange,
        child: Stack(
          fit: StackFit.loose,
          children: [
            SizedBox(
              // width: 360,
              height: 219,
              child: Image.asset(
                'assets/images/diyet_image/${baslikDetayAd[2]}.jpg',
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.65,
              builder: (context, scrollController) {
                return Container(
                  color: Colors.blue.shade900,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          baslikDetayAd[1],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BurcItem extends StatelessWidget {
  final listenenBurc;
  const BurcItem({required this.listenenBurc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    var UserThemeStyle = Theme.of(context).textTheme;
    return Card(
      color: Colors.yellow.shade100,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: ListTile(
          leading: Image.asset(
            "assets/images/" + listenenBurc.burcKucukResim,
          ),
          title: Text(
            listenenBurc.burcAdi,
            style: UserThemeStyle.headline5,
          ),
          subtitle: Text(
            listenenBurc.burcTarihi,
            style: UserThemeStyle.subtitle1,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.lightBlue,
          ),
          onTap: () {
            Navigator.pushNamed(context, 'PageCreate', arguments: listenenBurc);
          },
        ),
      ),
    );
  }
}

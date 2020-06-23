import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../models/product.dart';

class RoundTypeButton extends StatefulWidget {
  final Color color;
  final String image;
  final String title;
  RoundTypeButton(
      {@required this.color, @required this.image, @required this.title});

  @override
  _RoundTypeButtonState createState() => _RoundTypeButtonState();
}

class _RoundTypeButtonState extends State<RoundTypeButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints.tightFor(
            width: 50.0,
            height: 50.0,
          ),
          onPressed: () {
            setState(() {
              List<Product> currentList =
                  Provider.of<Products>(context).products;
              for (int i = 0; i < currentList.length; i++) {
                switch (widget.title) {
                  case 'Vegan':
                    if (!currentList.elementAt(i).vegetarian)
                      Provider.of<Products>(context).clearProduct();
                    break;
                  case 'DairyFree':
                    if (!currentList.elementAt(i).dairyFree)
                      Provider.of<Products>(context)
                          .removeProduct(currentList.elementAt(i));
                    break;
                  case 'LowFodMap':
                    if (!currentList.elementAt(i).dairyFree)
                      Provider.of<Products>(context)
                          .removeProduct(currentList.elementAt(i));
                    break;
                  case 'Cheap':
                    if (!currentList.elementAt(i).cheap)
                      Provider.of<Products>(context)
                          .removeProduct(currentList.elementAt(i));
                    break;
                }
              }
            });
          },
          elevation: 2.0,
          fillColor: widget.color,
          child: Image.asset(
            widget.image,
            fit: BoxFit.cover,
            width: 30.0,
            height: 30.0,
          ),
          shape: CircleBorder(
            side: BorderSide(color: Colors.white),
          ),
        ),
        Text(
          widget.title,
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class RoundTypeButton extends StatefulWidget {
  final Color color;
  final String image;
  final String title;
  final Function function;

  RoundTypeButton(
      {@required this.color,
      @required this.image,
      @required this.title,
      this.function});

  @override
  _RoundTypeButtonState createState() => _RoundTypeButtonState();
}

class _RoundTypeButtonState extends State<RoundTypeButton> {
  bool isActivated = false;
  void sortByCategory() {
    switch (widget.title) {
      case 'Vegan':
        print('vegan called');
        Provider.of<Products>(context).map['Vegan'] =
            !Provider.of<Products>(context).map['Vegan'];
        print(Provider.of<Products>(context).map['Vegan']);
        Provider.of<Products>(context).updateDisplayProduct('Vegan');
        break;
      case 'DairyFree':
        Provider.of<Products>(context).map['DairyFree'] =
            !Provider.of<Products>(context).map['DairyFree'];
        Provider.of<Products>(context).updateDisplayProduct('DairyFree');
        break;
      case 'LowFodMap':
        Provider.of<Products>(context).map['LowFodMap'] =
            !Provider.of<Products>(context).map['LowFodMap'];
        Provider.of<Products>(context).updateDisplayProduct('LowFodMap');
        break;
      case 'Cheap':
        Provider.of<Products>(context).map['cheap'] =
            !Provider.of<Products>(context).map['cheap'];
        Provider.of<Products>(context).updateDisplayProduct('cheap');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 33,
            color: Color(0xFFF8D377).withOpacity(.60),
          ),
        ],
        color: isActivated
            ? Colors.orangeAccent.withOpacity(0.3)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: <Widget>[
          RawMaterialButton(
            constraints: BoxConstraints.tightFor(
              width: 50.0,
              height: 50.0,
            ),
            onPressed: () {
              isActivated = !isActivated;
              sortByCategory();
            },
            elevation: 1.0,
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
      ),
    );
  }
}

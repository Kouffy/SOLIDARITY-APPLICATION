
import 'package:flutter/material.dart';
import 'package:solidarite/Helpers/SizeConfig.dart';


class DualRadioButtonCard extends StatefulWidget {
  final String title;
  final int selectedValue;
  final String option1;
  final String option2;
  final Function onChanged;

  DualRadioButtonCard(
      {Key key,
      this.title,
      this.option1,
      this.option2,
      this.onChanged,
      this.selectedValue})
      : super(key: key);

  @override
  DualRadioOptionCardState createState() => DualRadioOptionCardState();
}
class DualRadioOptionCardState extends State<DualRadioButtonCard> {
  int selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = -1;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Card(
      color: Colors.blue[50],
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 5, top: 10),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Radio(
                value: 0,
                activeColor: Colors.white,
                groupValue: widget.selectedValue,
                onChanged: widget.onChanged,
              ),
              Text(widget.option1),
              SizedBox(
                width: 50,
              ),
              Radio(
                value: 1,
                activeColor: Colors.white,
                groupValue: widget.selectedValue,
                onChanged: widget.onChanged,
              ),
              Text(widget.option2),
            ])
          ]),
    );
  }
}
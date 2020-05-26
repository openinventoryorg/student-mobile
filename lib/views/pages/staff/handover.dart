import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_student_app/api/requests/tempreq.dart';
import 'package:openinventory_student_app/controllers/api.dart';
import 'package:openinventory_student_app/helpers.dart';
import 'package:openinventory_student_app/views/pages/components/connection_ball.dart';

class TemperoryHandover extends StatefulWidget {
  @override
  _TemperoryHandoverState createState() => _TemperoryHandoverState();
}

class _TemperoryHandoverState extends State<TemperoryHandover> {
  final String barcodeImage =
      'https://images.vexels.com/media/users/3/157862/isolated/preview/5fc76d9e8d748db3089a489cdd492d4b-barcode-scanning-icon-by-vexels.png';
  TextEditingController idCard;
  TextEditingController serialNumber;
  bool isRecieving;

  @override
  void initState() {
    idCard = TextEditingController();
    serialNumber = TextEditingController();
    isRecieving = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperory Handover'),
        actions: <Widget>[ConnectionBall()],
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Image.network(
              barcodeImage,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width / 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: idCard,
              decoration: InputDecoration(
                labelText: 'Student ID Card Number',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: serialNumber,
              decoration: InputDecoration(
                labelText: 'Serial Number',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheckboxListTile(
              onChanged: (v) {
                setState(() {
                  isRecieving = v;
                });
              },
              value: isRecieving,
              title: Text('Recieve Item'),
              subtitle: Text('Check if the student is returning the item'),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              OutlineButton.icon(
                onPressed: () async {
                  String code = await Helpers.scanQR();
                  if (code != null) {
                    setState(() {
                      idCard.text = code;
                    });
                  }
                },
                icon: Icon(LineIcons.user),
                label: Text('Scan ID Card'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: OutlineButton.icon(
                  icon: Icon(LineIcons.barcode),
                  onPressed: () async {
                    String code = await Helpers.scanQR();
                    if (code != null) {
                      setState(() {
                        serialNumber.text = code;
                      });
                    }
                  },
                  label: Text('Scan SN'),
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton.extended(
          onPressed: () async {
            try {
              String idCardText = idCard.text;
              String snText = serialNumber.text;
              TempRequest tempRequest = TempRequest(idCardText, snText);
              if (isRecieving) {
                await ApiController.of(context)
                    .sendTempReturnRequest(tempRequest);
              } else {
                await ApiController.of(context)
                    .sendTempLendRequest(tempRequest);
              }
              Navigator.pop(context);
            } catch (err) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(err.toString()),
                backgroundColor: Colors.red,
              ));
            }
          },
          label: Text('Submit'),
          icon: Icon(LineIcons.cloud_upload),
        ),
      ),
    );
  }
}

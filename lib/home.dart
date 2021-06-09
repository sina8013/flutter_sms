import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SmsMessage> messages;
  SmsQuery query = new SmsQuery();

  @override
  void initState() {
    super.initState();

    asyncFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SMS Controller"),
      ),
    );
  }

  asyncFunction() async {
    messages = await query.getAllSms;

    SmsReceiver receiver = new SmsReceiver();
    receiver.onSmsReceived.listen(reseve_SMS);
  }

  reseve_SMS(SmsMessage msg) {}

  send_SMS(String number, String msg) {
    SmsSender sender = new SmsSender();
    SmsMessage message = new SmsMessage(number, msg);
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        print("SMS is sent!");
      } else if (state == SmsMessageState.Delivered) {
        print("SMS is delivered!");
      }
    });

    sender.sendSms(message);
  }
}

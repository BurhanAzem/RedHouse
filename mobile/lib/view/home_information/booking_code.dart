import 'package:flutter/material.dart';

class BookingCode extends StatefulWidget {
  final String bookingCode;
  const BookingCode({Key? key, required this.bookingCode}) : super(key: key);

  @override
  State<BookingCode> createState() => _BookingCodeState();
}

class _BookingCodeState extends State<BookingCode> {
  @override
  void initState() {
    super.initState();
    print(widget.bookingCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: Center(
        child: RotatedBox(
          quarterTurns: 1, // Rotate 90 degrees counter-clockwise
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '#${widget.bookingCode}',
              style: TextStyle(
                fontSize: 55,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

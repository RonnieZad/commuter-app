import 'package:flutter/material.dart';
import 'package:commuter/screens/ticket_info.dart';

class TicketButton extends StatelessWidget {
  final String ticketNumber,
      bookingDate,
      busCompany,
      clientName,
      clientPhone,
      busName,
      tripRoute,
      seatNumber,
      busPhone;

  const TicketButton(
      {Key key,
      @required this.busName,
      this.ticketNumber,
      this.bookingDate,
      this.busCompany,
      this.clientName,
      this.clientPhone,
      this.tripRoute,
      this.seatNumber,
      this.busPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketInfoPage(
                busName: busName,
                ticketNumber: ticketNumber,
                bookingDate: bookingDate,
                busCompany: busCompany,
                clientName: clientName,
                clientPhone: clientPhone,
                tripRoute: tripRoute,
                seatNumber: seatNumber,
                busPhone: busPhone,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          height: 80.0,
          width: 500.0,
          decoration: BoxDecoration(
              color: Colors.black26, borderRadius: BorderRadius.circular(12.0)),
          child: Row(
            children: <Widget>[
              Text(
                busName,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Product Sans'),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                bookingDate,
                style: TextStyle(fontFamily: 'Product Sans'),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}

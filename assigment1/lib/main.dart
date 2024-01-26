import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PayCalculator(),
    );
  }
}

class PayCalculator extends StatefulWidget {
  const PayCalculator({Key? key}) : super(key: key);

  @override
  _PayCalculatorState createState() => _PayCalculatorState();
}

class _PayCalculatorState extends State<PayCalculator> {
  TextEditingController hoursController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  double regularPay = 0.0;
  double overtimePay = 0.0;
  double totalPay = 0.0;
  double tax = 0.0;

  void calculatePay() {
    try {
      double hours = double.parse(hoursController.text);
      double rate = double.parse(rateController.text);

      if (hours < 0 || rate < 0) {
        // Display an error message for negative values
        showErrorSnackBar("Please enter positive values for hours and rate.");
        return;
      }

      if (hours <= 40) {
        regularPay = hours * rate;
        overtimePay = 0.0;
      } else {
        regularPay = 40 * rate;
        overtimePay = (hours - 40) * rate * 1.5;
      }

      totalPay = regularPay + overtimePay;
      tax = totalPay * 0.18;

      setState(() {});
    } catch (e) {
      // Handle parsing errors
      showErrorSnackBar("Invalid input. Please enter valid numeric values.");
    }
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void resetValues() {
    hoursController.text = '';
    rateController.text = '';
    regularPay = 0.0;
    overtimePay = 0.0;
    totalPay = 0.0;
    tax = 0.0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD5D5D5),
      appBar: AppBar(
        title: const Text('Pay Calculator'),
        backgroundColor: Color.fromARGB(255, 252, 240, 130),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: hoursController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Number of Hours',
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Hourly Rate',
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 77, 182, 243),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              onPressed: calculatePay,
              child: const Text('Calculate',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 50.0),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: 300,
                height: 150,
                color: Color.fromARGB(255, 243, 232, 132),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Report',
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Text('Regular Pay: ${regularPay.toStringAsFixed(2)}'),
                    Text('Overtime Pay: ${overtimePay.toStringAsFixed(2)}'),
                    Text(
                        'Total Pay (before tax): ${totalPay.toStringAsFixed(2)}'),
                    Text('Tax: ${tax.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Color(0xff929292),
        elevation: 0,
        child: Column(
          children: [
            Text('Name: Abhiyan Bhattarai',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            Text('College ID: 301370586',
                style: TextStyle(color: Colors.white, fontSize: 15)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: resetValues,
        tooltip: 'Reset',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

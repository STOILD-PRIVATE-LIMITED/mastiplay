import 'package:flutter/material.dart';

class TransferMethod extends StatefulWidget {
  final double height;
  final double width;
  const TransferMethod({super.key, required this.height, required this.width});

  @override
  State<TransferMethod> createState() => _TransferMethodState();
}

class _TransferMethodState extends State<TransferMethod> {
  TextEditingController userId = TextEditingController();
  TextEditingController amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Sales method:"),
              Text("User"),
              Text("Coinseller"),
              Text("NOBEL"),
            ],
          ),
          SizedBox(
            height: widget.height / 30,
          ),
          const Text("User ID:"),
          TextField(
            controller: userId,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Enter User ID',
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: widget.height / 30,
          ),
          const Text("Amount:"),
          TextField(
            controller: amount,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Amount',
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Will Receive diamond:"),
              Icon(
                Icons.diamond,
                color: Colors.pink,
              )
            ],
          ),
          SizedBox(
            height: widget.height / 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: widget.height / 15,
              width: widget.width / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.pink,
              ),
              child: const Center(
                child: Text(
                  "Transfer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

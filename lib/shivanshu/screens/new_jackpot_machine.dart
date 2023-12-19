import 'package:flutter/material.dart';

class NewJackpotMachine extends StatelessWidget {
  const NewJackpotMachine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jackpot Slot Machine'),
      ),
      body: const JackpotSlotMachine(),
    );
  }
}

class JackpotSlotMachine extends StatefulWidget {
  const JackpotSlotMachine({super.key});

  @override
  _JackpotSlotMachineState createState() => _JackpotSlotMachineState();
}

class _JackpotSlotMachineState extends State<JackpotSlotMachine> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200.0,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: 100, // Adjust the number of items as needed
            itemBuilder: (context, index) {
              return Center(
                child: Text(
                  index.toString(),
                  style: const TextStyle(fontSize: 24.0),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _startSpinning();
          },
          child: const Text('Spin'),
        ),
      ],
    );
  }

  void _startSpinning() {
    _scrollController.animateTo(
      200000.0,
      duration: const Duration(seconds: 10),
      curve: Curves.easeOut,
    );
  }
}

import 'package:flutter/material.dart';

class BidOpen extends StatefulWidget {
  const BidOpen({super.key});

  @override
  State<BidOpen> createState() => _BidOpenState();
}

class _BidOpenState extends State<BidOpen> {
  TextEditingController agencyIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: width / 30),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            padding: EdgeInsets.only(
              left: width / 30,
            ),
            child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: height / 40,
          ),
        ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Bind Agency",
          style: TextStyle(fontSize: height / 30, wordSpacing: 2),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 40),
        child: Column(children: [
          SizedBox(
            height: height / 15,
          ),
          SearchBar(
            controller: agencyIdController,
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.grey[100]!),
            hintText: "Enter Agency id",
            hintStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (states) => TextStyle(
                fontSize: height / 30,
              ),
            ),
            trailing: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: height / 30,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.abc),
                title: const Text("Agency Name"),
                subtitle: const Text("Agency Id"),
                trailing: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.pink),
                  ),
                  child: const Text(
                    "apply",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ))
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: MyColumn(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: const Color(0xfffceadc),
                child: MyColumn(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListTile(
                        title: const Text(
                          'BRONZE FAMILY',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        subtitle: const MyColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyRow(
                              children: [
                                Text(
                                  '405',
                                  style: TextStyle(
                                    color: Color(0xff906030),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(' / 5000000'),
                              ],
                            ),
                            SizedBox(
                              width: 100,
                              child: LinearProgressIndicator(
                                value: 0.2,
                              ),
                            ),
                            MyRow(
                              children: [
                                Text('Family monthly rank: '),
                                Text(
                                  "977",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 150, 90, 29),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Image.asset(
                          'assets/trophy.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xffe6ccbb),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: const MyRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyRow(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/dummy_person.png'),
                              ),
                              Text('🔥nikkuIqafG...'),
                            ],
                          ),
                          Text('FAMILY LEADER'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Set a family notice to let others know your family',
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xff906030),
                      ),
                      foregroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Set'),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.black12.withOpacity(0.2), thickness: 10),
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Member contributions',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Points updated monthly',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                _Tile(),
                _Tile(),
                _Tile(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffb717),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  showMsg(context, 'Entered Family Channel');
                },
                child: const Text('Enter Family Channel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const MyRow(
        children: [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/dummy_person.png'),
          ),
        ],
      ),
      title: const Text('🔥nikku jaat ...'),
      subtitle: MyRow(
        children: [
          Card(
            color: Colors.black45,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1),
            ),
            child: const MyRow(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 10,
                ),
                Text(
                  'Civilian',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      trailing: const MyRow(
        children: [
          Text(
            '343',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.abc)
        ],
      ),
    );
  }
}

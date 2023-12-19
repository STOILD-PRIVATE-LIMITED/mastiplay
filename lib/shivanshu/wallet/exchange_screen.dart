import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int exchangeTime = 2;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exchange beans to Gems',
              style: textTheme(context).bodyMedium!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BeanText(txt: "100000"),
                Text(" = "),
                DiamondText(txt: "100000"),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Daily Exchange times: $exchangeTime',
              style: textTheme(context).bodyMedium!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 10),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 320,
                childAspectRatio: 4 / 2,
              ),
              children: [
                _Tile('1,00,000', '1,00,000', () {
                  showMsg(context, 'Hehe');
                }),
                _Tile('5,00,000', '5,00,000', () {
                  showMsg(context, 'Hehe');
                }),
                _Tile('10,00,000', '10,00,000', () {
                  showMsg(context, 'Hehe');
                }),
                _Tile('50,00,000', '50,00,000', () {
                  showMsg(context, 'Hehe');
                }),
                _Tile('1,00,00,000', '1,00,00,000', () {
                  showMsg(context, 'Hehe');
                }),
                _Tile('2,00,00,000', '2,00,00,000', () {
                  showMsg(context, 'Hehe');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DiamondText extends StatelessWidget {
  const DiamondText({
    super.key,
    required this.txt,
    this.textStyle,
    this.size = 20,
  });
  final String txt;
  final TextStyle? textStyle;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/diamond.png', width: size, height: size),
        const SizedBox(
          width: 4,
        ),
        Text(txt, style: textStyle),
      ],
    );
  }
}

class BeanText extends StatelessWidget {
  const BeanText({super.key, required this.txt});
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/bean.png'),
        const SizedBox(
          width: 4,
        ),
        Text(txt),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  final String dText, bText;
  final void Function() onTap;
  const _Tile(this.dText, this.bText, this.onTap);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: Colors.grey.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DiamondText(txt: dText),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Price'),
                    BeanText(txt: bText),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

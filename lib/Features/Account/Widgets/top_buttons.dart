import 'package:amazon_clone_with_nodejs/Features/Account/Widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Orders',
              ontap: () {},
            ),
            AccountButton(
              text: 'Turn Seller',
              ontap: () {},
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              ontap: () {},
            ),
            AccountButton(
              text: 'Your Wish List',
              ontap: () {},
            )
          ],
        )
      ],
    );
  }
}

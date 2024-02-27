import 'package:amazon_clone_with_nodejs/Features/Account/Service/account_service.dart';
import 'package:amazon_clone_with_nodejs/Features/Account/Widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

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
              ontap: () => AccountService().logOutUser(context),
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

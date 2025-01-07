import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String? profileImage;

  const CustomNavbar({
    super.key,
    required this.username,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 60,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
                height: 28,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                username,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(width: 8),
              profileImage != null && profileImage!.isNotEmpty
                  ? CircleAvatar(
                      radius: 20,
                      backgroundImage: profileImage!.startsWith('assets/') ? AssetImage(profileImage!) : NetworkImage(profileImage!) as ImageProvider,
                    )
                  : CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade300,
                      child: Text(
                        username.isNotEmpty ? username[0] : '?',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

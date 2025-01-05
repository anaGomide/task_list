import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String? profileImage;

  const CustomNavbar({
    Key? key,
    required this.username,
    this.profileImage,
  }) : super(key: key);

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
          // Logo SVG
          Row(
            children: [
              SvgPicture.asset(
                'assets/logo.svg', // Caminho para o arquivo SVG
                height: 28, // Altura da logo
              ),
            ],
          ),
          // Nome do usuário e avatar
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
                      backgroundImage: profileImage!.startsWith('assets/')
                          ? AssetImage(profileImage!) // Imagem dos assets
                          : NetworkImage(profileImage!) as ImageProvider,
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

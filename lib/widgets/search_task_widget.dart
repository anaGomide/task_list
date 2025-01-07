import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  final String hintText;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClear;

  const SearchFieldWidget({
    super.key,
    required this.hintText,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      onChanged: onSearchChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear, color: Theme.of(context).colorScheme.primary),
          onPressed: onClear,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
      ),
    );
  }
}

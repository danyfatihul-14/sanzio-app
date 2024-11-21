import 'package:flutter/material.dart';
import 'package:raffaelosanzio/models/cart.dart';

class CartItemWidget extends StatelessWidget {
  final Cart cart;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;
  final Function(bool?) onCheckboxChanged;

  const CartItemWidget({
    required this.cart,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: cart.isSelected,
        onChanged: onCheckboxChanged,
      ),
      title: Text(cart.title),
      subtitle: Text("Price: \$${cart.price}, Quantity: ${cart.quantity}"),
      trailing: IconButton(
        icon: const Icon(Icons.remove_circle),
        onPressed: onRemove,
      ),
      onTap: () {},
    );
  }
}

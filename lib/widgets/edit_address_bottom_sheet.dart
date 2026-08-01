import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_app/cubit/address_cubit.dart';
import 'package:shopping_cart_app/models/address_model.dart';

class EditAddressBottomSheet extends StatefulWidget {
  final AddressModel address;

  const EditAddressBottomSheet({
    super.key,
    required this.address,
  });

  @override
  State<EditAddressBottomSheet> createState() => _EditAddressBottomSheetState();
}

class _EditAddressBottomSheetState extends State<EditAddressBottomSheet> {
  late TextEditingController nameController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.address.name,
    );

    cityController = TextEditingController(
      text: widget.address.city,
    );

    stateController = TextEditingController(
      text: widget.address.state,
    );

    phoneController = TextEditingController(
      text: widget.address.phone,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Edit Address",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: "City",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: stateController,
              decoration: const InputDecoration(
                labelText: "State",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final updatedAddress = AddressModel(
                    name: nameController.text,
                    city: cityController.text,
                    state: stateController.text,
                    phone: phoneController.text,
                  );

                  context.read<AddressCubit>().updatedAddress(updatedAddress);
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

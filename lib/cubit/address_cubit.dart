import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shopping_cart_app/models/address_model.dart';

class AddressCubit extends Cubit<AddressModel> {
  final Box addressBox = Hive.box('addressBox');
  AddressCubit()
      : super(
          AddressModel(
            name: "Mohd Imran",
            city: "Aligarh",
            state: "Uttar Pradesh",
            phone: "+91 8412753759",
          ),
        ) {
    loadAddress();
  }

  void saveAddress(AddressModel address) {
    addressBox.put('address', address.tojson());
  }

  void loadAddress() {
    final data = addressBox.get('address');

    if (data != null) {
      emit(AddressModel.fromjson(
        Map<String, dynamic>.from(data),
      ));
    }
  }

  void updatedAddress(AddressModel address) {
    saveAddress(address);
    emit(address);
  }
}

import 'package:client/core/class/crud.dart';
import 'package:client/link_api.dart';

class SignupData {
  Crud crud;
  SignupData(this.crud);
  postdata(
      String firstName,
      String lastName,
      String password,
      String phoneNumber,
      String email,
      String userRole,
      String postalCode) async {
    var response = await crud.postData(AppLink.register, {
      "name": firstName.toString() + " " + lastName.toString(),
      "password": password,
      "email": email,
      "phoneNumber": phoneNumber,
      "userRole": userRole,
      "zipCode": postalCode
    });
    return response.fold((l) => l, (r) => r);
  }
}

import 'package:my_sutra/features/data/model/doctor_models/get_bank_accounts_model.dart';

class BankAccountEntity {
  String? id;
  String? entity;
  String? contactId;
  String? accountType;
  BankAccount? bankAccount;
  String? batchId;
  bool? active;
  int? createdAt;
  Vpa? vpa;

  BankAccountEntity(
      {this.id,
      this.entity,
      this.contactId,
      this.accountType,
      this.bankAccount,
      this.batchId,
      this.active,
      this.createdAt,
      this.vpa});
}

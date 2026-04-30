import 'package:flutter_riverpod/legacy.dart';

enum KycStatus { pending, submitted }
enum BankStatus { notLinked, linked }

class UserStatus {
  final KycStatus kycStatus;
  final BankStatus bankStatus;

  const UserStatus({
    required this.kycStatus,
    required this.bankStatus,
  });

  UserStatus copyWith({
    KycStatus? kycStatus,
    BankStatus? bankStatus,
  }) {
    return UserStatus(
      kycStatus: kycStatus ?? this.kycStatus,
      bankStatus: bankStatus ?? this.bankStatus,
    );
  }
}

class UserStatusNotifier extends StateNotifier<UserStatus> {
  UserStatusNotifier()
      : super(const UserStatus(
          kycStatus: KycStatus.pending,
          bankStatus: BankStatus.notLinked,
        ));

  void submitKyc() {
    state = state.copyWith(kycStatus: KycStatus.submitted);
  }

  void linkBank() {
    state = state.copyWith(bankStatus: BankStatus.linked);
  }
}

final userStatusProvider = StateNotifierProvider<UserStatusNotifier, UserStatus>((ref) {
  return UserStatusNotifier();
});

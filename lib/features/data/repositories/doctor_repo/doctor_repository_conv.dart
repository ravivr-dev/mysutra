import 'package:my_sutra/features/data/model/doctor_models/get_bank_accounts_model.dart';
import 'package:my_sutra/features/data/model/doctor_models/get_bookings_model.dart';
import 'package:my_sutra/features/data/model/doctor_models/get_doctor_appointment_model.dart';
import 'package:my_sutra/features/data/model/doctor_models/get_withdrawal_model.dart';
import 'package:my_sutra/features/data/model/doctor_models/patient_appointments_model.dart';
import 'package:my_sutra/features/data/model/patient_models/available_time_slot.dart';
import 'package:my_sutra/features/data/model/user_models/following_response_model.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/bank_account_entity.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/booking_entity.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/get_doctor_appointment_entity.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/withdrawal_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/appointment_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/available_time_slot_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/follower_entity.dart';

import '../../../domain/entities/doctor_entities/get_time_slots_response_data_entity.dart';
import '../../model/doctor_models/get_time_slots_response_model.dart';

class DoctorRepositoryConv {
  static List<FollowerEntity> convertFollowingModelToEntity(
      List<FollowerData> data) {
    return data
        .map((e) => FollowerEntity(
            id: e.id ?? '',
            role: e.role ?? '',
            profilePic: e.profilePic ?? '',
            fullName: e.fullName ?? '',
            username: e.username ?? '',
            isVerified: e.isVerified ?? false,
            specialization: e.specialization ?? '',
            isFollowing: e.isFollowing ?? false,
            totalFollowers: e.totalFollowers ?? 0))
        .toList();
  }

  static GetTimeSlotsResponseEntity convertTimeSlotModelToEntity(
      GetTimeSlotsResponseModel data) {
    return GetTimeSlotsResponseEntity(
        fees: data.fees, list: convertTimeSlotModelListToEntity(data.list));
  }

  static List<GetTimeSlotsResponseDataEntity> convertTimeSlotModelListToEntity(
      List<GetTimeSlotsResponseData> model) {
    return model
        .map((e) => GetTimeSlotsResponseDataEntity(
              id: e.id,
              userId: e.userId,
              day: e.day,
              slotType: e.slotType,
              startTime: e.startTime,
              endTime: e.endTime,
            ))
        .toList();
  }

  static GetDoctorAppointmentEntity convertDoctorAppointmentModelToEntity(
      GetDoctorAppointmentModel model) {
    return GetDoctorAppointmentEntity(
      message: model.message,
      totalAppointments: model.totalAppointments ?? 0,
      completedAppointments: model.completedAppointments ?? 0,
      pendingAppointments: model.pendingAppointments ?? 0,
      count: model.count,
      list: model.list
          .map((e) => AppointmentEntity(
                id: e.id ?? '',
                doctorId: e.doctorId,
                userId: e.userId,
                profilePic: e.profilePic,
                fullName: e.fullName,
                username: e.username,
                isVerified: e.isVerified,
                specialization: e.specialization,
                date: e.date,
                time: e.time,
                timeInMinutes: e.timeInMinutes,
                phoneNumber: e.phoneNumber,
                countryCode: e.countryCode,
                reason: e.reason,
                duration: e.duration ?? 0,
              ))
          .toList(),
    );
  }

  static List<AvailableTimeSlotEntity> convertAvailableSlotModelToEntity(
      AvailableTimeSlotResponse model) {
    List<AvailableTimeSlotEntity> list = [];

    for (AvailableTimeSlot e in model.timeSlots) {
      list.add(AvailableTimeSlotEntity(
          id: e.id,
          day: e.day,
          startTime: e.startTime,
          slotType: e.slotType,
          endTime: e.endTime));
    }
    return list;
  }

  static List<BankAccountEntity> convertBankAccountModelToEntity(
      List<BankAccountModel> data) {
    return data
        .map((e) => BankAccountEntity(
              id: e.id,
              entity: e.entity,
              contactId: e.contactId,
              accountType: e.accountType,
              bankAccount: e.bankAccount,
              batchId: e.batchId,
              active: e.active,
              createdAt: e.createdAt,
              vpa: e.vpa,
            ))
        .toList();
  }

  static WithdrawalEntity convertWithrawalModelToEntity(
      GetWithdrawalModel data) {
    return WithdrawalEntity(
        booking: data.booking,
        earnings: data.earnings,
        commision: data.commision,
        data: data.data == null
            ? []
            : data.data!
                .map((e) => WithdrawalData(
                    payoutId: e.payoutId,
                    date: e.date,
                    amount: e.amount,
                    id: e.sId,
                    currency: e.currency,
                    status: e.status))
                .toList());
  }

  static List<BookingEntity> convertBookingModelToEntity(
      List<BookingItem> data) {
    return data
        .map((e) => BookingEntity(
            date: e.date,
            id: e.id,
            userId: e.userId?.username,
            time: e.time,
            timeInMinutes: e.timeInMinutes,
            totalAmount: e.totalAmount))
        .toList();
  }

  static List<String?> convertPatientAppontmentModel(List<Appointment> data) {
    return data.map((e) => e.date).toList();
  }
}

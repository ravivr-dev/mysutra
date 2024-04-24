import '../../../domain/entities/doctor_entities/get_time_slots_response_data_entity.dart';
import '../../model/doctor_models/get_time_slots_response_model.dart';

class DoctorRepositoryConv {
  static List<GetTimeSlotsResponseDataEntity>
      getTimeSlotsResponseModelListToEntity(
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
}

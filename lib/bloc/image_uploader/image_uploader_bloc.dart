import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

part 'image_uploader_event.dart';
part 'image_uploader_state.dart';

class ImageUploaderBloc extends Bloc<ImageUploaderEvent, ImageUploaderState> {
  ImageUploaderBloc() : super(ImageUploaderInitial()) {
    on<ImageUploadEvent>(onUploadEvent);
  }

  void onUploadEvent(ImageUploadEvent event, emit) async {
    var pickImage = await _pickImage().onError((error, stackTrace) {
      emit(ImageUploadingErrorState(error.toString()));
      return null;
    });

    if (pickImage == null) {
      return;
    }

    emit(ImageUploadCompleteState(pickImage));

    print("Upload complete: ${pickImage.length}");
  }

  Future<Uint8List?> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
      withData: true,
    );
    if (result != null && result.files.single.bytes != null) {
      var bytes2 = result.files.single.bytes;
      return bytes2;
    }
    return Future.error('Uploading failed');
  }
}

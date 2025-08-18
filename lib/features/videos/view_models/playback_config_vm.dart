import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/playback_config_model.dart';
import 'package:tiktok/features/videos/repos/video_playback_config_repo.dart';

// Provider
// class PlaybackConfigViewModel extends ChangeNotifier {
//   final PlaybackConfigRepository _repository;

//   late final PlaybackConfigModel _model = PlaybackConfigModel(
//     muted: _repository.isMuted(),
//     autoPlay: _repository.isAutoplay(),
//   );

//   PlaybackConfigViewModel(this._repository);

//   // repository와 model을 직접 공개하지 않고 view에서 접근 가능하게 getter로 만듬
//   bool get muted => _model.muted;
//   bool get autoPlay => _model.autoPlay;

//   void setMuted(bool value) {
//     _repository.setMuted(value);
//     _model.muted = value;
//     notifyListeners();
//   }

//   void setAutoPlay(bool value) {
//     _repository.setAutoplay(value);
//     _model.autoPlay = value;
//     notifyListeners();
//   }
// }

// riverpod
class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(muted: value, autoPlay: state.autoPlay);
  }

  void setAutoPlay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(muted: state.muted, autoPlay: value);
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoPlay: _repository.isAutoplay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
      () => throw UnimplementedError(),
    );

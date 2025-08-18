import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok/common/widgets/video_configuration/video_config.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok/features/videos/views/widgets/video_button.dart';
import 'package:tiktok/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

  bool _isPaused = false;

  bool _localMuted = false;

  // ChangeNotifier
  // bool _autoMute = videoConfig.autoMuted;
  // ValueNotifier
  // bool _autoMute = videoConfig.value;

  final Duration _animataionDuration = Duration(milliseconds: 300);

  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animataionDuration,
    );

    // context.read<PlaybackConfigViewModel>().addListener(
    //   _onPlaybackConfigChanged,
    // );

    // videoConfig.addListener(() {
    //   setState(() {
    //     // ChangeNotifier
    //     // _autoMute = videoConfig.autoMuted;
    //     // ValueNotifier
    //     _autoMute = videoConfig.value;
    //   });
    // });
    // _animationController.addListener(() {
    //   setState(() {});
    // });
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    // final muted = context.read<PlaybackConfigViewModel>().muted;
    final muted = ref.read(playbackConfigProvider).muted;
    ref.read(playbackConfigProvider.notifier).setMuted(!muted);
    if (muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      // 예를 들어 영상 길이가 10초고 현재 위치가 10초면 비디오 피니시드 함수 활성화
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.asset(
      'assets/videos/zzanggu.mp4',
    );
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    // mounted - 위젯이 현재 트리에 있는지 확인
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      // final autoPlay = context.read<PlaybackConfigViewModel>().autoPlay;

      if (ref.read(playbackConfigProvider).autoPlay) {
        _videoPlayerController.play();
      }
    }

    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  // 처음에 아이콘이 1.5였다가 멈추면 1.0으로 줄어들고, 다시 재생하면 1.5로 커지는 애니메이션
  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      // reverse() - lower bound에서 설정한 값으로 애니메이션 한다.
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentTap() async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      context: context,
      // isScrollControlled - bottom sheet안에 listview를 사용할 경우 isScrollControlled를 true로 설정
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VideoComments(),
    );

    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    // VisibilityDetector 패키지를 사용하여 페이지가 완전히 전환될 때 비디오 재생시키기
    return VisibilityDetector(
      key: Key('${widget.index}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(color: Colors.black),
          ),
          Positioned.fill(child: GestureDetector(onTap: _onTogglePause)),
          // Position은 언제나 Stack의 자식 위젯으로 사용해야 하므로 다른 위젯으로 감싸면 안됨
          Positioned.fill(
            // IgnorePointer - 클릭 시 이벤트가 해당 위젯으로 가지 않는다.
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      // 아래 AnimatedOpacity를 넘겨준다.
                      child: child,
                    );
                  },

                  child: AnimatedOpacity(
                    duration: _animataionDuration,
                    opacity: _isPaused ? 1 : 0,
                    child: FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
              // ChangeNotifier
              // onPressed: videoConfig.toggleAutoMute,
              // ValueNotifier
              // onPressed: () {
              //   videoConfig.value = !videoConfig.value;
              // },
              // onPressed: () {
              // context.read<VideoConfig>().toggleMute();
              // context.read<PlaybackConfigViewModel>().setMuted(
              //   !context.read<PlaybackConfigViewModel>().muted,
              // );
              // },
              onPressed: _onPlaybackConfigChanged,
              icon: FaIcon(
                // context.watch<VideoConfig>().isMuted
                // context.watch<PlaybackConfigViewModel>().muted
                ref.watch(playbackConfigProvider).muted
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@Minchan',
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text(
                  'This is zzangu',
                  style: TextStyle(fontSize: Sizes.size16, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/114412280?v=4',
                  ),
                  child: Text('민찬'),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(98192112312),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: _onCommentTap,
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(435345),
                  ),
                ),
                Gaps.v24,
                VideoButton(icon: FontAwesomeIcons.share, text: 'Share'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

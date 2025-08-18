import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/views/video_preview_screen.dart';
import 'package:tiktok/features/videos/views/widgets/flash_mode_button.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = 'postVideo';
  static const String routeURL = '/upload';
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;

  // iOS 시뮬레이터(디버그)에서는 카메라 미사용
  late final bool _noCamera = kDebugMode && Platform.isIOS;

  // 컨트롤러를 nullable로 전환 + 안전 가드
  CameraController? _cameraController;
  bool get _isCamReady =>
      _cameraController != null && _cameraController!.value.isInitialized;

  FlashMode _flashMode = FlashMode.off;

  late final AnimationController _buttonAnimationController =
      AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100),
      );

  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
        lowerBound: 0.0,
        upperBound: 1.0,
      );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (!_noCamera) {
      _initPermission();
    } else {
      // 시뮬레이터 모드: 카메라 없이 갤러리만 사용
      setState(() {
        _hasPermission = true;
      });
    }

    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_hasPermission || _noCamera) return;
    if (!_isCamReady) return;

    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
      _cameraController = null;
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  Future<void> _initPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await _initCamera();
      setState(() {});
    } else {
      // 영구 거부 시 설정 열기 안내 정도를 추가해도 좋음
      setState(() {
        _hasPermission = false;
      });
    }
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      // 전/후면 카메라 안전 선택
      final desiredDirection = _isSelfieMode
          ? CameraLensDirection.front
          : CameraLensDirection.back;
      final fallbackDirection = _isSelfieMode
          ? CameraLensDirection.back
          : CameraLensDirection.front;

      CameraDescription? picked = _pickCamera(cameras, desiredDirection);
      picked ??= _pickCamera(cameras, fallbackDirection);
      picked ??= cameras.first; // 그래도 없으면 첫 번째

      // 기존 컨트롤러 정리
      await _cameraController?.dispose();

      final controller = CameraController(
        picked,
        ResolutionPreset.ultraHigh,
        enableAudio: false,
      );

      await controller.initialize();

      // iOS 비디오 녹화 준비 (안전 호출)
      try {
        await controller.prepareForVideoRecording();
      } catch (_) {
        // 일부 환경에서 미구현일 수 있으므로 무시 가능
      }

      _cameraController = controller;
      _flashMode = controller.value.flashMode;

      if (mounted) setState(() {});
    } catch (e) {
      // 초기화 실패 시 컨트롤러 정리
      await _cameraController?.dispose();
      _cameraController = null;
      if (mounted) setState(() {});
    }
  }

  CameraDescription? _pickCamera(
    List<CameraDescription> cameras,
    CameraLensDirection direction,
  ) {
    try {
      return cameras.firstWhere(
        (c) => c.lensDirection == direction,
        orElse: () => cameras.first,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    if (_noCamera) {
      setState(() {}); // UI만 반영
      return;
    }
    await _initCamera();
    if (mounted) setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    if (!_isCamReady) return;
    await _cameraController!.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    if (mounted) setState(() {});
  }

  Future<void> _startRecording(TapDownDetails details) async {
    if (!_isCamReady) return;
    if (_cameraController!.value.isRecordingVideo) return;

    await _cameraController!.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_isCamReady) return;
    if (!_cameraController!.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final file = await _cameraController!.stopVideoRecording();

    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(video: file, isPicked: false),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(video: video, isPicked: true),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: width,
        child: !_hasPermission
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Initializing camera...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive(),
                ],
              )
            : Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  // 카메라 프리뷰
                  if (!_noCamera && _isCamReady)
                    CameraPreview(_cameraController!),

                  Positioned(
                    top: Sizes.size40,
                    left: Sizes.size20,

                    child: CloseButton(color: Colors.white),
                  ),

                  // 플래시/셀피 스위치
                  if (!_noCamera)
                    Positioned(
                      top: Sizes.size20,
                      right: Sizes.size20,
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: _toggleSelfieMode,
                            icon: const Icon(
                              Icons.cameraswitch,
                              color: Colors.white,
                              size: Sizes.size40,
                            ),
                          ),
                          Gaps.v10,
                          FlashModeButton(
                            icon: Icons.flash_off_rounded,
                            isActive: _flashMode == FlashMode.off,
                            onPressed: () => _setFlashMode(FlashMode.off),
                          ),
                          Gaps.v10,
                          FlashModeButton(
                            icon: Icons.flash_on_rounded,
                            isActive: _flashMode == FlashMode.always,
                            onPressed: () => _setFlashMode(FlashMode.always),
                          ),
                          Gaps.v10,
                          FlashModeButton(
                            icon: Icons.flash_auto_rounded,
                            isActive: _flashMode == FlashMode.auto,
                            onPressed: () => _setFlashMode(FlashMode.auto),
                          ),
                          Gaps.v10,
                          FlashModeButton(
                            icon: Icons.flashlight_on_rounded,
                            isActive: _flashMode == FlashMode.torch,
                            onPressed: () => _setFlashMode(FlashMode.torch),
                          ),
                        ],
                      ),
                    ),

                  // 하단 컨트롤
                  Positioned(
                    bottom: Sizes.size40,
                    width: width,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTapDown: _startRecording,
                          onTapUp: (_) => _stopRecording(),
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size80 + Sizes.size14,
                                  height: Sizes.size80 + Sizes.size14,
                                  child: CircularProgressIndicator(
                                    color: Colors.red.shade400,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size80,
                                  height: Sizes.size80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

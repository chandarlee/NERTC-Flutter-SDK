// Copyright (c) 2021 NetEase, Inc.  All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

part of nertc;

/// 伴音管理模块
class NERtcAudioMixingManager {
  final _AudioMixingEventHandler _handler = _AudioMixingEventHandler();

  NERtcAudioMixingManager._();

  _EventHandler _eventHandler() => _handler;

  AudioMixingApi _api = AudioMixingApi();

  /// 设置伴音事件回调
  Future<int> setEventCallback(NERtcAudioMixingEventCallback callback) async {
    _handler.setCallback(callback);
    IntValue reply = await _api.setAudioMixingEventCallback();
    return reply.value ?? -1;
  }

  /// 清除伴音事件回调
  Future<int> clearEventCallback() async {
    _handler.setCallback(null);
    IntValue reply = await _api.clearAudioMixingEventCallback();
    return reply.value ?? -1;
  }

  /// 开始混音任务
  Future<int> startAudioMixing(NERtcAudioMixingOptions options) async {
    IntValue reply = await _api.startAudioMixing(StartAudioMixingRequest()
      ..path = options.path
      ..loopCount = options.loopCount
      ..sendEnabled = options.sendEnabled
      ..sendVolume = options.sendVolume
      ..playbackEnabled = options.playbackEnabled
      ..playbackVolume = options.playbackVolume);
    return reply.value ?? -1;
  }

  /// 结束混音任务
  Future<int> stopAudioMixing() async {
    IntValue reply = await _api.stopAudioMixing();
    return reply.value ?? -1;
  }

  /// 暂停混音任务
  Future<int> pauseAudioMixing() async {
    IntValue reply = await _api.pauseAudioMixing();
    return reply.value ?? -1;
  }

  /// 恢复混音任务
  Future<int> resumeAudioMixing() async {
    IntValue reply = await _api.resumeAudioMixing();
    return reply.value ?? -1;
  }

  /// 设置混音发送音量
  Future<int> setAudioMixingSendVolume(int volume) async {
    IntValue reply =
        await _api.setAudioMixingSendVolume(IntValue()..value = volume);
    return reply.value ?? -1;
  }

  /// 获取混音发送音量
  Future<int> getAudioMixingSendVolume() async {
    IntValue reply = await _api.getAudioMixingSendVolume();
    return reply.value ?? -1;
  }

  /// 设置混音播放音量
  Future<int> setAudioMixingPlaybackVolume(int volume) async {
    IntValue reply =
        await _api.setAudioMixingPlaybackVolume(IntValue()..value = volume);
    return reply.value ?? -1;
  }

  /// 获取混音播放音量
  Future<int> getAudioMixingPlaybackVolume() async {
    IntValue reply = await _api.getAudioMixingPlaybackVolume();
    return reply.value ?? -1;
  }

  /// 获取混音文件时长
  Future<int> getAudioMixingDuration() async {
    IntValue reply = await _api.getAudioMixingDuration();
    return reply.value ?? -1;
  }

  /// 获取混音任务当前进度
  Future<int> getAudioMixingCurrentPosition() async {
    IntValue reply = await _api.getAudioMixingCurrentPosition();
    return reply.value ?? -1;
  }

  /// 定位到具体混音时间点
  Future<int> setAudioMixingPosition(int position) async {
    IntValue reply =
        await _api.setAudioMixingPosition(IntValue()..value = position);
    return reply.value ?? -1;
  }
}

/// 伴音构造参数类
class NERtcAudioMixingOptions {
  const NERtcAudioMixingOptions(
      {required this.path,
      this.loopCount = 1,
      this.sendEnabled = true,
      this.sendVolume = 100,
      this.playbackEnabled = true,
      this.playbackVolume = 100});

  /// 文件地址/URL
  final String path;

  /// 循环次数， <= 0, 表示无限循环，默认 1
  final int loopCount;

  /// 是否发送（默认 true）
  final bool sendEnabled;

  /// 发送音量[0 - 100]（默认 100）
  final int sendVolume;

  /// 是否播放（默认 true）
  final bool playbackEnabled;

  /// 播放音量[0 - 100]（默认 100）
  final int playbackVolume;
}

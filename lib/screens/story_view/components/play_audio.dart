import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './../../../localization/language_constants.dart';
import './../../../main.dart';
import './../../../models/story.dart';
import './../../../utils/colors.dart';
import './../../../utils/constants.dart';
import './../../../utils/functions.dart';


class PlayAudio extends StatefulWidget {
  final String audio;
  final Story story;
  PlayAudio({Key key, @required this.audio, @required this.story}) : super(key: key);
  @override
  _PlayAudioState createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> with SingleTickerProviderStateMixin {
  AssetsAudioPlayer _assetsAudioPlayer;
  bool _downloadSuccess = false;
  bool _loadingDownload = false;

  @override
  void initState() {
    super.initState();
    File fileAudio = File(MyApp.getDirectoryApp(context, DIRECTORY_AUDIO_STORY).path + "/" + widget.story.uid + ".mp3");

    setState(() {
      _assetsAudioPlayer = AssetsAudioPlayer();
      _assetsAudioPlayer.open(
        fileAudio.existsSync() ? Audio.file(
            fileAudio.path
        ) : Audio.network(
            widget.audio
        ),
        autoStart: false
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // check has Download Audio
    File fileAudio = File(MyApp.getDirectoryApp(context, DIRECTORY_AUDIO_STORY).path + "/" + widget.story.uid + ".mp3");
    return Container(
      child:  _assetsAudioPlayer != null ? PlayerBuilder.realtimePlayingInfos(
          player: _assetsAudioPlayer,
          builder: (context, realtimePlayingInfos) {
            return realtimePlayingInfos != null ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    if (!fileAudio.existsSync()) {
                      setState(() {
                        _loadingDownload = true;
                      });
                      downloadFile(
                          widget.audio,
                          widget.story.uid + ".mp3",
                          MyApp.getDirectoryApp(context, DIRECTORY_AUDIO_STORY) != null ?  MyApp.getDirectoryApp(context, DIRECTORY_AUDIO_STORY).path : ''
                      ).then((filePath) {
                        if (filePath != null) {
                          setState(() {
                            _downloadSuccess = true;
                          });
                          _assetsAudioPlayer.open(
                              Audio.file(
                                  filePath
                              ),
                              autoStart: false
                          );
                        }
                        setState(() {
                          _loadingDownload = false;
                        });
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: COLOR_FFFFFF,
                        shape: BoxShape.circle
                    ),
                    child: Icon(
                      _loadingDownload ? Icons.vertical_align_bottom : _downloadSuccess || fileAudio.existsSync() ? Icons.download_done_sharp : Icons.download_sharp,
                      color: COLOR_001529,
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child:  Container(
                    child: Column(
                      children: [
                        SliderTheme(
                          data: SliderThemeData(
                              thumbColor: COLOR_065063,
                              activeTrackColor: COLOR_065063,
                              inactiveTrackColor: COLOR_90cdd8,
                              trackHeight: 12,
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
                          ),
                          child: Slider(
                            value: realtimePlayingInfos.currentPosition.inMicroseconds.toDouble(),
                            min: 0.0,
                            max: realtimePlayingInfos.duration.inMicroseconds.toDouble(),
                            label: 'sd',
                            onChanged: (double value) {
                              setState(() {
                                _assetsAudioPlayer.seek(Duration(microseconds: value.toInt()));
                              });
                            },
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                // child: Text(
                                //     format(realtimePlayingInfos.duration)
                                // ),
                                child: Text(
                                    realtimePlayingInfos.duration is Duration ? realtimePlayingInfos.duration.inHours == 0 ? durationToMMSS(Duration(milliseconds: 0)) : durationToHHMMSS(Duration(milliseconds: 0)) : ''
                                ),
                              ),
                              Spacer(),
                              Container(
                                // child: Text(
                                //     format(realtimePlayingInfos.duration)
                                // ),
                                child: Text(
                                    realtimePlayingInfos.duration is Duration ? realtimePlayingInfos.duration.inHours == 0 ? durationToMMSS(realtimePlayingInfos.duration) : durationToHHMMSS(realtimePlayingInfos.duration) : ''
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _assetsAudioPlayer.seek(Duration(milliseconds: 0));
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: COLOR_FFFFFF,
                              shape: BoxShape.circle
                          ),
                          child: Icon(
                            Icons.refresh,
                            color: COLOR_001529,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _assetsAudioPlayer.playOrPause();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: COLOR_FFFFFF,
                              shape: BoxShape.circle
                          ),
                          child: Icon(
                            realtimePlayingInfos.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: COLOR_001529,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ) : SizedBox();
          }
      ) : SizedBox(),
    );
  }
}

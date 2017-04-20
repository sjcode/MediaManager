#!/bin/sh
install_name_tool -change /ffmpeg/lib/libavcodec.dylib @executable_path/../Frameworks/libavcodec.dylib build/Debug/MediaManager.app/Contents/MacOS/MediaManager
install_name_tool -change /ffmpeg/lib/libavformat.dylib @executable_path/../Frameworks/libavformat.dylib build/Debug/MediaManager.app/Contents/MacOS/MediaManager
install_name_tool -change /ffmpeg/lib/libavfilter.dylib @executable_path/../Frameworks/libavfilter.dylib build/Debug/MediaManager.app/Contents/MacOS/MediaManager
install_name_tool -change /ffmpeg/lib/libavdevice.dylib @executable_path/../Frameworks/libavdevice.dylib build/Debug/MediaManager.app/Contents/MacOS/MediaManager
install_name_tool -change /ffmpeg/lib/libavutil.dylib @executable_path/../Frameworks/libavutil.dylib build/Debug/MediaManager.app/Contents/MacOS/MediaManager
install_name_tool -change /ffmpeg/lib/libpostproc.dylib @executable_path/../Frameworks/libpostproc.dylib build/Debug/MediaManager.app/Contents/MacOS/MediaManager
install_name_tool -change /ffmpeg/lib/libswresample.dylib @executable_path/../Frameworks/libswresample.dylib build/Debug/MediaManager.app/Contents/MacOS/MediaManager
install_name_tool -change @rpath/SDL.framework/Versions/A/SDL @executable_path/../Frameworks/SDL.framework/Versions/A/SDL build/Debug/MediaManager.app/Contents/MacOS/MediaManager
install_name_tool -change /opt/local/lib/libbz2.1.0.dylib @executable_path/../Frameworks/libbz2.1.0.dylib build/Debug/MediaManager.app/Contents/MacOS/MediaManager
install_name_tool -change /usr/local/lib/libSDL-1.2.0.dylib @executable_path/../Frameworks/libSDL-1.2.0.dylib build/Debug/MediaManager.app/Contents/MacOS/MediaManager
install_name_tool -change /opt/local/lib/libz.1.dylib @executable_path/../Frameworks/libz.1.dylib build/Debug/MediaManager.app/Contents/MacOS/MediaManager
install_name_tool -change /ffmpeg/lib/libswscale.dylib @executable_path/../Frameworks/libswscale.dylib build/Debug/MediaManager.app/Contents/MacOS/MediaManager



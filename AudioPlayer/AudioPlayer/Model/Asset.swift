//
//  Asset.swift
//  AudioPlayer
//
//  Created by Abdelhak Jemaii on 05.12.17.
//  Copyright © 2017 Abdelhak Jemaii. All rights reserved.
//

import AVFoundation

class Asset {
    var name = "HLSAudioStream"
    var urlAsset : AVURLAsset = AVURLAsset(url: URL(string : Streams.stream)!)
    var downloadState : DownloadState = .none
}


enum DownloadState : String {
    case downloading
    case finished
    case error
    case none
}

//
//  Enumerations.swift
//  AudioPlayer
//
//  Created by Abdelhak Jemaii on 24.11.17.
//  Copyright © 2017 Abdelhak Jemaii. All rights reserved.
//

import Foundation

enum Errors : String {
    case failed = "Can't use this AVAsset because one of it's keys failed to load"
    case notPlayable = "Can't use this AVAsset because it isn't playable or has protected content"
    case none = "EveryThing is Fine"
}

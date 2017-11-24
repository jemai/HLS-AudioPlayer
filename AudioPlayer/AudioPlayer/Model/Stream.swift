/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A simple class that represents an entry from the `Streams.plist` file in the main application bundle.
 */

import Foundation

class Stream: Codable {
    
    // MARK: Types
    
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case playlistURL = "playlist_url"
    }
    init(name : String , playList : String) {
        self.name = name
        self.playlistURL = playList
    }
    // MARK: Properties
    
    /// The name of the stream.
    let name: String
    
    /// The URL pointing to the HLS stream.
    let playlistURL: String
}

extension Stream: Equatable {
    static func ==(lhs: Stream, rhs: Stream) -> Bool {
        return (lhs.name == rhs.name) && (lhs.playlistURL == rhs.playlistURL)
    }
}


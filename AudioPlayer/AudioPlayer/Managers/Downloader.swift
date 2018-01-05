//
//  Downloader.swift
//  AudioPlayer
//
//  Created by Abdelhak Jemaii on 05.01.18.
//  Copyright © 2018 Abdelhak Jemaii. All rights reserved.
//

import Foundation

class Downloader {
    
    
    // MARK: - Variables
    var urlString = "" {
        didSet {
            if let url = URL(string : urlString) {
                self.url = url
            }
        }
    }
    //
    var url : URL? {
        didSet {
            
        }
    }
    // singleton
    static let shared : Downloader = Downloader()
    
    
    private func loadUrl(){
        
    }
}

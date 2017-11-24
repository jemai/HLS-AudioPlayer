//
//  DownloadManager.swift
//  AudioPlayer
//
//  Created by Abdelhak Jemaii on 24.11.17.
//  Copyright © 2017 Abdelhak Jemaii. All rights reserved.
//

import Foundation
import AVFoundation

//
class DownloadManager {
    
    /*
     * // MARK: - function to load the data
     */
    
    class func loadData(from url : URL, completion : @escaping (_ result : URL? ,_ error : Error?) -> Void) {
        //
        URLSession.shared.dataTask(with: url , completionHandler: { (data, response, error) -> Void in
            if error != nil {
                completion(nil, error)
            } else {
                
                let filePath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("sound.mp3")
                do {
                    try data?.write(to: filePath, options: .atomic)
                    
                    completion(filePath, nil)
                } catch let error {
                    print(error)
                }
            }
            
        }).resume()
    }
    
}

//
//  HLSManager.swift
//  AudioPlayer
//
//  Created by Abdelhak Jemaii on 05.12.17.
//  Copyright © 2017 Abdelhak Jemaii. All rights reserved.
//

import Foundation
import AVFoundation

class HLSManager : NSObject , AVAssetDownloadDelegate{
    // shared instance
    static let shared : HLSManager = HLSManager()
    
    //
    var urlSession : AVAssetDownloadURLSession!
    var location : URL?
    var asset : Asset?
    //
    override private init() {
        super.init()
        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: Identifiers.sessionConfId)
        urlSession = AVAssetDownloadURLSession(configuration: backgroundConfiguration, assetDownloadDelegate: self, delegateQueue: OperationQueue.main)
    }

    
    /// Triggers the initial AVAssetDownloadTask for a given Asset.
    func downloadStream(for asset: Asset) {
        
        //
        self.asset = asset
        
        // Get the default media selections for the asset's media selection groups.
        let preferredMediaSelection = asset.urlAsset.preferredMediaSelection
        
        /*
         Creates and initializes an AVAggregateAssetDownloadTask to download multiple AVMediaSelections
         on an AVURLAsset.
         
         For the initial download, we ask the URLSession for an AVAssetDownloadTask with a minimum bitrate
         corresponding with one of the lower bitrate variants in the asset.
         */
        guard let task =
            urlSession.aggregateAssetDownloadTask(with: asset.urlAsset,
                                                               mediaSelections: [preferredMediaSelection],
                                                               assetTitle: asset.name,
                                                               assetArtworkData: nil,
                                                               options:
                [AVAssetDownloadTaskMinimumRequiredMediaBitrateKey: 265_000]) else { return }
        
        // To better track the AVAssetDownloadTask we set the taskDescription to something unique for our sample.
        task.taskDescription = asset.name
        
        task.resume()
        
        var userInfo = [String: Any]()
        userInfo[Keys.Asset.name] = asset.name
        userInfo[Keys.Asset.downloadState] = DownloadState.downloading.rawValue
        
        NotificationCenter.default.post(name: .AssetDownloadStateChanged, object: nil, userInfo:  userInfo)
    }
    

    
    /*
     * // MARK: - Delegate implementation
     */
    
    /// Tells the delegate that the task finished transferring data.
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("error \(error)")
    }
    
    /// Method called when the an aggregate download task determines the location this asset will be downloaded to.
    func urlSession(_ session: URLSession, aggregateAssetDownloadTask: AVAggregateAssetDownloadTask, willDownloadTo location: URL) {
        
        /*
         This delegate callback should only be used to save the location URL
         somewhere in your application. Any additional work should be done in
         `URLSessionTaskDelegate.urlSession(_:task:didCompleteWithError:)`.
         */
        self.location = location
        print("willDownloadTo \(location)")
    }
    
    /// Method called when a child AVAssetDownloadTask completes.
    func urlSession(_ session: URLSession, aggregateAssetDownloadTask: AVAggregateAssetDownloadTask, didCompleteFor mediaSelection: AVMediaSelection) {
        /*
         This delegate callback provides an AVMediaSelection object which is now fully available for
         offline use. You can perform any additional processing with the object here.
         */
        print("didCompleteFor mediaSelection \(mediaSelection)")

        guard let asset = self.asset else { return }
        
        // Prepare the basic userInfo dictionary that will be posted as part of our notification.
        var userInfo = [String: Any]()
        userInfo[Keys.Asset.name] = asset.name
        
        aggregateAssetDownloadTask.taskDescription = asset.name
        
        aggregateAssetDownloadTask.resume()
        
        userInfo[Keys.Asset.downloadState] = DownloadState.downloading.rawValue
        userInfo[Keys.Asset.locaion] = self.location!

        NotificationCenter.default.post(name: .AssetDownloadStateChanged, object: nil, userInfo: userInfo)
    }

    /// Method to adopt to subscribe to progress updates of an AVAggregateAssetDownloadTask.
    func urlSession(_ session: URLSession, aggregateAssetDownloadTask: AVAggregateAssetDownloadTask, didLoad timeRange: CMTimeRange, totalTimeRangesLoaded loadedTimeRanges: [NSValue],
                    timeRangeExpectedToLoad: CMTimeRange, for mediaSelection: AVMediaSelection) {
        print("didCompleteFor \(timeRange) \(loadedTimeRanges)")
    }
}

//
//  PlayerHolder.swift
//  AudioPlayer
//
//  Created by Abdelhak Jemaii on 23.11.17.
//  Copyright © 2017 Abdelhak Jemaii. All rights reserved.
//

import UIKit

class PlayerHolder: UIView {
    
    // MARK: - Views
    lazy var player: Player = {
        let player = Player()
        player.translatesAutoresizingMaskIntoConstraints = false
        player.layer.cornerRadius = playerDimension/2
        player.backgroundColor = .gray
        return player
    }()
    //
    let playerDimension = Dimensions.playerDimension - 20
    let notificationCenter = NotificationCenter.default
    //
    var animator: UIDynamicAnimator?
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //
        addPanGestureRecognizer()
        //
        addSubview(player)
        //
        NSLayoutConstraint.activate([
            player.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            player.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            player.widthAnchor.constraint(equalToConstant: playerDimension),
            player.heightAnchor.constraint(equalToConstant: playerDimension),
            ])
        //
        notificationCenter.addObserver(self, selector: #selector(downloadState(_:)), name: .AssetDownloadStateChanged, object: nil)
    }
    
    @objc func downloadState(_ notification : Notification) {
        if notification.userInfo![Keys.Asset.downloadState] as! String ==  DownloadState.downloading.rawValue {
            player.url = notification.userInfo![Keys.Asset.locaion] as? URL
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    func addPanGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handle))
        self.addGestureRecognizer(panGesture)
    }
    //
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        //
        addTapGesture()
    }
}

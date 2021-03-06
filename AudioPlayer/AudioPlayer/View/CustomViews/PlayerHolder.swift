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
    var timer : Timer!
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

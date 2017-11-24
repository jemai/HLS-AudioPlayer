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
    //
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    func addPanGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handle))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func handle(panGesture: UIPanGestureRecognizer) {
        // get translation
        let translation = panGesture.translation(in: self)
        panGesture.setTranslation(.zero, in: self)

        // create a new Label and give it the parameters of the old one
        guard let view = panGesture.view else { return }
        view.center = CGPoint(x: view.center.x+translation.x, y: view.center.y+translation.y)
        view.isMultipleTouchEnabled = true
        view.isUserInteractionEnabled = true
        
        //
        // checking the gesture state so we can react to that
        //
        
        switch panGesture.state {
        case .began:
            break
        case .ended:
            break
        case .changed:
            break
        default:
            break
        }
    }
    
}

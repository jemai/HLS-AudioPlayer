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
    //
    func addTapGesture(){
        if let superView = superview {
            superView.isUserInteractionEnabled = true
            superView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSuper)))
        }
    }
    //
    @objc func didTapSuper(gesture: UITapGestureRecognizer) {
        self.animator = UIDynamicAnimator(referenceView: self.superview!)
        let point = gesture.location(in: superview)
        let snap = UISnapBehavior(item: self, snapTo: point)
        animator?.addBehavior(snap)
    }
    //
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

//
//  PlayerHolder+BeatsViewer.swift
//  AudioPlayer
//
//  Created by Abdelhak Jemaii on 11.01.18.
//  Copyright © 2018 Abdelhak Jemaii. All rights reserved.
//

import Foundation
import UIKit

extension PlayerHolder {
    func dorwFloodingCircle(){
        let view = UIView(frame: self.frame)
        view.layer.cornerRadius = self.frame.width/2
        superview?.addSubview(view)
        superview?.bringSubview(toFront: self)
        view.backgroundColor = .red
        //
        UIView.animate(withDuration: 0.6, animations: {
            view.transform = CGAffineTransform(scaleX: 2, y: 2)
            view.alpha -= 1
        }) { (didFinish) in
            view.removeFromSuperview()
        }
    }
    //
    func goBeatIt(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
            self.dorwFloodingCircle()
        }
    }
}

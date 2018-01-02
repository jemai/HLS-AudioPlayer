//
//  PlayerHolder+Animations.swift
//  AudioPlayer
//
//  Created by Abdelhak Jemaii on 02.01.18.
//  Copyright © 2018 Abdelhak Jemaii. All rights reserved.
//

import UIKit

extension PlayerHolder {
    //
    func addTapGesture(){
        if let superView = superview {
            superView.isUserInteractionEnabled = true
            superView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSuper)))
        }
    }
    //
    @objc func didTapSuper(gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: superview)
        self.snap(to: point)
        //
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (finished) in
            self.fixPosition()
        }
    }
    //
    @objc func handle(panGesture: UIPanGestureRecognizer) {
        // get translation
        let translation = panGesture.translation(in: self)
        panGesture.setTranslation(.zero, in: self)
        
        if let animator = self.animator {
            animator.removeAllBehaviors()
        }
        
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
            fixPosition()
        case .changed:
            break
        default:
            break
        }
    }
    //
    func fixPosition(){
        var isAtRight = false
        // fixing position
        if self.center.x + playerDimension/2 > window!.frame.width && self.center.y + playerDimension/2 > window!.frame.height  {
            let point = CGPoint(x: window!.frame.width - playerDimension/2, y: window!.frame.height - playerDimension/2)
            self.snap(to: point)
            isAtRight = true
        } else if self.center.x + playerDimension/2 > window!.frame.width {
            let point = CGPoint(x: window!.frame.width - playerDimension/2, y: self.center.y)
            self.snap(to: point)
            isAtRight = true
        } else if self.center.y + playerDimension/2 > window!.frame.height {
            let point = CGPoint(x: self.center.x ,y: window!.frame.height - playerDimension/2)
            self.snap(to: point)
            isAtRight = true
        }
        
        if isAtRight {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (timer) in
                // fixing position
                self.fixLeftTopSide()
            })
        } else {
            fixLeftTopSide()
        }
    }
    //
    func fixLeftTopSide(){
        if self.center.x - self.playerDimension/2 < 0 && self.center.y - self.playerDimension/2 < 0  {
            let point = CGPoint(x:  self.playerDimension/2, y: self.playerDimension/2)
            self.snap(to: point)
        } else if self.center.x - self.playerDimension/2 < 0 {
            let point = CGPoint(x: self.playerDimension/2, y: self.center.y)
            self.snap(to: point)
        } else if self.center.y - self.playerDimension/2 < 0 {
            let point = CGPoint(x: self.center.x ,y: self.playerDimension/2)
            self.snap(to: point)
        }
    }
    //
    func snap(to point : CGPoint ){
        self.animator = UIDynamicAnimator(referenceView: self.superview!)
        let snap = UISnapBehavior(item: self, snapTo: point)
        animator?.addBehavior(snap)
    }

}

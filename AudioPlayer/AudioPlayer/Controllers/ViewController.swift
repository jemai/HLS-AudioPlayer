//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Abdelhak Jemaii on 23/11/2017.
//  Copyright © 2017 Abdelhak Jemaii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Views
    lazy var playerHolder: PlayerHolder = {
        let holder = PlayerHolder()
        holder.backgroundColor = Colors.main
        //
        holder.layer.cornerRadius = playerDimension/2
        holder.frame = CGRect(origin: self.view.center, size: CGSize(width: playerDimension, height: playerDimension))
        //
        return holder
    }()
    
    // MARK: - Variables
    let playerDimension = Dimensions.playerDimension
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(playerHolder)
        //
        HLSManager.shared.downloadStream(for: Asset())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



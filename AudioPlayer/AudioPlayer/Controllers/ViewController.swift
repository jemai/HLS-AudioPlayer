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
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.backgroundColor = Colors.main
        //
        holder.layer.cornerRadius = playerDimension/2
        //
        return holder
    }()
    
    // MARK: - Variables
    let playerDimension : CGFloat = 300
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(playerHolder)
        NSLayoutConstraint.activate([
            playerHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerHolder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playerHolder.widthAnchor.constraint(equalToConstant: playerDimension),
            playerHolder.heightAnchor.constraint(equalToConstant: playerDimension),
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


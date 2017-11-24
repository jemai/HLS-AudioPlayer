//
//  Player.swift
//  AudioPlayer
//
//  Created by Abdelhak Jemaii on 24.11.17.
//  Copyright © 2017 Abdelhak Jemaii. All rights reserved.
//

import UIKit
import AVFoundation

class Player: UIView {
    
    // MARK: - Views
    lazy var playBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "play_icon"), for: .normal)
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    //
    lazy var pauseBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "pause_icon"), for: .normal)
        button.addTarget(self, action: #selector(pause), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    //
    lazy var restartBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "restart_icon"), for: .normal)
        button.addTarget(self, action: #selector(restart), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    //
    lazy var playerTraker: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .white
        return slider
    }()
    //
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = "00:00|00:00"
        return label
    }()
    // MARK: - Variables
    var timer : Timer?
    var player = AVAudioPlayer()
    //
    var url : URL? {
        didSet {
            guard let url = url else { return }
            //
            DownloadManager.loadData(from: url) { (localUrl, error) in
                self.configureSession(for: localUrl!)
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //
        backgroundColor = .black
        //
        addSubview(playBtn)
        addSubview(pauseBtn)
        addSubview(restartBtn)
        addSubview(playerTraker)
        addSubview(timeLabel)
        //
        NSLayoutConstraint.activate([
            //
            playerTraker.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerTraker.bottomAnchor.constraint(equalTo: centerYAnchor, constant : -16),
            playerTraker.widthAnchor.constraint(equalTo: widthAnchor, multiplier : 0.9),
            //
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: playerTraker.topAnchor , constant : -8),
            timeLabel.widthAnchor.constraint(equalTo: widthAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 44),
            //
            playBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playBtn.topAnchor.constraint(equalTo: playerTraker.bottomAnchor , constant : 8),
            playBtn.widthAnchor.constraint(equalToConstant: 64),
            playBtn.heightAnchor.constraint(equalToConstant: 64),
            //
            pauseBtn.leadingAnchor.constraint(equalTo: playBtn.trailingAnchor , constant : 8),
            pauseBtn.topAnchor.constraint(equalTo: playBtn.centerYAnchor),
            pauseBtn.widthAnchor.constraint(equalToConstant: 44),
            pauseBtn.heightAnchor.constraint(equalToConstant: 44),
            //
            restartBtn.trailingAnchor.constraint(equalTo: playBtn.leadingAnchor , constant : -8),
            restartBtn.topAnchor.constraint(equalTo: playBtn.centerYAnchor),
            restartBtn.widthAnchor.constraint(equalToConstant: 44),
            restartBtn.heightAnchor.constraint(equalToConstant: 44),
            //
            ])
        //
        playerTraker.addTarget(self, action: #selector(trackToTime), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //configuring session
    func configureSession(for url  : URL ){
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            //
            
            let audioSession = AVAudioSession.sharedInstance()
            //
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
                
            } catch let sessionError {
                print("session error \(sessionError)")
            }
        } catch let songPlayerError {
            print(songPlayerError)
        }
        

    }
    
    // MARK: - Controle functions
    //
    @objc func play() {
        player.play()
        startTracking()
    }
    //
    @objc func pause(){
        if player.isPlaying {
            player.pause()
        }
    }
    //
    @objc func restart(){
        player.stop()
        player.currentTime = 0
        player.play()
        startTracking()
    }
    // tracking functions
    func startTracking() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (time) in
            let normalizedTime = Float(self.player.currentTime / self.player.duration)
            self.playerTraker.value = normalizedTime
            self.updateLabel()
        })
    }
    //
    func stopTacking(){
        timer?.invalidate()
    }
    //
    @objc func trackToTime(){
        player.currentTime = Double(playerTraker.value) * self.player.duration
    }
    //
    deinit {
        stopTacking()
    }
    //
    //
    func updateLabel(){
        timeLabel.text = "\(player.currentTime.getTime())|\(player.duration.getTime())"
    }
}


// MARK: - Extension to get time string from Time interval
extension TimeInterval {
    func getTime() -> String {
        if self > 10 {
            if self > 59 {
                let sec = Int(self.truncatingRemainder(dividingBy: 60))
                let min = Int(self/60)
                if sec > 10 {
                    return "\(min):\(sec)"
                } else {
                    return "\(min):0\(sec)"
                }
            } else {
                return "00:\(Int(self))"
            }
        } else {
            return "00:0\(Int(self))"
        }
    }
}



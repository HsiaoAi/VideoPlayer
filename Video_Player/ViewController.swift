//
//  ViewController.swift
//  Video_Player
//
//  Created by Hsiao Ai LEE on 19/01/2018.
//  Copyright © 2018 Hsiao Ai LEE. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {

    // Properties
    let searchBar = UISearchBar()

    lazy var buttonsPanelView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 623, width: 375, height: 44))
        view.backgroundColor = .black
        return view
    }()

    lazy var playbutton: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 636, width: 100, height: 19))
        button.tintColor = .white
        button.setTitle(PlayStatus.play.rawValue, for: .normal)
        button.tintColor = .white
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(tapPlayButton), for: .touchUpInside)
        return button
    }()

    lazy var mutebutton: UIButton = {
        let button = UIButton(frame: CGRect(x: 320, y: 636, width: 100, height: 19))
        button.tintColor = .white
        button.setTitle(NSLocalizedString("Mute", comment: ""), for: .normal)
        button.titleLabel?.textAlignment = .right
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(switchMuteMode), for: .touchUpInside)
        return button
    }()

    lazy var displayView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 64, width: 375, height: 559))
        view.backgroundColor = .clear
        return view
    }()

    lazy var player: AVPlayer = {
        let player = AVPlayer()
        // player.addObserver(self, forKeyPath: "rate", options: [], context: nil)
        return player
    }()

    lazy var playerLayer: AVPlayerLayer = {
        let playerLayer = AVPlayerLayer()
        return playerLayer
    }()

    lazy var videoURL: String = {
        let url = ""
        return url
    }()

    // Flag
    var isMute = false {
        didSet {
            self.player.isMuted = isMute
            let muteButtonTitle = isMute ? "UnMute" : "Mute"
            self.mutebutton.setTitle(muteButtonTitle, for: .normal)
        }
    }

    var isPlaying = false {

        didSet {
            let playButtonTitle = isPlaying ? "Pause" : "Play"
            self.playbutton.setTitle(playButtonTitle, for: .normal)
        }

    }

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchBar()
        setupNavigationBar()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.player.addObserver(self, forKeyPath: "status", options: .new, context: nil)
    }

    func setupUI() {
        displayView.backgroundColor = .clear
        view.backgroundColor = UIColor(red: 8 / 255.0, green: 21 / 255.0, blue: 35 / 255.0, alpha: 1.0)
        self.view.addSubview(buttonsPanelView)
        self.view.addSubview(playbutton)
        self.view.addSubview(mutebutton)
        self.view.addSubview(displayView)
    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }

    func setupSearchBar() {
        searchBar.tintColor = .white
        searchBar.sizeToFit()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = NSLocalizedString("Enter URL of video", comment: "")
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.resignFirstResponder()
        navigationItem.titleView = searchBar
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

        guard let keyPath = keyPath,
            let item = object as? AVPlayerItem else { return }

        if keyPath == #keyPath(AVPlayerItem.status) {
            switch item.status {

            case .readyToPlay:

                self.player.play()

            case .failed:
                print("Failed")

            default:
                break

            }
        }

    }

}

extension ViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchVideo()

    }

    func searchVideo() {

        guard let text = searchBar.text,
        !text.isEmpty else { return }
        self.videoURL = searchBar.text!
        prepareForPlayingVideo()
        self.searchBar.text = ""

    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        searchBar.text = ""
        searchBar.showsCancelButton = false
        self.searchBar.endEditing(true)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }
}

extension ViewController {
    // Video play related functions

    func prepareForPlayingVideo() {

        isPlaying = true
        let playItem = AVPlayerItem(url: URL(string: self.videoURL)!)
        playItem.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: .new, context: nil)
        self.player = AVPlayer(playerItem: playItem)
        self.playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.displayView.bounds
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        self.view.bringSubview(toFront: displayView)
        self.displayView.layer.addSublayer(playerLayer)

    }

    @objc func switchMuteMode() {
        self.isMute = self.isMute ? false : true
    }

    @objc func tapPlayButton() {

        self.isPlaying = self.isPlaying ? false : true
        if isPlaying {
            self.player.play()
        } else {
            self.player.pause()
        }
    }

}

extension ViewController {

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonsPanelView.translatesAutoresizingMaskIntoConstraints = false
        buttonsPanelView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        buttonsPanelView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        buttonsPanelView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonsPanelView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        playbutton.translatesAutoresizingMaskIntoConstraints = false
        playbutton.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
        playbutton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        playbutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        playbutton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12.0).isActive = true

        mutebutton.translatesAutoresizingMaskIntoConstraints = false
        mutebutton.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
        mutebutton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        mutebutton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        mutebutton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12.0).isActive = true

        displayView.translatesAutoresizingMaskIntoConstraints = false
        displayView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 1.0).isActive = true
        displayView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        displayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        displayView.bottomAnchor.constraint(equalTo: buttonsPanelView.topAnchor).isActive = true

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.playerLayer.frame = self.displayView.bounds
    }
}

enum PlayStatus: String {
    case play = "Play", pause = "Pause"
}

//
//  ViewController.swift
//  Video_Player
//
//  Created by Hsiao Ai LEE on 19/01/2018.
//  Copyright © 2018 Hsiao Ai LEE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Properties
    let searchBar = UISearchBar()

    lazy var buttonsPanelView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 623, width: 375, height: 44))
        view.backgroundColor = .black
        return view
    }()

    lazy var playbutton: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 636, width: 33, height: 19))
        button.tintColor = .white
        button.setTitle(NSLocalizedString("Play", comment: ""), for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()

    lazy var mutebutton: UIButton = {
        let button = UIButton(frame: CGRect(x: 320, y: 636, width: 39, height: 19))
        //let button = UIButton()
        button.tintColor = .white
        button.setTitle(NSLocalizedString("Mute", comment: ""), for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()

    lazy var displayView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 64, width: 375, height: 559))
        view.backgroundColor = .white
        return view
    }()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchBar()
        setupNavigationBar()
    }

    func setupUI() {
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
        // ToDo palceholder text style
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

}

extension ViewController: UISearchBarDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }

    func searchVideo() {

    }
}

extension ViewController {

    override func viewWillLayoutSubviews() {

        buttonsPanelView.translatesAutoresizingMaskIntoConstraints = false
        buttonsPanelView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        buttonsPanelView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        buttonsPanelView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonsPanelView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        playbutton.translatesAutoresizingMaskIntoConstraints = false
        playbutton.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
        playbutton.widthAnchor.constraint(equalToConstant: 33.0).isActive = true
        playbutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        playbutton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12.0).isActive = true

        mutebutton.translatesAutoresizingMaskIntoConstraints = false
        mutebutton.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
        mutebutton.widthAnchor.constraint(equalToConstant: 39.0).isActive = true
        mutebutton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        mutebutton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12.0).isActive = true

        displayView.translatesAutoresizingMaskIntoConstraints = false
        displayView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 1.0).isActive = true
        displayView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        displayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        displayView.bottomAnchor.constraint(equalTo: buttonsPanelView.topAnchor).isActive = true

    }
}

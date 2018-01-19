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
        button.tintColor = .white
        button.setTitle(NSLocalizedString("Mute", comment: ""), for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
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

//
//  ViewController.swift
//  CustomLoader
//
//  Created by VADIM FIRSOV on 15/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var someLoader: CustomLoader!
    
    var loader : CustomLoader!
    var isActive = false
    
    var LOADER_ON = "LOADER ON"
    var LOADER_OFF = "LOADER OFF"
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        setupButton()
    }
    
    func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        button.setTitle(LOADER_ON, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        
        button.frame = CGRect(x: (view.frame.width / 2) - 60, y: view.frame.height / 1.12, width: 120, height: 50)
        
        button.layer.borderWidth = 2.0
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = button.frame.height / 2
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(buttonPressed), for: UIControl.Event.touchUpInside)
        
        view.addSubview(button)
    }

    @objc func buttonPressed() {
        if isActive == false {
            setupLoader(loaderSize: 50)
            button.setTitle(LOADER_OFF, for: .normal)
            buttonFadingAnimation(alpha: 0.2)
            isActive = true

        } else {
            loader.terminateLoader()
            button.setTitle(LOADER_ON, for: .normal)
            isActive = false
            buttonFadingAnimation(alpha: 1.0)
            loader = nil
        }
    }
    
    func setupLoader(loaderSize size: CGFloat) {
        loader = CustomLoader()
        let x = Double((view.frame.width - size) / 2)
        let y = Double(view.frame.height / 1.35)
        loader.setupLoader(forViewParent: view, frame_x: x, y: y, size: Double(size), boundsColor: nil)
        loader.startLoader()
    }
    
    func buttonFadingAnimation(alpha : CGFloat) {
        UIView.animate(withDuration: 1) {
            weak var weakSelf = self
            weakSelf?.button.alpha = alpha
        }
    }
}


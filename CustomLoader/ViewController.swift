//
//  ViewController.swift
//  CustomLoader
//
//  Created by VADIM FIRSOV on 15/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loaderFromStoryBoard: CustomLoader!
    
    var loaderCreatedProgramatically : CustomLoader!
    var isActive = false
    
    var LOADER_ON = "LOADER ON"
    var LOADER_OFF = "LOADER OFF"
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loaderFromStoryBoard.startLoader()
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//        setupButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupButton()
    }
    
    
    func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        view.addSubview(button)

        button.setTitle(LOADER_ON, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)

        button.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 1.2).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-70).isActive = true
 
        button.layoutIfNeeded()
        button.layer.borderWidth = 2.0
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = button.frame.height / 2
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(buttonPressed), for: UIControl.Event.touchUpInside)
    }

    @objc func buttonPressed() {
        if isActive == false {
            setupLoader(loaderSize: 50)
            button.setTitle(LOADER_OFF, for: .normal)
            buttonFadingAnimation(alpha: 0.2)
            isActive = true

        } else {
            loaderCreatedProgramatically.terminateLoader()
            button.setTitle(LOADER_ON, for: .normal)
            isActive = false
            buttonFadingAnimation(alpha: 1.0)
            loaderCreatedProgramatically = nil
        }
    }
    
    func setupLoader(loaderSize size: CGFloat) {
        loaderCreatedProgramatically = CustomLoader()
        let x = Double((view.frame.width - size) / 2)
        let y = Double(view.frame.height / 1.5)

        loaderCreatedProgramatically.setupLoader(forViewParent: view, frame_x: x, y: y, size: Double(size), boundsColor: nil)
        loaderCreatedProgramatically.startLoader()
    }
    
    func buttonFadingAnimation(alpha : CGFloat) {
        UIView.animate(withDuration: 1) {
            weak var weakSelf = self
            weakSelf?.button.alpha = alpha
        }
    }
}


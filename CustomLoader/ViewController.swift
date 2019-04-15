//
//  ViewController.swift
//  CustomLoader
//
//  Created by VADIM FIRSOV on 15/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var loader = CustomLoader()
    var isActive = false
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        
    }
    
    func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)

        button.frame = CGRect(x: (view.frame.width / 2) - 60, y: view.frame.height / 1.25, width: 120, height: 50)
        
        button.layer.borderWidth = 2.0
        button.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = button.frame.height / 2
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(buttonPressed), for: UIControl.Event.touchUpInside)
        
        view.addSubview(button)
    }

    @objc func buttonPressed() {
        if isActive == false {
            loader.startLoader(view: view, squareColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), sizeMultiplier: 2)
            isActive = true

        } else {
            loader.terminateLoader()
            isActive = false
        }
    }

}


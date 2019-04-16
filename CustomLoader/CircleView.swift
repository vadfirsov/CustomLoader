//
//  CircleView.swift
//  CustomLoader
//
//  Created by VADIM FIRSOV on 16/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit

class CircleView : UIView {
    
    init(x : Double, y : Double, size : Double, borderColor color : CGColor) {
        super.init(frame: CGRect(x: x, y: y, width: size, height: size) )
        
        layer.masksToBounds = false
        layer.cornerRadius = CGFloat(size / 2)
        layer.borderWidth = 1
        layer.borderColor = color
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animation(x : Double, y : Double, size : Double, withDelay delay : TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.animate(withDuration: 0.5) {
                UIView.setAnimationRepeatAutoreverses(true)
                UIView.setAnimationRepeatCount(.infinity)
                weak var weakSelf = self //PREVENTS MEMORY LEAKS
                weakSelf?.frame = CGRect(x: x, y:  y, width: size, height: size)
            }
        }
    }
}

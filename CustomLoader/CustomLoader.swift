//  CustomLoader.swift
//  MovieApp_Tingztest
//
//  Created by VADIM FIRSOV on 15/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//
import UIKit

class CustomLoader {
    
    private var timer = Timer()
    
    private var miniCircleView = UIView()
    private var bigSquareView = UIView()
    
    private var miniCircleSize : Double = 12
    private var bigSquareWidth : Double = 1
    private var bigSquareSize : Double = 40
    
    func startLoader(view : UIView, squareColor : CGColor, sizeMultiplier : Double?) {
        
        //GET RANDOM COLOR EVERY TIME ITS CALLED
        var changingColor : UIColor {
            let someColor = UIColor(red: getComponant(), green: getComponant(), blue: getComponant(), alpha: 1.0)
            return someColor
        }
        
        //SETUP SIZES
        if sizeMultiplier != nil {
            miniCircleSize = miniCircleSize * sizeMultiplier!
            bigSquareSize = bigSquareSize * sizeMultiplier!
            bigSquareWidth = bigSquareWidth * sizeMultiplier!
        }
        
        //SETUP BIG LOADING SQUARE
        bigSquareView.translatesAutoresizingMaskIntoConstraints = false
        bigSquareView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        view.addSubview(bigSquareView)
        
        //SETUP SMALL CIRCLE
        miniCircleView.translatesAutoresizingMaskIntoConstraints = false
        miniCircleView.backgroundColor = #colorLiteral(red: 0.7305665612, green: 0.3118938208, blue: 0.9156422615, alpha: 1)
        bigSquareView.addSubview(miniCircleView)
        
        
        //MAKING THE BORDERS OF THE SQUARE
        bigSquareView.layer.borderWidth = CGFloat(bigSquareWidth)
        bigSquareView.layer.borderColor = squareColor
        

        
        //CALCULATING THE BIG SQUARE FRAME INSIDE THE PARENT VIEW
        bigSquareView.frame = CGRect(x: Double(view.frame.width / 2) - (bigSquareSize / 2),
                                     y: Double(view.frame.height / 3),
                                     width: bigSquareSize,
                                     height: bigSquareSize)
        
        //CALCULATING THE CIRCLE FRAME INSIDE THE SQUARE
        miniCircleView.frame = CGRect(x: Double(bigSquareView.frame.width) - miniCircleSize - 3 - bigSquareWidth,
                                      y: 3 + bigSquareWidth,
                                      width: miniCircleSize,
                                      height: miniCircleSize)
        
        //MAKING THE CIRCLE VIEW ROUND
        miniCircleView.layer.masksToBounds = false
        miniCircleView.layer.cornerRadius = miniCircleView.frame.width / 2
        
        //FIRST ROUND ROTATE FIXING DELAY
        bigSquareView.rotate360Degrees(duration: 2, completionDelegate: nil)
        UIView.animate(withDuration: 2.0) {
            self.bigSquareView.backgroundColor = changingColor
            self.miniCircleView.backgroundColor = changingColor
        }
        
        //MAKING THE SQUARE TO ROTATE 360 EACH 2 SEC
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
            self.bigSquareView.rotate360Degrees(duration: 2, completionDelegate: nil)
            UIView.animate(withDuration: 2, animations: {
                self.bigSquareView.backgroundColor = changingColor
                self.miniCircleView.backgroundColor = changingColor
            })
        })
        
        
        //ANIMATING THE CIRCLE MOVEMENT INSIDE THE SQUARE
        UIView.animate(withDuration: 0.5) {
            UIView.setAnimationRepeatAutoreverses(true)
            UIView.setAnimationRepeatCount(.infinity)
            self.miniCircleView.frame = CGRect(x: 3 + self.bigSquareWidth,
                                               y:  3 + self.bigSquareWidth,
                                               width: self.miniCircleSize,
                                               height: self.miniCircleSize)
        }
    }

    
    func getComponant() -> CGFloat {
        return CGFloat((arc4random() % 256)) / 255.0;
    }
    
    func terminateLoader() {
        timer.invalidate()
        bigSquareView.removeFromSuperview()
    }
}

extension UIView {
    
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(3.14159265358979 * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = (delegate as! CAAnimationDelegate)
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
}


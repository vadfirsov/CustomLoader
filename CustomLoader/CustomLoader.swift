//  CustomLoader.swift
//  MovieApp_Tingztest
//
//  Created by VADIM FIRSOV on 15/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//
import UIKit

class CustomLoader : UIView {

    private var timer = Timer()
    
    private var loaderFrame = CGRect()
    
    private var circleSize : Double = 12
    private var squareBoundsWidth : Double = 1.2
    
    private var boundsColor : CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    //GET RANDOM COLOR EVERY TIME ITS CALLED
    private var changingColor : UIColor {
        var randomComponent : CGFloat { return CGFloat((arc4random() % 256)) / 255.0; }
        let someColor = UIColor(red: randomComponent, green: randomComponent, blue: randomComponent, alpha: 1.0)
        return someColor
    }
    
    //SETSUP THE LOADER IN PARENT VIEW
    func setupLoader(forViewParent view : UIView, frame_x x: Double, y : Double, size : Double, boundsColor : CGColor?) {       
        if boundsColor != nil {
            self.boundsColor = boundsColor!
        }
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        view.addSubview(self)
        alpha = 0.0
        frame = CGRect(x: x, y: y, width: size, height: size)
        layer.borderWidth = CGFloat(squareBoundsWidth)
        layer.borderColor = self.boundsColor
    }
    
    func startLoader() {
        //SETUP SIZES ACCORDING TO INPUT IN SETUP LOADER
        circleSize = Double(frame.height / 3.5)

        //POSITIONS OF THE CIRCLES IN THE FRAME
        let left : Double = 3 + squareBoundsWidth
        let top : Double = 3 + squareBoundsWidth
        let right : Double = Double(frame.width) - circleSize - squareBoundsWidth - 3
        let bottom : Double = Double(frame.height) - circleSize - squareBoundsWidth - 3
        
        //CALCULATING FIRST AND SECOND CIRCLE FRAME INSIDE THE SQUARE
        let circleOne = CircleView(x: right, y: bottom, size: circleSize, borderColor: boundsColor)
        let circleTwo = CircleView(x: right, y: top, size: circleSize, borderColor:  boundsColor)
        
        //ADD CIRCLES
        self.addSubview(circleOne)
        self.addSubview(circleTwo)
        
        //FADE IN EFFECT
        UIView.animate(withDuration: 0.6) {
            weak var weakSelf = self //PREVENTS MEMORY LEAKS
            weakSelf?.alpha = 1.0
        }
        
        //SQUARE ROTATION & COLOR CHANGE
        squareAnimation(circles: circleOne, circleTwo) // FIXING DELAY
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (timer) in
            weak var weakSelf = self
            weakSelf?.squareAnimation(circles: circleOne, circleTwo)
        })
        
        //ANIMATING THE CIRCLES MOVEMENT INSIDE THE SQUARE
        circleOne.animation(x: left, y: top, size: circleSize, withDelay: 0)
        circleTwo.animation(x: left, y: bottom, size: circleSize, withDelay: 0.25) //DELAY PREVENTS COLLISION
    }
    
    private func squareAnimation(circles circleOne : CircleView, _ circleTwo : CircleView) {
        rotate360Degrees(duration: 1.5)
        UIView.animate(withDuration: 1.2, animations: {
            weak var weakSelf = self //PREVENTS MEMORY LEAKS
            weakSelf?.backgroundColor = weakSelf?.changingColor
            circleOne.backgroundColor = weakSelf?.changingColor
            circleTwo.backgroundColor = weakSelf?.changingColor
        })
    }
    
    func terminateLoader() {
        UIView.animate(withDuration: 0.6, animations: {
            weak var weakSelf = self //PREVENTS MEMORY LEAKS
            weakSelf?.alpha = 0.0
        }) { (true) in
            weak var weakSelf = self //PREVENTS MEMORY LEAKS
            weakSelf?.timer.invalidate()
            weakSelf?.removeFromSuperview()
        }
    }
}

//UIVIEW FUNC EXTENTION TO MAKE THE UIVIEW ROTATE
extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(3.14159265358979 * 2.0)
        rotateAnimation.duration = duration

        layer.add(rotateAnimation, forKey: nil)
    }
}

//  CustomLoader.swift
//  MovieApp_Tingztest
//
//  Created by VADIM FIRSOV on 15/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//
import UIKit

class CustomLoader : UIView {
    
    private var timer = Timer()
    private let circleOne = UIView()
    private let circleTwo = UIView()
    
    private var loaderFrame = CGRect()
    
    private var circleSize : Double = 12
    private var squareBoundsWidth : Double = 1.2
    
    private var boundsColor : CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    
    //GET RANDOM COLOR EVERY TIME ITS CALLED
    private var changingColor : UIColor {
        var ranComponent : CGFloat { return CGFloat((arc4random() % 256)) / 255.0; }
        let someColor = UIColor(red: ranComponent, green: ranComponent, blue: ranComponent, alpha: 1.0)
        return someColor
    }
    
    //SETSUP THE LOADER IN PARENT VIEW
    func setupLoader(forViewParent view : UIView, frame_x x: Double, y : Double, size : Double, boundsColor : CGColor?) {
        if boundsColor != nil {
            self.boundsColor = boundsColor!
        }
        setupView(named: self, withParent: view, andColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
        alpha = 0.0
        frame = CGRect(x: x, y: y, width: size, height: size)
        layer.borderWidth = CGFloat(squareBoundsWidth)
        layer.borderColor = self.boundsColor
    }
    
    func startLoader() {
        //SETUP SIZES
        circleSize = Double(frame.height / 3.5)
        
        //SETUP BIG LOADING SQUARE AND TWO SMALL CIRCLES
        setupView(named: circleOne, withParent: self, andColor: #colorLiteral(red: 0.7305665612, green: 0.3118938208, blue: 0.9156422615, alpha: 1))
        setupView(named: circleTwo, withParent: self, andColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        
        //POSITIONS OF THE CIRCLES IN THE FRAME
        let left : Double = 3 + squareBoundsWidth
        let top : Double = 3 + squareBoundsWidth
        let right : Double = Double(frame.width) - circleSize - squareBoundsWidth - 3
        let bottom : Double = Double(frame.height) - circleSize - squareBoundsWidth - 3
        
        //CALCULATING THE FIRST CIRCLE FRAME INSIDE THE SQUARE
        circleOne.frame = CGRect(x: right, y: bottom, width: circleSize, height: circleSize)
        
        //CALCULATING THE SECOND CIRCLE FRAME INSIDE THE SQUARE
        circleTwo.frame = CGRect(x: right, y: top, width: circleSize, height: circleSize)
        
        //MAKING CIRCLES OUT OF SQUARE VIEWS
        makingCircleOutOff(circleOne, withChosenBorderColor: boundsColor)
        makingCircleOutOff(circleTwo, withChosenBorderColor: boundsColor)
        
        //FIRST ROUND ROTATE FIXING DELAY
        rotate360Degrees(duration: 1.5, completionDelegate: nil)
        UIView.animate(withDuration: 1) {
            weak var weakSelf = self //PREVENTS MEMORY LEAKS
            weakSelf?.setColors()
        }
        
        UIView.animate(withDuration: 0.6) {
            weak var weakSelf = self //PREVENTS MEMORY LEAKS
            weakSelf?.alpha = 1.0
        }
        
        //SQUARE ROTATION & COLOR CHANGE
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (timer) in
            self.rotate360Degrees(duration: 1.5, completionDelegate: nil)
            UIView.animate(withDuration: 1, animations: {
                weak var weakSelf = self //PREVENTS MEMORY LEAKS
                weakSelf?.setColors()
            })
        })
        
        //ANIMATING THE CIRCLE MOVEMENT INSIDE THE SQUARE
        UIView.animate(withDuration: 0.5) {
            UIView.setAnimationRepeatAutoreverses(true)
            UIView.setAnimationRepeatCount(.infinity)
            weak var weakSelf = self //PREVENTS MEMORY LEAKS
            weakSelf?.circleOne.frame = CGRect(x: left, y:  top, width: weakSelf!.circleSize, height: weakSelf!.circleSize)
        }
        
        //ANIMATING SECOND CIRCLE WITH DELAY
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            UIView.animate(withDuration: 0.5) {
                UIView.setAnimationRepeatAutoreverses(true)
                UIView.setAnimationRepeatCount(.infinity)
                weak var weakSelf = self //PREVENTS MEMORY LEAKS
                weakSelf?.circleTwo.frame = CGRect(x: left, y: bottom, width: weakSelf!.circleSize, height: weakSelf!.circleSize)
            }
        }
    }
    
    //MAKING THE CIRCLE CIRCLES WITH BORDERS
    private func makingCircleOutOff(_ view : UIView, withChosenBorderColor color : CGColor) {
        view.layer.masksToBounds = false
        view.layer.cornerRadius = circleTwo.frame.width / 2
        view.layer.borderWidth = CGFloat(squareBoundsWidth)
        view.layer.borderColor = color
    }
    
    private func setupView(named view: UIView, withParent parentView : UIView, andColor color: UIColor) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        parentView.addSubview(view)
    }
    
    private func setColors() {
        backgroundColor = changingColor
        circleOne.backgroundColor = changingColor
        circleTwo.backgroundColor = changingColor
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
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(3.14159265358979 * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = (delegate as! CAAnimationDelegate)
        }
        layer.add(rotateAnimation, forKey: nil)
    }
}

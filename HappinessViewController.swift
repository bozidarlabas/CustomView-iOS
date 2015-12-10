//
//  HappinessViewController.swift
//  CustomView-example
//
//  Created by Bozidar on 10.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

//4. Controller decalres that it implemets FaceViewDataSource protocol
class HappinessViewController: UIViewController, FaceViewDataSource {
    
  
    
    
    @IBOutlet weak var faceView: FaceView!{
        //this is called when faceView is initialized
        //3. Conroller sets itself as the delegate of the View by setting the delegate property dataSource (because this class implements FaceViewDataSource protocol)
        didSet{
            faceView.dataSource = self
            //scale: - : is because scale takes argument
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:")) //pinch on face view, action is non private method in faceview that i can call to handle it
        }
    }
    
    private struct Constants{
        static let HappinessGestureScale: CGFloat = 4
    }
    
    
    //UIPanGestureRecognizer implemented from StryBoard
    @IBAction func changeHappiness(sender: UIPanGestureRecognizer) {
        //pan is moving up and down
        switch sender.state{
        case .Ended: fallthrough
        case .Changed:
            //change happiness property
            let translation = sender.translationInView(faceView)
            let happinessChange = -(Int)(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                sender.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
        
    }
    
    //0 = very sad, 100 = ectastic
    //property listener which is useful for updating UI because its called every time when property is changed (happiness property)
    var happiness: Int = 75{
        didSet{
            //if happpiness did set new value then check if this value is between 0 and 100
            happiness = min(max(happiness, 0), 100)
            print("Happiness = \(happiness)")
            updateUI()
        }
    }
    
    //Function that will update UI
    func updateUI(){
        faceView.setNeedsDisplay() //redraw faceView
    }
    
    func smillinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50 //model
    }
}

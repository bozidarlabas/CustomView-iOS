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
        }
    }
    
    
    //0 = very sad, 100 = ectastic
    //property listener
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

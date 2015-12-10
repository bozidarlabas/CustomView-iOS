//
//  HappinessViewController.swift
//  CustomView-example
//
//  Created by Bozidar on 10.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController {
    
    //0 = very sad, 100 = ectastic
    //property listener
    var happiness: Int = 50{
        didSet{
            //if happpiness did set new value then check if this value is between 0 and 100
            happiness = min(max(happiness, 0), 100)
            print("Happiness = \(happiness)")
            updateUI()
        }
    }
    
    //Function that will update UI
    func updateUI(){
        
    }
}

//
//  DiagnosedHappinessViewController.swift
//  CustomView-example
//
//  Created by Bozidar on 10.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate{
    
    override var happiness: Int{
        didSet{
            diagnosticHistory += [happiness]
        }
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var diagnosticHistory: [Int]{
        get{ return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? [] }
        set{ defaults.setObject(newValue, forKey: History.DefaultsKey) }
    }
    
    private struct History{
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.History"
    }
    
    //segue objects are used to prepare for the transition from one view controller to another
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier{
            case History.SegueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController{
                    if let ppc = tvc.popoverPresentationController{
                        ppc.delegate = self
                    }
                        tvc.text = "\(diagnosticHistory)"
                }
            default: break
            }
        }
    }
    
    //this class is responsible to create custom popover presentation style
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        //this is useful for android beacause we dont want to set any style to popover (because on iphone this is full screen)
            return UIModalPresentationStyle.None
    }
    
}

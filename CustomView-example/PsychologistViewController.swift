//
//  ViewController.swift
//  Psychologist
//
//  Created by Bozidar on 10.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let hvc = segue.destinationViewController as? HappinessViewController{
            if let identifier = segue.identifier{
                switch identifier{
                    case "sad": hvc.happiness = 0
                    case "happy": hvc.happiness = 100
                    case "nothing": hvc.happiness = 40
                default: break
                }
            }
        }
    }
}


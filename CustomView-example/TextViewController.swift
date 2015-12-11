//
//  TextViewController.swift
//  CustomView-example
//
//  Created by Bozidar on 10.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!{
        didSet{
            textView.text = text
        }
    }
    
    var text: String = ""{
        didSet{
            textView?.text = text
        }
    }
    
    override var preferredContentSize: CGSize{
        get{
            //presentingViewController = nill if i am in the middle of presenttation
            if textView != nil && presentingViewController != nil{
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            }else{
                return super.preferredContentSize
            }
        }
        set{super.preferredContentSize = newValue}
    }
    
}

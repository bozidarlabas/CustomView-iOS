//
//  HappinessViewController.swift
//  CustomView-example
//
//  Created by Bozidar on 10.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import UIKit

var globalHappinessInstanceCount = 0

//4. Controller decalres that it implemets FaceViewDataSource protocol
class HappinessViewController: UIViewController, FaceViewDataSource {
    
     var instanceCount = { globalHappinessInstanceCount++ }()
  
    
    
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
    
    /////////////View Controller Life Cycle/////////////
    
    //Function that will update UI
    func updateUI(){
        faceView?.setNeedsDisplay() //redraw faceView
        title = "\(happiness)"
    }
    
    func smillinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50 //model
    }
    
    
    func logVCL(msg: String) {
        print("Happiness \(instanceCount) " + msg)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        logVCL("init(coder)")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        logVCL("init(nibName, bundle)")
    }
    
    deinit {
        logVCL("deinit")
    }
    
    override func awakeFromNib() {
        logVCL("awakeFromNib()")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logVCL("viewDidLoad()")
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        logVCL("viewWillAppear(animated = \(animated))")
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        logVCL("viewDidAppear(animated = \(animated))")
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        logVCL("viewWillDisappear(animated = \(animated))")
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        logVCL("viewDidDisappear(animated = \(animated))")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logVCL("viewWillLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logVCL("viewDidLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        logVCL("viewWillTransitionToSize")
        coordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.logVCL("animatingAlongsideTransition")
            }, completion: { context -> Void in
                self.logVCL("doneAnimatingAlongsideTransition")
        })
    }
    
    
}

//
//  ViewController.swift
//  WhatsappStatusRingBar
//
//  Created by divyeshpansuriya-ios on 10/26/2023.
//  Copyright (c) 2023 divyeshpansuriya-ios. All rights reserved.
//

import UIKit
import WhatsappStatusRingBar

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: WhatsappStatusRingBar!
    @IBOutlet weak var totalCount: UISlider!
    @IBOutlet weak var totalSeenCount: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupProgressView()
//
//        let frameworkInfo = Bundle(for: WhatsappStatusRingBar.self)
//        let path = frameworkInfo.path(forResource: "Resources", ofType: "bundle")
//        let bundleURL = Bundle(url: URL(fileURLWithPath: path!))
//        if #available(iOS 13.0, *) {
//            let image = UIImage(named: "profile.png", in: bundleURL, with: nil)
//            print(image)
//        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func totalCountOfStory(_ sender: UISlider) {
        let total = Int(sender.value)
        self.progressView.total = total
        if !sender.isTracking {
            self.totalSeenCount.maximumValue = sender.value
        }
    }
    
    @IBAction func totalCountOfSeenStory(_ sender: UISlider) {
        self.progressView.setProgress(progress: CGFloat(sender.value))
    }
    
    func setupProgressView() {
        self.progressView.total = 5
        self.progressView.setProgress(progress: 3)
    }
}


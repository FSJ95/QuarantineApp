//
//  SecondViewController.swift
//  QuarantineApp
//
//  Created by Frederik Søndergaard Jensen on 01/05/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    /// OLIVER
    @IBOutlet weak var forceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fuldrulle.jpg")!)
        print("2")
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if #available(iOS 9.0, *) {
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                    // 3D Touch capable
                    if touch.force >= touch.maximumPossibleForce {
                        forceLabel.text = "385+ grams of TP, you're good buddy"
                        
                    } else {
                        let force = touch.force/touch.maximumPossibleForce
                        let grams = force * 385
                        let roundGrams = Int(grams)
                        forceLabel.text = "\(roundGrams) grams"
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        forceLabel.text = "0 gram"

    }
    

    
    
}


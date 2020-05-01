//
//  ThirdViewController.swift
//  QuarantineApp
//
//  Created by Frederik Søndergaard Jensen on 01/05/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    /// JONAS
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var intensityTitle: UILabel!
    
    @IBOutlet weak var exercise: UILabel!
    
    //Vars to be used for progressbar calculations.
       var totalTime = 0
       var secondsPassed = 0
       var timer = Timer() //Timer var
    
    //Dictionary with total program times in seconds. 5min and 10min
    let programTime = ["Light":300,
                    "Intense":600]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        exercise.isHidden = true
        progressBar.progress = 0
        
    }
    
    @IBAction func intensityChosenBtn(_ sender: UIButton) {
        
        exercise.isHidden = false
        
        //To reset whenever a button is pressed.
        progressBar.progress = 0
        secondsPassed = 0
        timer.invalidate() //Cancels the timer to avoid multiple timers running
                                  //if multiple buttons pressed.
        
        if sender.currentTitle == "Light" {
            intensityTitle.text = "Running light program!"
            totalTime = programTime[sender.currentTitle!]! //Setting var to whatever option selected
            
            //Assigning timer var to schedueled timer.
            //Repeats every 1 second, selector is obj C convention, calls updateTimer func
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(lightExer), userInfo: nil, repeats: true)
            
        } else{
            intensityTitle.text = "Running intense program!"
            totalTime = programTime[sender.currentTitle!]!
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(intenseExer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func lightExer(){
        secondsPassed += 1
        //Calculate and set a float val of how much is left.
        progressBar.progress = Float(secondsPassed) / Float(totalTime)
        
            switch secondsPassed {
            case 0...30, 150...180:
                exercise.text = "JUMPING JACKS"
            case 30...60, 180...210:
                exercise.text = "BURPEES"
            case 60...90, 210...240:
                exercise.text = "30SEC REST"
            case 90...120, 240...270:
                exercise.text = "SQUATS"
            case 120...150, 270...300:
                exercise.text = "SITUPS"
            case 300:
                exercise.text = "DONE!"
                
            default:
                progressBar.progress = 0
            }
    }
    
    @objc func intenseExer(){
        secondsPassed += 1
        //Calculate and set a float val of how much is left.
        progressBar.progress = Float(secondsPassed) / Float(totalTime)
                   switch secondsPassed {
                   case 30...60, 150...180, 330...360, 480...510:
                       exercise.text = "JUMPING JACKS"
                    
                   case 0...30, 180...210, 360...390, 570...600:
                       exercise.text = "BURPEES"
                    
                   case 60...90, 210...240, 450...480:
                       exercise.text = "30SEC REST"
                    
                   case 90...120, 240...270, 510...540:
                       exercise.text = "JUMP SQUATS"
                    
                   case 120...150, 270...300, 390...420:
                       exercise.text = "SITUPS"
                    
                   case 300...330, 420...450, 540...570:
                    exercise.text = "PUSH UPS"
                    
                   case 600:
                       exercise.text = "DONE!"
                       
                   default:
                       progressBar.progress = 0
                   }
    
    }
}

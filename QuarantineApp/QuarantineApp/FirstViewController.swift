//
//  FirstViewController.swift
//  QuarantineApp
//
//  Created by Frederik Søndergaard Jensen on 01/05/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit
/// FREDERIK
class FirstViewController: UIViewController {
    
    @IBOutlet weak var totalConfirmedLabel: UILabel!
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var newConfirmedLabel: UILabel!
    @IBOutlet weak var newDeathsLabel: UILabel!
    @IBOutlet weak var newRecoveredLabel: UILabel!
    
    let stats = Statistics(newConfirmed: 0, totalConfirmed: 0, newDeaths: 0, totalDeaths: 0, newRecovered: 0, totalRecovered: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        updateLabels(stats:stats)
        fetchAPI()
    }
    
    func updateLabels(stats: Statistics) {
        DispatchQueue.main.async {
            self.totalConfirmedLabel.text = "\(stats.totalConfirmed)"
            self.totalRecoveredLabel.text = "\(stats.totalRecovered)"
            self.totalDeathsLabel.text = "\(stats.totalDeaths)"
            self.newConfirmedLabel.text = "\(stats.newConfirmed)"
            self.newDeathsLabel.text = "\(stats.newDeaths)"
            self.newRecoveredLabel.text = "\(stats.newRecovered)"
        }
    }
    
    func fetchAPI() {
        if let url = URL(string: "https://api.covid19api.com/summary") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                        if let global = res!["Global"] as? NSDictionary{
                            print(global)
                            let stats123 = Statistics(newConfirmed: global["NewConfirmed"] as! Int, totalConfirmed: global["TotalConfirmed"] as! Int, newDeaths: global["NewDeaths"] as! Int, totalDeaths: global["TotalDeaths"] as! Int, newRecovered: global["NewRecovered"] as! Int, totalRecovered: global["TotalRecovered"] as! Int)
                            self.updateLabels(stats: stats123)
                        }
                    
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    
}


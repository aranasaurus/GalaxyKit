//
//  ViewController.swift
//  Galaxy Machine
//
//  Created by Ryan Arana on 12/27/15.
//  Copyright © 2015 Aranasaurus. All rights reserved.
//

import UIKit
import SceneKit
import GalaxyKit

class ViewController: UIViewController {
    var sceneView: SCNView! { return view as? SCNView }
    @IBOutlet var label: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var massLabel: UILabel!
    @IBOutlet var radiusLabel: UILabel!
    
    let sector = Sector.init(1, 4, numSystems: 8)
    var currentSystemIndex: Int = 0 {
        didSet {
            if currentSystemIndex >= sector.systems.count {
                currentSystemIndex = currentSystemIndex % sector.systems.count
            } else if currentSystemIndex < 0 {
                currentSystemIndex = sector.systems.count - 1
            }
            
            let currentSystem = sector.systems[currentSystemIndex]
            label.text = currentSystem.description
            
            numberFormatter.minimumSignificantDigits = 6
            
            numberFormatter.maximumFractionDigits = 2
            temperatureLabel.text = "temp: \(numberFormatter.stringFromNumber(currentSystem.star.temperature)!) K"
            
            numberFormatter.maximumFractionDigits = 5
            numberFormatter.minimumIntegerDigits = 1
            massLabel.text = "mass: \(numberFormatter.stringFromNumber(currentSystem.star.mass)!) M☉"
            
            radiusLabel.text = "rad:  \(numberFormatter.stringFromNumber(currentSystem.star.radius)!) R☉"
            
            sceneView.scene = System.Scene(system: currentSystem)
            print(currentSystem.debugDescription)
        }
    }
    
    var numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.usesSignificantDigits = false
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.backgroundColor = .blackColor()
        sceneView.autoenablesDefaultLighting = true
        
        currentSystemIndex = 0
    }
    
    @IBAction func nextButtonTapped() {
        currentSystemIndex += 1
    }
    
    @IBAction func prevButtonTapped() {
        currentSystemIndex -= 1
    }
}


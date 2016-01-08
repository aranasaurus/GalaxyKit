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
    var sectorScene: Sector.Scene? { return sceneView.scene as? Sector.Scene }
    @IBOutlet var starLabel: UILabel!
    @IBOutlet var sectorLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var massLabel: UILabel!
    @IBOutlet var radiusLabel: UILabel!
    
    let galaxy = Galaxy(continueGeneratingBeyondMap : true)
    var sector: Sector! = .None {
        didSet {
            guard sector.x != oldValue?.x || sector.y != oldValue?.y else { return }
            configureForSector(sector)
        }
    }
    
    var currentStar: Star? = .None {
        didSet {
            guard let currentStar = currentStar else { return }
            starLabel.text = currentStar.description + "(\(currentStar.coordinate))"
            
            numberFormatter.minimumSignificantDigits = 6
            
            numberFormatter.maximumFractionDigits = 2
            temperatureLabel.text = "temp: \(numberFormatter.stringFromNumber(currentStar.temperature)!) K"
            
            numberFormatter.maximumFractionDigits = 5
            numberFormatter.minimumIntegerDigits = 1
            massLabel.text = "mass: \(numberFormatter.stringFromNumber(currentStar.mass)!) M☉"
            
            radiusLabel.text = "rad:  \(numberFormatter.stringFromNumber(currentStar.radius)!) R☉"
            
            print(currentStar.debugDescription)
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
        
        sector = galaxy[37, 47] // 37, 47 has a B0 in it!
        sceneView.backgroundColor = .blackColor()
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene = Sector.Scene(sector: sector)
        
        configureForSector(sector)
    }
    
    func configureForSector(sector: Sector) {
        sectorLabel.text = "Sector [\(sector.x), \(sector.y)] (\(sector.stars.count) systems)"
        sceneView.scene = Sector.Scene(sector: sector)
        currentStar = sectorScene?.focusedStar
    }
    
    @IBAction func nextButtonTapped() {
        currentStar = sectorScene?.focusNextStar()
    }
    
    @IBAction func prevButtonTapped() {
        currentStar = sectorScene?.focusPrevStar()
    }
    
    @IBAction func changeSectorTapped() {
        let x = UInt(arc4random_uniform(64))
        let y = UInt(arc4random_uniform(64))
        sector = galaxy[x, y]
    }
}


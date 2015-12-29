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
    
    var sector = Sector.init(1, 4, numSystems: 8) {
        didSet {
            guard sector.x != oldValue.x || sector.y != oldValue.y else { return }
            configureForSector(sector)
        }
    }
    
    var starDensityTable: [[Int]] {
        if let table = NSUserDefaults.standardUserDefaults().objectForKey("starDensityTable") as? [[Int]] {
            return table
        }
        var table = [[Int]]()
        for _ in 0...64 {
            var row = [Int]()
            for _ in 0...64 {
                row.append(Int(arc4random_uniform(24) + 1))
            }
            table.append(row)
        }
        NSUserDefaults.standardUserDefaults().setObject(table, forKey: "starDensityTable")
        return table
    }
    
    var currentSystemIndex: Int = 0 {
        didSet {
            if currentSystemIndex >= sector.systems.count {
        currentSystemIndex = 0
                
                currentSystemIndex = currentSystemIndex % sector.systems.count
            } else if currentSystemIndex < 0 {
                currentSystemIndex = sector.systems.count - 1
            }
            
            let currentSystem = sector.systems[currentSystemIndex]
            starLabel.text = currentSystem.description
            
            numberFormatter.minimumSignificantDigits = 6
            
            numberFormatter.maximumFractionDigits = 2
            temperatureLabel.text = "temp: \(numberFormatter.stringFromNumber(currentSystem.star.temperature)!) K"
            
            numberFormatter.maximumFractionDigits = 5
            numberFormatter.minimumIntegerDigits = 1
            massLabel.text = "mass: \(numberFormatter.stringFromNumber(currentSystem.star.mass)!) M☉"
            
            radiusLabel.text = "rad:  \(numberFormatter.stringFromNumber(currentSystem.star.radius)!) R☉"
            
            self.sectorScene?.focusIndex = currentSystemIndex
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
        sceneView.scene = Sector.Scene(sector: sector)
        
        configureForSector(sector)
    }
    
    func configureForSector(sector: Sector) {
        sectorLabel.text = "Sector [\(sector.x), \(sector.y)] (\(sector.systems.count) systems)"
        sceneView.scene = Sector.Scene(sector: sector)
        currentSystemIndex = 0
    }
    
    @IBAction func nextButtonTapped() {
        currentSystemIndex += 1
    }
    
    @IBAction func prevButtonTapped() {
        currentSystemIndex -= 1
    }
    
    @IBAction func changeSectorTapped() {
        let x = arc4random_uniform(64)
        let y = arc4random_uniform(64)
        let numSystems = starDensityTable[Int(x)][Int(y)]
        sector = Sector.init(x, y, numSystems: UInt8(numSystems))
    }
}


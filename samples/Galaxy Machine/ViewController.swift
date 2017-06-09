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
    fileprivate var sceneView: SCNView! { return view as? SCNView }
    fileprivate var sectorScene: Sector.Scene? { return sceneView.scene as? Sector.Scene }

    @IBOutlet fileprivate var starLabel: UILabel!
    @IBOutlet fileprivate var sectorLabel: UILabel!
    @IBOutlet fileprivate var temperatureLabel: UILabel!
    @IBOutlet fileprivate var massLabel: UILabel!
    @IBOutlet fileprivate var radiusLabel: UILabel!
    @IBOutlet fileprivate var luminosityLabel: UILabel!

    fileprivate let galaxy: Galaxy
    
    fileprivate var currentStar: Star? {
        didSet {
            guard let currentStar = currentStar else { return }
            starLabel.text = currentStar.description + "(\(currentStar.coordinate))"

            temperatureLabel.text = "temp: \(formatter.string(from: currentStar.temperature))"
            luminosityLabel.text = "lumi: \(formatter.string(from: currentStar.luminosity))"
            massLabel.text = "mass: \(formatter.string(from: currentStar.mass))"
            radiusLabel.text = "rad:  \(formatter.string(from: currentStar.radius))"
            
            print(currentStar.debugDescription)
        }
    }

    fileprivate var formatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        formatter.numberFormatter.usesSignificantDigits = true
        formatter.numberFormatter.minimumSignificantDigits = 4
        formatter.numberFormatter.maximumSignificantDigits = 5
        return formatter
    }()

    fileprivate var numberFormatter: NumberFormatter { return formatter.numberFormatter }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.galaxy = Galaxy(continueGeneratingBeyondMap: true)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.galaxy = Galaxy(continueGeneratingBeyondMap: true)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sector = galaxy[37, 47] // 37, 47 has a B0 in it!
        sceneView.backgroundColor = .black
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene = Sector.Scene(sector: sector)
        
        configure(for: sector)
    }
    
    func configure(for sector: Sector) {
        sectorLabel.text = "Sector [\(sector.x), \(sector.y)] (\(sector.stars.count) systems)"
        sceneView.scene = Sector.Scene(sector: sector)
        currentStar = sectorScene?.focusedStar
    }
    
    @IBAction private func nextButtonTapped() {
        currentStar = sectorScene?.focusNextStar()
    }
    
    @IBAction private func prevButtonTapped() {
        currentStar = sectorScene?.focusPrevStar()
    }
    
    @IBAction private func changeSectorTapped() {
        let x = UInt(arc4random_uniform(64))
        let y = UInt(arc4random_uniform(64))
        configure(for: galaxy[x, y])
    }
}


//
//  SystemView.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 12/25/15.
//  Copyright © 2015 Aranasaurus. All rights reserved.
//

import Foundation

public class SystemView: UIView {
    public var system: System
    private var circle: UIView
    private var label: UILabel
    
    public init(frame: CGRect, system: System) {
        self.system = system
        
        let padding: CGFloat = 12
        self.circle = UIView(frame: frame.insetBy(dx: padding, dy: padding).offsetBy(dx: padding/2, dy: padding))
        circle.layer.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = system.star.color
        
        self.label = UILabel(frame: CGRect(x: 0, y: 2, width: frame.width, height: padding + 6))
        self.label.text = system.description
        self.label.textAlignment = .Center
        self.label.font = self.label.font.fontWithSize(14)
        self.label.textColor = .whiteColor()
        super.init(frame: frame)
        
        self.addSubview(circle)
        self.addSubview(label)
        self.backgroundColor = .blackColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import UIKit
import XCPlayground

public struct System {
    public let star: Star
    public let coordinate: Coordinate
    
    public init(seed: Seed) {
        self.coordinate = Coordinate(seed: seed)
        self.star = Star(seed: seed)
    }
    
    public init(star: Star, coordinate: Coordinate) {
        self.coordinate = coordinate
        self.star = star
    }
}

extension System: CustomStringConvertible {
    public var description: String { return "\(star) [\(coordinate)]" }
}

extension System: CustomDebugStringConvertible {
    public var debugDescription: String { return "\(star.debugDescription) [\(coordinate.debugDescription)]" }
}

extension System: XCPlaygroundLiveViewable {
    class View: UIView {
        var system: System
        private var circle: UIView
        private var label: UILabel
        
        init(frame: CGRect, system: System) {
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
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    public func playgroundLiveViewRepresentation() -> XCPlaygroundLiveViewRepresentation {
        return .View(View(frame: CGRect(x: 0, y: 0, width: 256, height: 256), system: self))
    }
}

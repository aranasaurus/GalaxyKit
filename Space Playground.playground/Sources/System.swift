import UIKit
import XCPlayground

public struct System {
    public let star: Star
    public let coordinate: Coordinate
    
    public class View: UIView {
        var system: System
        private var circle: UIView
        private var label: UILabel
        
        public init(frame: CGRect, system: System) {
            self.system = system
            
            let padding: CGFloat = 12
            self.circle = UIView(frame: frame.insetBy(dx: padding, dy: padding).offsetBy(dx: padding/2, dy: padding))
            circle.layer.cornerRadius = circle.frame.width / 2
            circle.backgroundColor = system.star.color
            
            self.label = UILabel(frame: CGRect(x: 0, y: 2, width: frame.width, height: padding + 6))
            self.label.text = system.debugDescription
            self.label.textAlignment = .Center
            self.label.font = self.label.font.fontWithSize(14)
            super.init(frame: frame)
            
            self.addSubview(circle)
            self.addSubview(label)
        }
        
        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    public init(seed: Seed) {
        self.coordinate = Coordinate(seed: seed)
        self.star = Star(seed: seed)
    }
}

extension System: CustomDebugStringConvertible {
    public var debugDescription: String { return "\(star) [\(coordinate)]" }
}

extension System: XCPlaygroundLiveViewable {
    public func playgroundLiveViewRepresentation() -> XCPlaygroundLiveViewRepresentation {
        return .View(View(frame: CGRect(x: 0, y: 0, width: 256, height: 256), system: self))
    }
}

extension Sector: XCPlaygroundLiveViewable {
    public func playgroundLiveViewRepresentation() -> XCPlaygroundLiveViewRepresentation {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 256, height: 256 * systems.count))
        return .View(view)
    }
}

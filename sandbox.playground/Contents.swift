import XCPlayground
import GalaxyKit

let page = XCPlaygroundPage.currentPage
page.needsIndefiniteExecution = true

let s = Sector(6, 24, numSystems: 15)

for (i, sys) in s.systems.enumerate() {
    print("[\(i)]: " + sys.debugDescription)
    page.captureValue(SystemView(frame: CGRect(x: 0, y: 0, width: 256, height: 256), system: sys), withIdentifier: "\(i)")
}

extension System: XCPlaygroundLiveViewable {
    public func playgroundLiveViewRepresentation() -> XCPlaygroundLiveViewRepresentation {
        return .View(SystemView(frame: CGRect(x: 0, y: 0, width: 256, height: 256), system: self))
    }
}

page.finishExecution()

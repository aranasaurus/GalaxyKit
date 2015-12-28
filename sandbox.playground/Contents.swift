import XCPlayground
import SceneKit
import GalaxyKit

let page = XCPlaygroundPage.currentPage
page.needsIndefiniteExecution = true

let s = Sector(6, 24, numSystems: 10)

for (i, sys) in s.systems.enumerate() {
    print("[\(i)]: " + sys.debugDescription)
    let view = SCNView(frame: CGRect(x: 0, y: 0, width: 256, height: 256))
    view.scene = System.Scene(system: sys)
    view.backgroundColor = .blackColor()
    view.autoenablesDefaultLighting = true
    view.allowsCameraControl = true
    page.captureValue(view, withIdentifier: "\(i)")
}

page.finishExecution()

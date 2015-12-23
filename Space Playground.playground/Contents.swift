//: Space Playground - My place to mess around with [this](http://www.jongware.com/galaxy1.html)

import XCPlayground
let page = XCPlaygroundPage.currentPage
page.needsIndefiniteExecution

let s = Sector(141, 78, numSystems: 4)

for (i, sys) in s.systems.enumerate() {
    page.captureValue(sys.playgroundLiveViewRepresentation(), withIdentifier: "\(i)")
}

page.finishExecution()

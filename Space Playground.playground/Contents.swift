//: Space Playground - My place to mess around with [this](http://www.jongware.com/galaxy1.html)

import XCPlayground
let page = XCPlaygroundPage.currentPage
page.needsIndefiniteExecution = true


for (i, sys) in s.systems.enumerate() {
    print("[\(i)]: " + sys.debugDescription)
}

page.liveView = s.systems[14]

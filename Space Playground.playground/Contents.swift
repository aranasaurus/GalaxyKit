//: Space Playground - My place to mess around with [this](http://www.jongware.com/galaxy1.html)

import Cocoa

let s = Sector(3, 5, numSystems: 6)
s.systems[1]
s.systems[2]
for (i, sys) in s.systems.enumerate() {
    print("[\(i)] \(sys)")
}


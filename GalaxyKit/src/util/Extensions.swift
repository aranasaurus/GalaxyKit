public extension UInt64 {
    var uint32Value: UInt32 { return UInt32(self & UInt64(UInt32.max)) }
}

public extension UnsignedIntegerType {
    var binaryString: String {
        let s = String(self, radix: 2)
        var ret = [Character]()
        var spaces = 0
        for (i, c) in s.characters.reverse().enumerate() {
            defer {
                ret.append(c)
            }
            guard i != 0 && (i - s.characters.count) % 4 == 0 else { continue }
            spaces += 1
            if spaces == 4 {
                ret.append(" ")
                ret.append("-")
            }
            ret.append(" ")
        }
        while ret.count < 32+9 {
            ret.insert("0", atIndex: 0)
        }
        return String(ret)
    }
}

public extension Array {
    func itemWithSeed(i: Int) -> Element {
        return self[i % count]
    }
}

extension UIColor {
    var hsba: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h, s, b, a)
    }
    
    var rgba: (r: CGFloat, g: CGFloat, b:CGFloat, a: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
}

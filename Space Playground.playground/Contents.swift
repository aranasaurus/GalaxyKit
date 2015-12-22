//: Space Playground - My place to mess around with [this](http://www.jongware.com/galaxy1.html)

import Cocoa

//void rotate_some (void)
//    {
//        unsigned long Tmp1,Tmp2;
//        
//        Tmp1 = (SystemParam_0 << 3) | (SystemParam_0 >> 29);
//        Tmp2 = SystemParam_0 + SystemParam_1;
//        Tmp1 += Tmp2;
//        SystemParam_0 = Tmp1;
//        SystemParam_1 = (Tmp2 << 5) | (Tmp2 >> 27);
//}

extension UInt64 {
    var uint32Value: UInt32 { return UInt32(self & UInt64(UInt32.max)) }
}

struct Seed {
    var coordSeed: UInt32
    var starSeed: UInt32
    
    init(_ coordSeed: UInt32, _ starSeed: UInt32) {
        self.coordSeed = coordSeed
        self.starSeed = starSeed
    }
    
    mutating func rotateInPlace() {
        var tmp1 = UInt64(coordSeed << 3) | UInt64(coordSeed >> 29)
        let tmp2 = UInt64(coordSeed) + UInt64(starSeed)
        tmp1 += tmp2
        coordSeed = tmp1.uint32Value
    
        starSeed = ((tmp2 << 5) | (tmp2 >> 27)).uint32Value
    }
    
    func rotate() -> Seed {
        var x = self
        x.rotateInPlace()
        return x
    }
}

extension Seed: CustomDebugStringConvertible {
    var debugDescription: String { return "\(coordSeed) : \(starSeed)" }
}

//        coords[i].z = (SystemParam_0 & 0xFF0000)>>16;
//        coords[i].y = (SystemParam_0 >> 8);
//        coords[i].y /= 2;
//        coords[i].x = (SystemParam_0 & 0x0001FE)>> 1;
//        coords[i].x /= 2;
struct Coordinate {
    let x: Int32
    let y: Int32
    let z: Int32
    
    init(seed: Seed) {
        self.z = Int32((seed.coordSeed & 0xFF0000) >> 16)
        self.y = Int32(seed.coordSeed >> 8) / 2
        self.x = Int32((seed.coordSeed & 0x0001FE) >> 1) / 2
    }
}

extension Coordinate: CustomDebugStringConvertible {
    var debugDescription: String { return "\(x), \(y), \(z)" }
}

struct Star {
    enum Classification: Int {
        private static let chanceTable = [
            0, 0, 0, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            2, 2, 2, 2, 2, 3, 3, 3,
            3, 4, 4, 4, 5, 6, 7, 8
        ]
        case MFlare
        case MFaint
        case M
        case K
        case G
        case F
        case A
        case WhiteDwarf
        case RedGiant
        case BrightGiant
        case B
        case SuperGiant
        case BlueSuperGiant
        case ContactBinary
        
        init(seed: Seed) {
            let chanceIndex = (seed.starSeed >> 16) & 0x1f
            self.init(rawValue: Classification.chanceTable[Int(chanceIndex)])!
        }
    }
    
    enum MultiType: Int {
        private static let chanceTable = [
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 2, 2, 2, 2, 2,
            2, 2, 3, 3, 3, 4, 5, 6
        ]
        
        case Single = 1
        case Binary
        case Ternary
        case Quaternary
        case Quintuple
        case Sextuple
        
        init(seed: Seed) {
            let chanceIndex = seed.starSeed & 0x1f
            self.init(rawValue: MultiType.chanceTable[Int(chanceIndex)])!
        }
    }
    
    let classification: Classification
    let multiType: MultiType
    
    init(seed: Seed) {
        self.classification = Classification(seed: seed)
        self.multiType = MultiType(seed: seed)
    }
}

extension Star: CustomDebugStringConvertible {
    var debugDescription: String { return "\(multiType) \(classification)" }
}

struct System {
    let star: Star
    let coordinate: Coordinate
    
    init(seed: Seed) {
        self.coordinate = Coordinate(seed: seed)
        self.star = Star(seed: seed)
    }
}

extension System: CustomDebugStringConvertible {
    var debugDescription: String { return "\(star) - (\(coordinate))" }
}

struct Sector {
    let x: UInt32
    let y: UInt32
    let systems: [System]
    
    init(_ x: UInt32, _ y: UInt32, numSystems: UInt8) {
        self.x = x
        self.y = y
        
        let coordSeed = (x << 16) + y
        let starSeed = (y << 16) + x
        
        var seed = Seed(coordSeed, starSeed)
        seed.rotateInPlace()
        seed.rotateInPlace()
        seed.rotateInPlace()
        
        var systems = [System]()
        for _ in 0..<numSystems {
            seed.rotateInPlace()
            print(seed)
            systems.append(System(seed: seed))
        }
        self.systems = systems
    }
}

extension Sector: CustomDebugStringConvertible {
    var debugDescription: String { return "[\(x), \(y)]: \(systems)" }
}

let s = Sector(23, 50, numSystems: 3)
s.systems[0]
s.systems[1]
s.systems[2]



//void Shuffle_Coordinates (unsigned int coordx, unsigned int coordy, int number_of_systems)
//{
//    int i;
//    
//    SystemParam_0 = (coordx<<16)+coordy;
//    SystemParam_1 = (coordy<<16)+coordx;
//    
//    rotate_some();
//    rotate_some();
//    rotate_some();
//    
//    for (i=0; i<number_of_systems; i++)
//    {
//        rotate_some();
//        

//        coords[i].multiple = StarChance_Multiples[SystemParam_1 & 0x1f];
//        coords[i].stardesc = StarChance_Type[(SystemParam_1 >> 16) & 0x1f];
//    }
//}



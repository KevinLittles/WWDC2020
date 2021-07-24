import Foundation
import PlaygroundSupport
import SpriteKit
import UIKit
import SwiftUI

public enum enumKindOfScenery: String {
    case batman
    case library
}

public enum enumAmountOfItems: String {
    case batman
    case library
}

public enum enumSortVelocitys: Int {
    case verySlow
    case slow
    case normal
    case fast
    case veryFast
}

public class InterativePlaygroundManager : ObservableObject {
    
    @Published public var amountOfItems: Int
    @Published public var sortVelocity: enumSortVelocitys
    @Published public var kindOfScenery: enumKindOfScenery
    public var scenery: Scenery
    public var items: Items
    
    public init (kindOfScenery: enumKindOfScenery, amountOfItems: Int, sortVelocity: enumSortVelocitys) {
        self.kindOfScenery = kindOfScenery
        self.amountOfItems = amountOfItems
        self.sortVelocity = sortVelocity
        
        self.scenery = Scenery(kindOfScenery: kindOfScenery)
        self.items = Items(kindOfItems: kindOfScenery, amountOfItems: amountOfItems)
    }
    
//    public func UpdateScenery () {
//        self.scenery.setKindOfScenery(kindOfScenery: self.kindOfScenery)
//        UpdateItems()
//    }
//
//    public func UpdateItems () {
//        self.items.setKindOfItems(kindOfItems: self.kindOfScenery)
//        self.items.setAmountOfItems(amountOfItems: self.amountOfItems)
//        self.items.createItems()
//    }
}

public class Scenery {
    
    public var backgroundImage: Image
    var kindOfScenery: enumKindOfScenery
    
    public init(kindOfScenery: enumKindOfScenery) {
        self.backgroundImage = Image("backgroundImage" + kindOfScenery.rawValue)
        self.kindOfScenery = kindOfScenery
    }
    
//    func setKindOfScenery (kindOfScenery: enumkindOfScenery) {
//        self.kindOfScenery = kindOfScenery
//    }
    
}

public class Items {
    
    var amountOfItems: Int
    var kindOfItems: enumKindOfScenery
    public var itemsImage: [SKTexture]
    public var spriteItems: [SKSpriteNode] = []
    public var valueOfItems: [Int]
    public var valueOfItemsToSort: [Int]
    
    
    public init(kindOfItems: enumKindOfScenery, amountOfItems: Int) {
        self.amountOfItems = amountOfItems
        self.kindOfItems = kindOfItems
        
        self.itemsImage = []
        self.spriteItems = []
        self.valueOfItems = []
        self.valueOfItemsToSort = []
        
        createItems()
    }
    
//    func setAmountOfItems (amountOfItems: Int) {
//        self.amountOfItems = amountOfItems
//    }
//
//    func setKindOfItems (kindOfItems: enumkindOfScenery) {
//        self.kindOfItems = kindOfItems
//    }
//
    
    public func createItems () {
        
        for n in 0...self.amountOfItems - 1 {
            self.itemsImage.append(SKTexture(imageNamed: "itemsImage" + kindOfItems.rawValue + String(n)))
            self.valueOfItems.append(n)
            self.spriteItems.append(SKSpriteNode())
            self.spriteItems[n].texture = self.itemsImage[n]
            self.spriteItems[n].name = String(n)
            
            self.spriteItems[n].color = .black
            self.spriteItems[n].size = self.spriteItems[n].texture!.size()
            self.spriteItems[n].anchorPoint = CGPoint(x: 0, y: 0)
        }
        self.valueOfItemsToSort = self.valueOfItems
        spriteItems.shuffle()
    }

}


//
//  GameScene.swift
//  BookCore
//
//  Created by Kevin Ribeiro on 21/02/20.
//

import UIKit
import PlaygroundSupport
import SwiftUI
import Foundation
import SpriteKit

public class GameScene: SKScene{
    
    public var velocity = 1
    
    public var lBook: SKSpriteNode = SKSpriteNode(color: .blue, size: CGSize(width: 30, height: 10))
    public var rBook: SKSpriteNode = SKSpriteNode(color: .red, size: CGSize(width: 30, height: 10))
    
    public var label : SKLabelNode = SKLabelNode(text: "")
    
    public static var geometrySize:CGSize = CGSize()
    
    public var geometryFirstSize: CGSize
    
    public var spriteItems: [SKSpriteNode] = []
    
    public var backupSpriteItems: [SKSpriteNode] = []
    
    public convenience  init(geometrySize: CGSize, spriteItems: [SKSpriteNode]){
        GameScene.self.geometrySize = geometrySize
        self.init()
        self.spriteItems = spriteItems
        self.backupSpriteItems = spriteItems
    }
    public override init() {
        self.geometryFirstSize = GameScene.self.geometrySize
        super.init(size: CGSize(width: 768, height: 1024))
        self.scaleMode = .aspectFit
        //let backgroundImage = SKNode(fileNamed: "StringbackgroundImagelibrary")!
        //self.addChild(backgroundImage)
        self.backgroundColor = .clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMove(to view: SKView) {
        
        determinePosition()
        
        lBook.position = CGPoint(x:300,
                                 y:300)
        rBook.position = CGPoint(x:GameScene.geometrySize.width/2,
                                 y:GameScene.geometrySize.height/2)
        
        label.text = String(describing: self.size.width)
        label.position = CGPoint(x:400,
                                 y:400)
        
        for n in 0...self.backupSpriteItems.count - 1 {
            self.addChild(spriteItems[n])
        }
        
        //self.addChild(lBook)
        //self.addChild(rBook)
        //self.addChild(label)
        
        self.timeSheduleSwapBooks()
    }
    
    public func determinePosition() {
        
        for n in 0...self.backupSpriteItems.count - 1 {
            if n == 0 {
                self.backupSpriteItems[n].position = CGPoint(x: 80,
                                                             y: self.size.height/2 - 240/2)
            }
            else {
                self.backupSpriteItems[n].position = CGPoint(x: self.backupSpriteItems[n-1].position.x + 50,
            y: self.size.height/2 - 240/2)
            }
        }
    }
    
//    public override func update(_ currentTime: TimeInterval) {
//        if (geometryFirstSize.width <= GameScene.geometrySize.width) {
//            if (geometryFirstSize.width/GameScene.geometrySize.width == 1) {
//                self.anchorPoint = CGPoint(x:0.0,
//                                           y:GameScene.geometrySize.height - geometryFirstSize.height)
//            }
//            else {
//                self.anchorPoint = CGPoint(x:0.5-((geometryFirstSize.width/GameScene.geometrySize.width)/2),
//                                           y:GameScene.geometrySize.height - geometryFirstSize.height)
//            }
//        }
//        else {
//            if (geometryFirstSize.width/GameScene.geometrySize.width == 1) {
//                self.anchorPoint = CGPoint(x:0.0,
//                                           y:GameScene.geometrySize.height - geometryFirstSize.height)
//            }
//            else {
//                self.anchorPoint = CGPoint(x:0.5-((GameScene.geometrySize.width/geometryFirstSize.width)/2),
//                                           y:GameScene.geometrySize.height - geometryFirstSize.height)
//            }
//        }
//    }
    
    public func timeSheduleSwapBooks() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
            
            self.swapBooks(rBook: self.backupSpriteItems[0], lBook: self.backupSpriteItems[4])
        }
    }
    
    public func swapBooks(rBook: SKSpriteNode, lBook: SKSpriteNode) {
        
        
        let lBookAction = SKAction.move(to: rBook.position, duration: TimeInterval(velocity))
        let rBookAction = SKAction.move(to: lBook.position, duration: TimeInterval(velocity))
        
        lBook.run(lBookAction)
        rBook.run(rBookAction)
    }
    
    public func updateBooksNames() {
        enumerateChildNodes(withName: "//*", using: {(node, stop) -> Void in
            node.name = ""
        })
        //incompleto
    }
    
    @objc public static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    
}

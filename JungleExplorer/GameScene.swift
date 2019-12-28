//
//  GameScene.swift
//  JungleExplorer
//
//  Created by David Herrero Jiménez on 07/12/2019.
//  Copyright © 2019 David Herrero Jiménez. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
   
    let TIME_PER_FRAME_RUN = 0.2
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    //Create an explorer
    var explorer: SKSpriteNode?
    
    //Textures array for explorer walk.
    var spriteArray = Array<SKTexture>();
    
    //Textures for explorer jump.
    var jumpArray = Array<SKTexture>()
//    let jumpAtlas = SKTextureAtlas(named:"JumpImages.atlas")
//    jumpArray.append(jumpAtlas.textureNamed("Jump"))
    

    //let textureAtlas = SKTextureAtlas(named:"RunImages.atlas")
    //Specifies the image atlas used.



    var explorerBaseLine = CGFloat (0)
    //This is where the Hero character sits on top of the ground.
    
    var variationBaseLine = 175// IPHONE 11 PRO
    var variationExplorerPosition = 0.5 //Iphone 11 pro
    var heightExplorer = 33

    var onGround = true
    var groundHeight = 64
    //Creates a variable to specify if Hero is on the ground.
    
    var definitiveExplorerBaseline: CGFloat = -125.9

//    var velocityY = CGFloat (0)
//    //Creates a variable to hold a three decimal point specification for velocity in the Y axis.
//
//    let gravity = CGFloat (0.6)
//    //Creates a non variable setting for gravity in the scene.
//
//    let movingGround = SKSpriteNode (imageNamed: "Ground")
//    //Creates an object for the moving ground and assigns the Ground image to it.
//
//    var originalMovingGroundPositionX = CGFloat (0)
//    //Sets a variable for the original ground position before it starts to move.
//
//    var MaxGroundX = CGFloat (0)
//    //Sets a variable for the maximum
//
//    var groundSpeed = 4
    //Sets the ground speed.  This number is how many pixels it will move the ground to the left every frame.

    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = #colorLiteral(red: 0.7098039216, green: 0.8470588235, blue: 0.7843137255, alpha: 1)
        explorerBaseLine = self.frame.midX - CGFloat(variationBaseLine)
        //definitiveExplorerBaseline = explorerBaseLine + (CGFloat(groundHeight) / 2) + (CGFloat(heightExplorer) / 2)
        print("explorerBaseline: \(explorerBaseLine)")
        print("ground: \((CGFloat(groundHeight) / 2))")
        print("heightExplorer: \((CGFloat(heightExplorer) / 2))")
        let frameSafeArea: CGRect = view.safeAreaLayoutGuide.layoutFrame
        
        
        fillSpriteArray()
        
        fillJumpArray()
        
        setBackground(safeArea: frameSafeArea)
        
        setGround(safeArea: frameSafeArea)

        
            
         explorer = SKSpriteNode(texture: spriteArray[0])
        explorer!.position = CGPoint(x: -frameSafeArea.maxY + (frameSafeArea.maxY / 3), y: 0.0)//y: definitiveExplorerBaseline)
         explorer!.zPosition = 00
         explorer!.physicsBody = SKPhysicsBody(circleOfRadius: max(explorer!.size.width / 2, explorer!.size.height / 2))
         explorer!.physicsBody?.isDynamic = true
         explorer!.physicsBody?.allowsRotation = false
         explorer!.physicsBody?.usesPreciseCollisionDetection = true
         explorer!.color = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
         explorer!.colorBlendFactor = 1.0
         
        
         run()
         

            
         
         self.addChild(explorer!)
    }
    
    func fillSpriteArray(){
        
        let explorerTexture1 = SKTexture(imageNamed: "1")
        explorerTexture1.filteringMode = SKTextureFilteringMode.nearest
        let explorerTexture2 = SKTexture(imageNamed: "2")
        explorerTexture2.filteringMode = SKTextureFilteringMode.nearest
        let explorerTexture3 = SKTexture(imageNamed: "3")
        explorerTexture3.filteringMode = SKTextureFilteringMode.nearest
        let explorerTexture4 = SKTexture(imageNamed: "4")
        explorerTexture4.filteringMode = SKTextureFilteringMode.nearest
        let explorerTexture5 = SKTexture(imageNamed: "5")
        explorerTexture5.filteringMode = SKTextureFilteringMode.nearest
        let explorerTexture6 = SKTexture(imageNamed: "6")
        explorerTexture6.filteringMode = SKTextureFilteringMode.nearest
        let explorerTexture7 = SKTexture(imageNamed: "7")
        explorerTexture7.filteringMode = SKTextureFilteringMode.nearest
        let explorerTexture8 = SKTexture(imageNamed: "8")
        explorerTexture8.filteringMode = SKTextureFilteringMode.nearest
        
        
        spriteArray.append(explorerTexture1)
        spriteArray.append(explorerTexture2)
        spriteArray.append(explorerTexture3)
        spriteArray.append(explorerTexture4)
        spriteArray.append(explorerTexture5)
        spriteArray.append(explorerTexture6)
        spriteArray.append(explorerTexture7)
        spriteArray.append(explorerTexture8)
        
    }
    
    func fillJumpArray(){
        
        let explorerJumpTexture1 = SKTexture(imageNamed: "1j")
              explorerJumpTexture1.filteringMode = SKTextureFilteringMode.nearest
              let explorerJumpTexture2 = SKTexture(imageNamed: "2j")
              explorerJumpTexture2.filteringMode = SKTextureFilteringMode.nearest
              let explorerJumpTexture3 = SKTexture(imageNamed: "3j")
              explorerJumpTexture3.filteringMode = SKTextureFilteringMode.nearest
              let explorerJumpTexture4 = SKTexture(imageNamed: "4j")
              explorerJumpTexture4.filteringMode = SKTextureFilteringMode.nearest
              let explorerJumpTexture5 = SKTexture(imageNamed: "5j")
              explorerJumpTexture5.filteringMode = SKTextureFilteringMode.nearest
              let explorerJumpTexture6 = SKTexture(imageNamed: "6j")
              explorerJumpTexture6.filteringMode = SKTextureFilteringMode.nearest
              
              jumpArray.append(explorerJumpTexture1)
              jumpArray.append(explorerJumpTexture2)
              jumpArray.append(explorerJumpTexture3)
              jumpArray.append(explorerJumpTexture4)
              jumpArray.append(explorerJumpTexture5)
              jumpArray.append(explorerJumpTexture6)
        
    }
    
    func setBackground(safeArea frameSafeArea: CGRect){
        
        let background2 = SKTexture(imageNamed: "bk12")
        background2.filteringMode = SKTextureFilteringMode.nearest
        
        let background3 = SKTexture(imageNamed: "bk13")
        background3.filteringMode = SKTextureFilteringMode.nearest

        let background4 = SKTexture(imageNamed: "bk14")
        background4.filteringMode = SKTextureFilteringMode.nearest

        let background5 = SKTexture(imageNamed: "bk15")
        background5.filteringMode = SKTextureFilteringMode.nearest
        
        
        let movBk2 = SKAction.moveBy(x: -frameSafeArea.width, y: CGFloat(0), duration: TimeInterval(0.04*frameSafeArea.width))
        let resetMovBk2 = SKAction.moveBy(x: frameSafeArea.width, y: CGFloat(0), duration: TimeInterval(0))
        let constantMovBk2 = SKAction.repeatForever(SKAction.sequence([movBk2, resetMovBk2]))
        
        let movBk3 = SKAction.moveBy(x: -frameSafeArea.width, y: CGFloat(0), duration: TimeInterval(0.03*frameSafeArea.width))
        let resetMovBk3 = SKAction.moveBy(x: frameSafeArea.width, y: CGFloat(0), duration: TimeInterval(0))
        let constantMovBk3 = SKAction.repeatForever(SKAction.sequence([movBk3, resetMovBk3]))
        
        let movBk4 = SKAction.moveBy(x: -frameSafeArea.width, y: CGFloat(0), duration: TimeInterval(0.02*frameSafeArea.width))
        let resetMovBk4 = SKAction.moveBy(x: frameSafeArea.width, y: CGFloat(0), duration: TimeInterval(0))
        let constantMovBk4 = SKAction.repeatForever(SKAction.sequence([movBk4, resetMovBk4]))
        
        let movBk5 = SKAction.moveBy(x: -frameSafeArea.width, y: CGFloat(0), duration: TimeInterval(0.01*frameSafeArea.width))
        let resetMovBk5 = SKAction.moveBy(x: frameSafeArea.width, y: CGFloat(0), duration: TimeInterval(0))
        let constantMovBk5 = SKAction.repeatForever(SKAction.sequence([movBk5, resetMovBk5]))
        
        for i in 0...2 {
            
            let fractionBk2 = SKSpriteNode(texture: background2)
            fractionBk2.zPosition = -99
            fractionBk2.size.width = frameSafeArea.width
            fractionBk2.size.height = frameSafeArea.height
            fractionBk2.position = CGPoint(x: CGFloat(i) * frameSafeArea.width, y: CGFloat(0.0))
            fractionBk2.run(constantMovBk2)
            self.addChild(fractionBk2)
            
            let fractionBk3 = SKSpriteNode(texture: background3)
            fractionBk3.zPosition = -98
            fractionBk3.size.width = frameSafeArea.width
            fractionBk3.size.height = frameSafeArea.height
            fractionBk3.position = CGPoint(x: CGFloat(i) * frameSafeArea.width, y: CGFloat(0.0))
            fractionBk3.run(constantMovBk3)
            self.addChild(fractionBk3)
            
            let fractionBk4 = SKSpriteNode(texture: background4)
            fractionBk4.zPosition = -97
            fractionBk4.size.width = frameSafeArea.width
            fractionBk4.size.height = frameSafeArea.height
            fractionBk4.position = CGPoint(x: CGFloat(i) * frameSafeArea.width, y: CGFloat(0.0))
            fractionBk4.run(constantMovBk4)
            self.addChild(fractionBk4)
            
            let fractionBk5 = SKSpriteNode(texture: background5)
            fractionBk5.zPosition = -96
            fractionBk5.size.width = frameSafeArea.width
            fractionBk5.size.height = frameSafeArea.height
            fractionBk5.position = CGPoint(x: CGFloat(i) * frameSafeArea.width, y: CGFloat(0.0))
            fractionBk5.run(constantMovBk5)
            self.addChild(fractionBk5)
        }
        
        
    }
    
    func setGround(safeArea frameSafeArea: CGRect){
        
        let ground = SKSpriteNode()
        ground.size = CGSize(width: frameSafeArea.width, height: CGFloat(groundHeight))
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frameSafeArea.width, height: CGFloat(groundHeight)))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        ground.position = CGPoint(x: 0.0, y: explorerBaseLine)//self.frame.midX - 175)
        
        self.addChild(ground)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            if self.onGround {
                  jump()
              }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        print("onGround: \(onGround)")
        print("y: \(self.explorer!.position.y)")
        print("definitive: \(self.definitiveExplorerBaseline)")

        if self.explorer!.position.y < self.definitiveExplorerBaseline {
            
            
            self.explorer!.position.y = self.definitiveExplorerBaseline

            //velocityY = 0.0
        
        

            if self.onGround == false {
                self.onGround = true
                print("on the ground onGround: \(onGround)")

                run()
            }
       }
    }
    
//    func jumpRotation(min: CGFloat, max: CGFloat, currentRotation:CGFloat) -> CGFloat{
//
//        if (currentRotation > max){
//            return max
//        }else if (currentRotation < min){
//            return min
//        }else{
//            return currentRotation
//        }
//
//    }
    
    func run() {
        let walkAnimation = SKAction.animate(with: spriteArray, timePerFrame: 0.1)
        let run = SKAction.repeatForever(walkAnimation)
        //self.explorer!.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        //self.explorer!.physicsBody?.applyImpulse((CGVector(dx: 0.0, dy: 0.0)))
        explorer!.run(run)
    }
    
    func jump() {
        
        print("jump")
        //self.velocityY = -18
        self.onGround = false
        print("jump over ground")

        let jumpAnimation = SKAction.animate(with: jumpArray, timePerFrame: 0.1)
        let jump = SKAction.repeatForever(jumpAnimation)
        self.explorer!.run(jump)
        
        self.explorer!.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        self.explorer!.physicsBody?.applyImpulse((CGVector(dx: 0.0, dy: 15.0)))

    }
}

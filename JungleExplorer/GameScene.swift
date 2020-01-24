//
//  GameScene.swift
//  JungleExplorer
//
//  Created by David Herrero Jiménez on 07/12/2019.
//  Copyright © 2019 David Herrero Jiménez. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    //Create an explorer
    var explorer: SKSpriteNode?
    
    //Textures array for explorer walk.
    var spriteArray = Array<SKTexture>();
    
    //Textures for explorer jump.
    var jumpArray = Array<SKTexture>()
    
    //This is where the Hero character sits on top of the ground.
    var explorerBaseLine = CGFloat (0)
    
    
    var variationBaseLine = 175// IPHONE 11 PRO
    var variationExplorerPosition = 0.5 //Iphone 11 pro
    var heightExplorer = 33
    
    var onGround = true
    var groundHeight = 64
    //Creates a variable to specify if Hero is on the ground.
    
    var definitiveExplorerBaseline: CGFloat = -126.36408996582031
    
    
    let explorerCategory: UInt32 = 1 << 0
    let groundCategory: UInt32 = 1 << 1
    let obstaclesCategory: UInt32 = 1 << 2
    
    lazy var frameSafeArea: CGRect = CGRect()
    
    
    let TIME_PER_FRAME_RUN = 0.2

    lazy var startingPoint: CGPoint = CGPoint();
    lazy var obstaclesSpeed: CGFloat = CGFloat();
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = #colorLiteral(red: 0.7098039216, green: 0.8470588235, blue: 0.7843137255, alpha: 1)
        
        explorerBaseLine = self.frame.midX - CGFloat(variationBaseLine)
        frameSafeArea = view.safeAreaLayoutGuide.layoutFrame
        
        startingPoint = CGPoint(x:  self.frame.size.height + 100, y: definitiveExplorerBaseline)
        obstaclesSpeed = CGFloat(0.01 * startingPoint.x)
        
        fillSpriteArray()
        
        fillJumpArray()
        
        setBackground(safeArea: frameSafeArea)
        
        setGround(safeArea: frameSafeArea)
        print("definitiveExplorerBaseline: \(definitiveExplorerBaseline)")
        getInfiniteObstacles(obstacleHeight: definitiveExplorerBaseline)
        
        setExplorer(safeArea: frameSafeArea)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // print("HA COLISIONADO!!!")
        
        if self.onGround == false {
            //print("entra")
            self.onGround = true
            
            run()
        }
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
    
    func getNewObstacle(obstaclesSpeed: CGFloat, obstacleHeight: CGFloat){
        
        let obstacle01 = SKTexture(imageNamed: "rectangle01")
        let movObs01 = SKAction.moveBy(x:-startingPoint.x * 2, y: 0, duration: TimeInterval(obstaclesSpeed))
        let removeObstacle = SKAction.removeFromParent()
        let constantMovObs01 = SKAction.sequence([movObs01, removeObstacle])//SKAction.repeatForever()
        
        let obstacle01Node = SKSpriteNode(texture: obstacle01)
        obstacle01Node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstacle01Node.size.width, height: obstacle01Node.size.height))
        obstacle01Node.physicsBody?.isDynamic = false
        obstacle01Node.physicsBody?.affectedByGravity = false
        obstacle01Node.position = CGPoint(x: startingPoint.x, y: obstacleHeight)
        obstacle01Node.physicsBody?.categoryBitMask = obstaclesCategory
        obstacle01Node.physicsBody?.contactTestBitMask = explorerCategory
        obstacle01Node.run(constantMovObs01)
        
        self.addChild(obstacle01Node)
        
        
    }
    
    func getInfiniteObstacles(obstacleHeight: CGFloat){
        
        let waitForNewObstacle = SKAction.wait(forDuration: TimeInterval(1.0))
        
        let newObstacleAction = SKAction.run({() in self.getNewObstacle(obstaclesSpeed: self.obstaclesSpeed, obstacleHeight: self.getRandomHeight(obstacleHeight: obstacleHeight))})
          
        let getNexObstacle = SKAction.sequence([newObstacleAction, waitForNewObstacle])
          
        let infiniteObstacles = SKAction.repeatForever(getNexObstacle)
        
        self.run(infiniteObstacles)
    }
    
    func getRandomHeight(obstacleHeight: CGFloat) -> CGFloat{
        
        let initValue: CGFloat = obstacleHeight
        let finishValue: CGFloat = obstacleHeight * -1

        let randomCGFloat = CGFloat.random(in: initValue...finishValue)
        
        return randomCGFloat
    }
    
    func setObstacles(safeArea frameSafeArea: CGRect){
        
        let obstacle01 = SKTexture(imageNamed: "rectangle01")
        
        let movObs01 = SKAction.moveBy(x: -frameSafeArea.width, y: CGFloat(0), duration: TimeInterval(0.01*frameSafeArea.width))
        let resetMovObs01 = SKAction.moveBy(x: frameSafeArea.width, y: CGFloat(0), duration: TimeInterval(0))
        let constantMovObs01 = SKAction.repeatForever(SKAction.sequence([movObs01, resetMovObs01]))
        
        let obstacle02 = SKTexture(imageNamed: "rectangle01")
        
        //let movObs02 = SKAction.moveBy(x: -frameSafeArea.width, y: CGFloat(0), duration: TimeInterval(0.01*frameSafeArea.width))
        // let resetMovObs01 = SKAction.moveBy(x: frameSafeArea.width, y: CGFloat(0), duration: TimeInterval(0))
        //  let constantMovObs01 = SKAction.repeatForever(SKAction.sequence([movObs01, resetMovObs01]))
        
        for i in 0...2 {
            
            
            
            // let random = CGPoint(x: CGFloat(arc4random() % UInt32(frameSafeArea.width)), y: CGFloat(arc4random() % UInt32(frameSafeArea.height)))
            
            
            let obstacle01Node = SKSpriteNode(texture: obstacle01)
            
            obstacle01Node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstacle01Node.size.width, height: obstacle01Node.size.height))
            obstacle01Node.physicsBody?.isDynamic = false
            obstacle01Node.physicsBody?.affectedByGravity = false
            obstacle01Node.position = CGPoint(x: CGFloat(i) * frameSafeArea.width, y: definitiveExplorerBaseline)
            obstacle01Node.physicsBody?.categoryBitMask = obstaclesCategory
            obstacle01Node.physicsBody?.contactTestBitMask = explorerCategory
            obstacle01Node.run(constantMovObs01)
            
            let obstacle02Node = SKSpriteNode(texture: obstacle02)
            obstacle02Node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstacle02Node.size.width, height: obstacle02Node.size.height))
            obstacle02Node.physicsBody?.isDynamic = false
            obstacle02Node.physicsBody?.affectedByGravity = false
            obstacle02Node.position = CGPoint(x: CGFloat(i) * frameSafeArea.width + obstacle01Node.size.width * 2 , y: definitiveExplorerBaseline + obstacle01Node.size.height)
            obstacle02Node.physicsBody?.categoryBitMask = obstaclesCategory
            obstacle02Node.physicsBody?.contactTestBitMask = explorerCategory
            obstacle02Node.run(constantMovObs01)
            
            
            let obstacle03Node = SKSpriteNode(texture: obstacle02)
            obstacle03Node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstacle03Node.size.width, height: obstacle03Node.size.height))
            obstacle03Node.physicsBody?.isDynamic = false
            obstacle03Node.physicsBody?.affectedByGravity = false
            obstacle03Node.position = CGPoint(x: CGFloat(i) * frameSafeArea.width + obstacle02Node.size.width * 4 , y: definitiveExplorerBaseline + obstacle01Node.size.height * 2)
            obstacle03Node.physicsBody?.categoryBitMask = obstaclesCategory
            obstacle03Node.physicsBody?.contactTestBitMask = explorerCategory
            obstacle03Node.run(constantMovObs01)
            
            
            let obstacle04Node = SKSpriteNode(texture: obstacle02)
            obstacle04Node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstacle03Node.size.width, height: obstacle04Node.size.height))
            obstacle04Node.physicsBody?.isDynamic = false
            obstacle04Node.physicsBody?.affectedByGravity = false
            obstacle04Node.position = CGPoint(x: CGFloat(i) * frameSafeArea.width + obstacle02Node.size.width * 6 , y: definitiveExplorerBaseline + obstacle01Node.size.height * 2)
            obstacle04Node.physicsBody?.categoryBitMask = obstaclesCategory
            obstacle04Node.physicsBody?.contactTestBitMask = explorerCategory
            obstacle04Node.run(constantMovObs01)
            
            
            let obstacle05Node = SKSpriteNode(texture: obstacle02)
            obstacle05Node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstacle04Node.size.width, height: obstacle05Node.size.height))
            obstacle05Node.physicsBody?.isDynamic = false
            obstacle05Node.physicsBody?.affectedByGravity = false
            obstacle05Node.position = CGPoint(x: CGFloat(i) * frameSafeArea.width + obstacle02Node.size.width * 8 , y: definitiveExplorerBaseline + obstacle01Node.size.height * 4)
            obstacle05Node.physicsBody?.categoryBitMask = obstaclesCategory
            obstacle05Node.physicsBody?.contactTestBitMask = explorerCategory
            obstacle05Node.run(constantMovObs01)
            
            
            //            for i in 0 ... 20 {
            //
            //            let obstacle06Node = SKSpriteNode(texture: obstacle02)
            //                    obstacle06Node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstacle05Node.size.width, height: obstacle06Node.size.height))
            //                    obstacle06Node.physicsBody?.isDynamic = false
            //                    obstacle06Node.physicsBody?.affectedByGravity = false
            //                    obstacle06Node.position = CGPoint(x: CGFloat(i) * frameSafeArea.width + obstacle02Node.size.width * 8 + arc4random() , y: definitiveExplorerBaseline + obstacle01Node.size.height * 4 + arc4random()                                                                                                                                                                        )
            //                    obstacle06Node.physicsBody?.categoryBitMask = obstaclesCategory
            //                    obstacle06Node.physicsBody?.contactTestBitMask = explorerCategory
            //                    obstacle06Node.run(constantMovObs01)
            //
            //                 self.addChild(obstacle06Node)
            //
            //            }
            
            
            
            self.addChild(obstacle01Node)
            self.addChild(obstacle02Node)
            self.addChild(obstacle03Node)
            self.addChild(obstacle04Node)
            self.addChild(obstacle05Node)
        }
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
        ground.physicsBody?.categoryBitMask = groundCategory
        ground.physicsBody?.contactTestBitMask = explorerCategory
        
        self.addChild(ground)
    }
    
    func setExplorer(safeArea frameSafeArea: CGRect){
        
        explorer = SKSpriteNode(texture: spriteArray[0])
        explorer!.position = CGPoint(x: -frameSafeArea.maxY + (frameSafeArea.maxY / 3), y: 0.0)//y: definitiveExplorerBaseline)
        explorer!.zPosition = 00
        explorer!.physicsBody = SKPhysicsBody(circleOfRadius: max(explorer!.size.width / 2, explorer!.size.height / 2))
        explorer!.physicsBody?.isDynamic = true
        explorer!.physicsBody?.allowsRotation = false
        explorer!.physicsBody?.usesPreciseCollisionDetection = true
        explorer!.color = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        explorer!.colorBlendFactor = 1.0
        
        explorer!.physicsBody?.categoryBitMask = explorerCategory
        explorer!.physicsBody?.collisionBitMask = groundCategory | obstaclesCategory
        explorer!.physicsBody?.contactTestBitMask = groundCategory | obstaclesCategory
        
        run()
        
        self.addChild(explorer!)
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
        } else {
            // extraJump()
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
    
    var time = 20
    
    override func update(_ currentTime: TimeInterval) {
        
//                if ((Int(currentTime) % time) == 0){
//
//                    obstaclesSpeed -= 0.1
//                    print("obstaclesSpeed:\(obstaclesSpeed)")
//                    setNewObstacle(obstaclesSpeed: obstaclesSpeed, obstacleHeight: definitiveExplorerBaseline)
//
//                }
        
        
        // Called before each frame is rendered
        
        //        if (self.explorer!.position.y < self.definitiveExplorerBaseline) {
        //
        //            self.explorer!.position.y = self.definitiveExplorerBaseline
        //
        //            if self.onGround == false {
        //                print("entra")
        //                self.onGround = true
        //
        //                run()
        //            }
        //       }
        
        
    }
    
    func run() {
        let walkAnimation = SKAction.animate(with: spriteArray, timePerFrame: 0.1)
        let run = SKAction.repeatForever(walkAnimation)
        explorer!.run(run)
    }
    
    func jump() {
        
        
        self.explorer!.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        self.explorer!.physicsBody?.applyImpulse((CGVector(dx: 0.0, dy: 15.0)))
        
        //print("jump")
        self.onGround = false
        
        let jumpAnimation = SKAction.animate(with: jumpArray, timePerFrame: 0.1)
        let jump = SKAction.repeatForever(jumpAnimation)
        self.explorer!.run(jump)
    }
    
    func extraJump(){
        
        jump()
        
    }
    
    func jumpRotation(min: CGFloat, max: CGFloat, currentRotation:CGFloat) -> CGFloat{
        
        if (currentRotation > max){
            return max
        }else if (currentRotation < min){
            return min
        }else{
            return currentRotation
        }
        
    }
}

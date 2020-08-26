//
//  GameViewController.swift
//  JungleExplorer
//
//  Created by David Herrero Jiménez on 07/12/2019.
//  Copyright © 2019 David Herrero Jiménez. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "GameScene") {
                       
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill //.resizeFill Set the scale mode to scale to fit the window
                scene.size = view.bounds.size
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            //to see Spritekit SKPhysicsbody borderline
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            skView.showsPhysics = false
            
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

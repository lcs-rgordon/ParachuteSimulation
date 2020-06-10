//
//  GameScene.swift
//  IntroToSpriteKit
//
//  Created by Russell Gordon on 2019-12-07.
//  Copyright © 2019 Russell Gordon. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    // MARK: Properties
    
    // Physical constants
    let g = 9.8
    var drag = 0.0031734                // Drag without a parachute
    
    // State of parachutist
    var height = 0.0                    // Will actually be set from parameter controller screen
    var parachuteOpensAtHeight = 0.0    // Will actually be set from parameter controller screen
    var velocity = 0.0
    var mass = 0.0
    var acceleration = 0.0              // Will be set to "g" when scene is set up
    
    // Tracking for time
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0                // Tracks time between animation updates
    var totalTimeElapsed: TimeInterval = 0  // Total time since animation started
    
    // Objects for the animation
    var circleWithParachute = SKShapeNode()
    
    // MARK: Methods
    // This function runs once to set up the scene
    override func didMove(to view: SKView) {
        
        // Set the background colour
        self.backgroundColor = .black
        
        // Set initial acceleration
        acceleration = g
        
        // Add a circle to represent someone falling with a parachute
        circleWithParachute = SKShapeNode(circleOfRadius: 10)
        circleWithParachute.position = CGPoint(x: 300, y: self.parachuteOpensAtHeight)
        addChild(circleWithParachute)
        
    }
    
    // This runs before each frame is rendered
    // Frames render at about 60 fps
    override func update(_ currentTime: TimeInterval) {
        
        // How much time has elapsed?
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
            print("Initial height is: \(height)")
            print("Parachute will open at height: \(parachuteOpensAtHeight)")
            print("Initial mass is: \(mass)")
        }
        lastUpdateTime = currentTime
        print("\(dt*1000) milliseconds since last update")
        
        // Check for when parachute opens
        if height < parachuteOpensAtHeight {
            drag = 43.046
        }
        
        // Calculate new height
        // NOTE: Have to break up equation below into two parts for compiler to accept the calculations
        //
        // height = height + velocity * dt + 0.5 * acceleration * pow(dt, 2)
        //
        // NOTE: We must subtract from the height since the origin is bottom left on the Cartesian plane
        //       If we increase the height, the circle will move up.
        height = height - velocity * dt
        height -= 0.5 * acceleration * pow(dt, 2)
        print("New height is: \(height)")
        
        // Set the new position of the parachutist
        let newPosition = CGPoint(x: circleWithParachute.position.x,
                                  y: CGFloat(height) )
        circleWithParachute.position = newPosition
        
        // Calculate new velocity and acceleration
        velocity = velocity + acceleration * dt
        acceleration = g - drag * pow(velocity, 2) / mass
        
    }
    
}

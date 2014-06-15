//
//  GameScene.swift
//  PlaneWarSwift
//
//  Created by ljlin on 14-6-7.
//  Copyright (c) 2014年 ljlin. All rights reserved.
//

import SpriteKit
import Foundation



let ENEMIES_MAX_COUNT    = 100
let BULLET_RATE          = 15

let ENEMY_MIDDIUM_RATE   = 10
let ENEMY_LARGE_RATE     = 21

class GameScene: SKScene {
    var player  = SKSpriteNode(imageNamed:"plane")
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        player.position = myLabel.position
        player.xScale = 0.3
        player.yScale = 0.3
        self.addChild(player)
        self.addChild(myLabel)
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

    }
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch =  touches.anyObject() as UITouch
        let location = touch.locationInNode(self)
        if ((abs(location.x-player.position.x)<=50) &&
            (abs(location.y-player.position.y)<=50)){
            player.position = location
        }
        
    }
    
    var bullet_setup_count = 0
    func setUpOneBullet() {
        if (bullet_setup_count >= BULLET_RATE) {
            bullet_setup_count = 0;
        } else {
            bullet_setup_count++
            return
        }
        var position = player.position
        var bullet = BulletSprite.newBulletWithType(BulletTypeNormal,position:position)
        self.addChild(bullet)
        var dest  = CGPointMake(position.x, position.y + CGRectGetHeight(self.frame) / 2.0)
        var time = Double(fabs(Double(dest.y) - Double(position.y))) / Double(bullet.speed)
        var action = SKAction.moveTo(dest,duration:time)
        bullet.runAction(action,completion:{bullet.removeFromParent()})
    }
}
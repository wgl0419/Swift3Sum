//
//  HelloScene.swift
//  SpriteWalkthrouch
//
//  Created by sihuan on 2016/6/23.
//  Copyright © 2016年 huan. All rights reserved.
//

import SpriteKit

class HelloScene: SKScene {
    var contentCreated = false
    
    //didMoveToView:方法是场景在视图中展示时被调用
    override func didMove(to view: SKView) {
        if contentCreated == false {
            contentCreated = true
            createSceneContents()
        }
    }
    
    func createSceneContents() {
        //SKColor并不是一个类，它是一个宏，对应IOS的UIColor以及OS X的NSColor。定义这个宏是为了更好的创建跨平台的代码。
        backgroundColor = SKColor.blue
        scaleMode = .aspectFit
        addChild(newHelloNode())
    }
    
    // MARK: - 在SpriteKit中，你永远不需要写显式执行绘画指令的代码，如果你在OpenGL或者Quartz 2D中就需要这样做。
    let kHello = "kHello"
    func newHelloNode() -> SKLabelNode {
        /*
         通过创建结点对象并将其加入到场景中来添加内容。
         所有的绘制都是由SpriteKit提供的类执行的。你可以自定义这些类的行为以制作不同的图像效果。
         然而，通过控制所有的绘制，SpriteKit可以对图像的绘制进行很多的优化。
         */
        let helloNode = SKLabelNode(fontNamed: "Chalkduster")
        helloNode.text = "Hello World"
        helloNode.name = kHello
        helloNode.fontSize = 42
        helloNode.position = CGPoint(x: frame.midX, y: frame.midY)
        return helloNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let helloNode = childNode(withName: kHello) {
            let moveUp = SKAction.moveBy(x: 0, y: 100, duration: 0.5)
            let zoom = SKAction.scale(to: 2, duration: 0.25)
            let pause = SKAction.wait(forDuration: 0.5)
            let fadeAway = SKAction.fadeOut(withDuration: 0.5)
            let remove = SKAction.removeFromParent()
            
            let sequence = SKAction.sequence([moveUp, zoom, pause, fadeAway, remove])
            helloNode.run(sequence, completion: { 
                let spaceship = Spaceship(size: UIScreen.main.bounds.size)
                let doors = SKTransition.doorsOpenVertical(withDuration: 0.5)
                self.view?.presentScene(spaceship, transition: doors)
            })
        }
    }
}































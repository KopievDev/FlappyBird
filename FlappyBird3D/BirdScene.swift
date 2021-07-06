//
//  BirdScene.swift
//  FlappyBird3D
//
//  Created by Ivan Kopiev on 05.07.2021.
//

import SceneKit

class BirdScene: SCNScene {
    
    let emptyGrass1 = SCNNode()
    let emptyGrass2 = SCNNode()

    var runningUpdate = true
    var timeLast: Double?
    let speedConstant = -0.7
    
    convenience init(create: Bool) {
        self.init()
        setupCamera()
        setupScenery()
        let propsScene = SCNScene(named: "Props.scn")!

        emptyGrass1.scale = SCNVector3(easyScale: 0.15)
        emptyGrass1.position = SCNVector3(0, -1.3, 0)
        
        emptyGrass2.scale = SCNVector3(easyScale: 0.15)
        emptyGrass2.position = SCNVector3(4.45, -1.3, 0)
        
        
        let grass1 = propsScene.rootNode.childNode(withName: "Ground", recursively: true)!
        grass1.position = SCNVector3(-5, 0, 0)
        
        let graas2 = grass1.clone()
        graas2.position = SCNVector3(-5,0,0)
        
        emptyGrass1.addChildNode(grass1)
        emptyGrass2.addChildNode(graas2)
 
        rootNode.addChildNode(emptyGrass1)
        rootNode.addChildNode(emptyGrass2)

        
    }
    
    func setupCamera() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera!.usesOrthographicProjection = false
        cameraNode.position = SCNVector3(0, 0, 0)
        cameraNode.pivot = SCNMatrix4MakeTranslation(0, 0, -3)
        rootNode.addChildNode(cameraNode)
        
        let lightOne = SCNLight()
        lightOne.type = .spot
        lightOne.spotOuterAngle = 90
        lightOne.attenuationStartDistance = 0
        lightOne.attenuationFalloffExponent = 2
        lightOne.attenuationEndDistance = 30
        
        let lightOneNode = SCNNode()
        lightOneNode.light = lightOne
        lightOneNode.position = SCNVector3(0, 10, 1)
        rootNode.addChildNode(lightOneNode)
        
        let lightNodeFront = SCNNode()
        lightNodeFront.light = lightOne
        lightNodeFront.position = SCNVector3(0, 1, 15)
        rootNode.addChildNode(lightNodeFront)
        
        let emptyAtCenter = SCNNode()
        emptyAtCenter.position = SCNVector3Zero
        rootNode.addChildNode(emptyAtCenter)
        
        lightNodeFront.constraints = [SCNLookAtConstraint(target: emptyAtCenter)]
        lightOneNode.constraints = [SCNLookAtConstraint(target: emptyAtCenter)]
        cameraNode.constraints = [SCNLookAtConstraint(target: emptyAtCenter)]
        
        let ambientLight = SCNNode()
        ambientLight.light = SCNLight()
        ambientLight.light?.type = .ambient
        ambientLight.light?.color = UIColor(white: 0.05, alpha: 1)
        rootNode.addChildNode(ambientLight)
    }
    
    func setupScenery() {
        let groundGeo = SCNBox(width: 4, height: 0.5, length: 0.4, chamferRadius: 0)
        groundGeo.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 0.6897535324, blue: 0, alpha: 1)
        groundGeo.firstMaterial?.specular.contents = UIColor.black
        groundGeo.firstMaterial?.emission.contents = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)


        let groundNote = SCNNode(geometry: groundGeo)
        
        let emtySand = SCNNode()
        emtySand.addChildNode(groundNote)
        emtySand.position.y = -1.63
        rootNode.addChildNode(emtySand)

    }
    
    
}
// MARK: - extension SCNSceneRendererDelegate
extension BirdScene: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let dt: Double
        if runningUpdate {
            if let lt = timeLast {
                dt = time - lt
            } else {
                dt = 0
            }
        } else {
            dt = 0
        }
        timeLast = time
        moveGrass(node: emptyGrass1, dt: dt)
        moveGrass(node: emptyGrass2, dt: dt)
    }
    
    func moveGrass(node: SCNNode, dt: Double) {
        node.position.x += Float(dt*speedConstant)
        if node.position.x <= -4.45 {
            node.position.x = 4.45
        }
    }
}
extension SCNVector3 {
    init(easyScale: Float) {
        self.init()
        self.x = easyScale
        self.y = easyScale
        self.z = easyScale
    }
}

//
//  BirdScene.swift
//  FlappyBird3D
//
//  Created by Ivan Kopiev on 05.07.2021.
//

import SceneKit

class BirdScene: SCNScene {
    
    convenience init(create: Bool) {
        self.init()
        setupCamera()
        setupScenery()
        
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


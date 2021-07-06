//
//  GameViewController.swift
//  FlappyBird3D
//
//  Created by Ivan Kopiev on 05.07.2021.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    var scnView: SCNView!
    var scnScene: SCNScene!
    override func viewDidLoad() {
        super.viewDidLoad()
       setupView()
        setupScene()
    }
    
    func setupView() {
        scnView = self.view as? SCNView
    }
    
    func setupScene() {
        scnScene = BirdScene(create: true)
        scnView.scene = scnScene
        scnView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
//        scnView.allowsCameraControl = true
//        scnView.autoenablesDefaultLighting = true
        
        scnView.delegate = (scnScene as! SCNSceneRendererDelegate)
        scnView.isPlaying = true
    }
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}

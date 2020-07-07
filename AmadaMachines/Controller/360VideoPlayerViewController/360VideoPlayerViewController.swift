//
//  360VideoPlayerViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 8/30/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import Foundation
/*
import UIKit
import SceneKit
import CoreMotion
import SpriteKit
import AVFoundation

class VideoPlayer360ViewController: UIViewController {

    let motionManager = CMMotionManager()
    let cameraNode = SCNNode()


    @IBOutlet weak var sceneView: SCNView!

    func createSphereNode(material material: AnyObject?) -> SCNNode {
        let sphere = SCNSphere(radius: 20.0)
        sphere.firstMaterial!.isDoubleSided = true
        sphere.firstMaterial!.diffuse.contents = material
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3Make(0,0,0)
        return sphereNode
    }

    func configureScene(node sphereNode: SCNNode) {
        // Set the scene
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
        // Camera, ...
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 0)
        scene.rootNode.addChildNode(sphereNode)
        scene.rootNode.addChildNode(cameraNode)
    }

    func startCameraTracking() {
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdatesToQueue(OperationQueue.mainQueue()) {
            [weak self](data: CMDeviceMotion?, error: NSError?) in

            guard let data = data else { return }

            let attitude: CMAttitude = data.attitude
            self?.cameraNode.eulerAngles = SCNVector3Make(Float(attitude.roll + M_PI/2.0), -Float(attitude.yaw), -Float(attitude.pitch))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //let urlString = "http://all360media.com/wp-content/uploads/pano/laphil/media/video-ios.mp4"
        let urlString = "http://kolor.com/360-videos-files/kolor-balloon-icare-full-hd.mp4"
        guard let url = NSURL(string: urlString) else {
            fatalError("Failed to create URL")
        }

        let player = AVPlayer(URL: url)
        let videoNode = SKVideoNode(AVPlayer: player)
        let size = CGSizeMake(1024,512)
        videoNode.size = size
        videoNode.position = CGPointMake(size.width/2.0,size.height/2.0)
        let spriteScene = SKScene(size: size)
        spriteScene.addChild(videoNode)

        let sphereNode = createSphereNode(material:spriteScene)
        configureScene(node: sphereNode)
        guard motionManager.isDeviceMotionAvailable else {
            fatalError("Device motion is not available")
        }
        startCameraTracking()
    }

    override func viewDidAppear(animated: Bool) {
        sceneView.play(self)
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
*/

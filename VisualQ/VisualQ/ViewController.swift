//
//  ViewController.swift
//  VisualQ
//
//  Created by Pedro Giuliano Farina on 27/10/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var scene: SCNScene!

    
    lazy var H = self.scene.rootNode.childNode(withName: "hidrogen", recursively: false)!
    lazy var O = self.scene.rootNode.childNode(withName: "oxigen", recursively: false)!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        self.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }

        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        
        DispatchQueue.main.async {
            if referenceImage.name == "hidrogenio" {
                self.H.opacity = 1
                self.H.eulerAngles.x = -.pi/2
                node.addChildNode(self.H)
                self.H.runAction(.repeatForever(.rotateBy(x: 0, y: 0, z: 2, duration: 1)))
            } else if referenceImage.name == "oxigenio" {
                self.O.opacity = 1
                self.O.eulerAngles.x = -.pi/2
                node.addChildNode(self.O)
                self.O.runAction(.repeatForever(.rotateBy(x: 0, y: 0, z: 2, duration: 1)))
            }
            
        }
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

//
//  ViewController.swift
//  DeviceRotation-iOS
//
//  
//

import UIKit
import DeviceRotation_framework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /**
         * To present the RotationTrackingVC from your ViewController Class to show the result
         */
        let frameworkBundle = Bundle(identifier: "com.viitorcloud.devicerotationframework")
        let storyboard = UIStoryboard(name: "Main", bundle: frameworkBundle)
        let rotationTrackingVC = storyboard.instantiateViewController(withIdentifier: "RotationTrackingVC")
        rotationTrackingVC.modalPresentationStyle = .fullScreen
        self.present(rotationTrackingVC, animated: false, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

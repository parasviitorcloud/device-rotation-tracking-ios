//
//  RotationTrackingVC.swift
//  DeviceRotation-framework
//
//  
//

import UIKit
import CoreMotion

class RotationTrackingVC: UIViewController {

    /**
     * @IBOutlets
     */
    @IBOutlet weak var lblAngle: UILabel!
    @IBOutlet weak var lblProgressValue: UILabel!
    @IBOutlet weak var progressRing: ALProgressRing!
    
    /**
     * variable declaration to store first value of angle
     */
    var startRotationValue : Int = 0
    
    /**
     * variable declaration  to store progress value from device rotation angle
     */
    var progressValue: Float = 0.0
    
    /**
     * variable declaration  to check very first  value of device rotation angle is getting or not
     */
    var isGetFirstTimeAngle : Bool = false

    /**
     * varibale initialization
     */
    let motionManager = CMMotionManager()
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /**
         * This function call to set property for progress ring
         */
        setupViewForProgressRing()
        
        /**
         * This function call to start the update for device motion
         */
        startUpdatesOfDeviceMotion()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - set property for progress ring as per your requirement
    
    public func setupViewForProgressRing() {
        
        progressRing.lineWidth = 10
        progressRing.grooveWidth = 10
        progressRing.setProgress(0.0, animated: false)
        progressRing.grooveColor = UIColor.red.withAlphaComponent(0.5)
        progressRing.startColor = UIColor.red.withAlphaComponent(1.0)
        progressRing.startColor = UIColor.red.withAlphaComponent(1.0)
    }
    

    // MARK: - This function call when you need to start the device motion updates
    
    public func startUpdatesOfDeviceMotion()   {
        
        if self.motionManager.isDeviceMotionAvailable {
            
            motionManager.deviceMotionUpdateInterval = 0.1
            
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
                
                /**
                 * varibale declaration to store data for Device  Motion
                 */
                guard let motionData = data else {
                    if let err = error {
                        print("Error == \(err.localizedDescription)")
                    }
                    return
                }
                
                /**
                 * varibale declaration to store value for Motion Data attitude
                 */
                let attitude = motionData.attitude
                
                /**
                 * varibale declaration to store value for Motion Data Pitch
                 */
                let pitch = attitude.pitch
                
                /**
                 * varibale declaration to store value for Motion Data Roll
                 */
                let roll = attitude.roll
                
                /**
                 * varibale declaration to store value for Motion Data Yaw
                 */
                let yaw = attitude.yaw
                
                /**
                 * Calcukate Device Rotation Angle
                 */
                self.getDeviceRotationAngle(x: pitch, y: roll, z: yaw)
                
            }
        }
    }
    
    
    // MARK: - This function call for calculate the device rotation angle from Pitch, Roll and Yaw Value
    
    public func getDeviceRotationAngle(x: Double, y: Double, z: Double) {

        DispatchQueue.main.async {

            let zdegrees = z * 180 / .pi

            let zRotationValue = (zdegrees + 360.0).truncatingRemainder(dividingBy: 360.0)
            
            let zAngle = zRotationValue

            /**
             * variable declaration  to store the value of device rotation angle
             */
            var zRotation : Int = 0

            zRotation = Int(zAngle)

            /**
             * To set the value of current device angle to label
             */
            self.lblAngle.text = "Angle is : \(String(zRotation))"
            
            if self.isGetFirstTimeAngle == false {
                self.isGetFirstTimeAngle = true
                self.startRotationValue = zRotation
            }
            
            /**
             * To set the progres value from device rotation Angle
             */
            self.progressValue = self.getProgressValuefromAngle(initialAngle: self.startRotationValue, newAngle: zRotation)
            
            /**
             * To show the progress in the progress ring and progress label
             */
            DispatchQueue.main.async {
                self.lblProgressValue.text = String(format: "%.2f", self.progressValue)
                self.progressRing.setProgress(self.progressValue, animated: false)
            }
        }
    }
    
    
    
    
    // MARK: - This function call for calculate the progress from the device rotation angle
     
    public func getProgressValuefromAngle(initialAngle: Int, newAngle: Int) -> Float {
       
        var x: Int = 0
        var y: Float = 0.0
       
        if newAngle > initialAngle {
            x = newAngle - initialAngle
        }else {
            let diff = 360-initialAngle
            x = diff + newAngle
        }
        
        let floatX : Float = Float(x)
        
        y  = Float(floatX / 360.0)
    
        /**
        * variable declaration to store the value of progress
        */
        var progress : Float = 0.0
        
        if y == 1.0 {
            progress = 1.0
        }else {
            progress = 1.0 - y
        }
        
        return progress
    }


    // MARK: - This function call when you need to stop the device motion updates
    
    public func stopUpdatesOfDeviceMotion() {
        self.motionManager.stopDeviceMotionUpdates()
    }
}

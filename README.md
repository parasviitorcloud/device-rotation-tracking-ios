# device-rotation-tracking-ios

# Introdcuction: 
This library track device 360-degree rotation and gives Angle value while Rotating device or moving in “Right” direction only. 
 
# How to use:   
- Clone or download the code from GitHub and Run  
- Call RotationTrackingVC from the “DeviceRotation-framework” module
- Import CoreMotion Library in Header of your viewcontroller class
- Declare the variable for CMMotionManager class
- Call function setupViewForProgressRing() , startUpdatesOfDeviceMotion() to setup UI Progress Ring view and start to get  device motion updates
- Move towards your “Right” direction only (Rotate device into Right direction), and get “zRotation” value in Degrees. (use this value as per your requirement)  
- Call this “getProgressValuefromAngle” function to get “Progress” value (0.01 to 1.0) using z Angle value. Library currently using that progress value to show the fill circle UI.
  (You can customize UI as per your requirement)

# Details: 
Minimum Deployments iOS Version: 11.0

iOS Deployment Target Version : 16.4

Language: Swift

Language Version: Swift 5 

Supported Devices: iPhone, iPad

//
//  ViewController.swift
//  AccelerometerDemo
//
//  Created by John Pitchko on 2015-Jan-29.
//  Copyright (c) 2015 Pitchko Technology. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
  
  @IBOutlet weak var currentReadingLabel: UILabel!
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var motionDeviceStatusLabel: UILabel!

  
  
  var motionManager = CMMotionManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    updateMotionDeviceStatus()
    currentReadingLabel.text = "0.00000"
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //  Start the accelometer in PUSH mode
  @IBAction func start(sender: AnyObject) {
    
    NSLog("Starting device motion...")
    NSLog("Device motion available? %@", motionManager.deviceMotionAvailable ? "Yes" : "No")
    
    startButton.hidden = true
    stopButton.hidden = false
    motionManager.deviceMotionUpdateInterval = 10.0 / 60.0
    let opQueue = NSOperationQueue()
    
    
    
    motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {
      [unowned self] (CMDeviceMotion motion, NSError error) -> Void in
        self.currentReadingLabel.text = String(format: "%0.5f", motion.userAcceleration.y)
        NSLog("Device motion %@ reading: %0.5f", self.motionManager.deviceMotionActive ? "ON" : "OFF", motion.userAcceleration.y)
      }
    )
    
    
    
    NSLog("Device motion active? %@", motionManager.deviceMotionActive ? "Yes" : "No")
    updateMotionDeviceStatus()
  }
  
  @IBAction func stop(sender: AnyObject) {
    NSLog("Stopping device motion...")
    startButton.hidden = false
    stopButton.hidden = true
    currentReadingLabel.text = "0.00000"
    
    motionManager.stopDeviceMotionUpdates()
    
//    motionManager.stopAccelerometerUpdates()
    
    updateMotionDeviceStatus()
//    NSLog("Device motion active? %@", motionManager.deviceMotionActive ? "Yes" : "No")
  }
  
  func updateMotionDeviceStatus() {
    if motionManager.deviceMotionActive {
      motionDeviceStatusLabel.text = "ON"
    }
    else {
      motionDeviceStatusLabel.text = "OFF"
    }
  }
}


//
//  ViewController.swift
//  CoreMotionExample
//
//  Created by Brothersoft on 11/15/21.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    let manager = CMMotionManager()
    var accelerometerDataString = ""
    var gyroscopeDataString = ""
    private var acceleroTimer: Timer?
    private var gyroTimer: Timer?
    @IBOutlet weak var informationLabel: UILabel!
}

//MARK: - Action methods

extension ViewController {
    @IBAction func getAccelerationButtonTapped() {
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 2
        acceleroTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            if let data = manager.accelerometerData {
                let x = String(format: "%.2f", data.acceleration.x)
                let y = String(format: "%.2f", data.acceleration.y)
                let z = String(format: "%.2f", data.acceleration.z)
                accelerometerDataString = "Accelerometer: X = \(x), Y = \(y), Z = \(z) \n"
                informationLabel.text = "\(accelerometerDataString) \(gyroscopeDataString)"
            }
        }
    }
    
    @IBAction func getGyroscopeButtonTapped() {
        manager.startGyroUpdates()
        manager.gyroUpdateInterval = 2
        gyroTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            if let data = manager.gyroData {
                let x = String(format: "%.2f", data.rotationRate.x)
                let y = String(format: "%.2f", data.rotationRate.y)
                let z = String(format: "%.2f", data.rotationRate.z)
                gyroscopeDataString = "Gyroscope: X = \(x), Y = \(y), Z = \(z) ."
                informationLabel.text = "\(accelerometerDataString) \(gyroscopeDataString)"
            }
        }
    }
    
    @IBAction func clearInfoButtonTapped() {
        manager.stopAccelerometerUpdates()
        manager.stopGyroUpdates()
        acceleroTimer?.invalidate()
        gyroTimer?.invalidate()
        accelerometerDataString = ""
        gyroscopeDataString = ""
        informationLabel.text = "Info"
    }
}


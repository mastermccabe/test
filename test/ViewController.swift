//
//  ViewController.swift
//  test
//
//  Created by McCabe Tonna on 11/2/17.
//  Copyright © 2017 Wambl, LLC. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var motionManager: CMMotionManager?
//    var timer = Timer()
    var isTimerRunning: Bool = false
    var seconds = 1
    var time = 0
    var maximum: Double = 0
    weak var timer: Timer?
    var startTime: Double = 0
    var elapsed: Double = 0
    var status: Bool = false
    var dummyTimer = Timer()
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        isTimerRunning = true
//        startTime = Date().timeIntervalSinceReferenceDate - elapsed
//        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){
//            timer in
//
//            self.time += 1
//
//            print(self.time)
//        }
        
        print ("start button pressed")
        status = true
    }
    
    func start(){
        print("start function initiated")
        startTime = Date().timeIntervalSinceReferenceDate - elapsed
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){
        timer in
        
        self.time += 1
        
//        print(self.time)
        }
    }
    func stop(){
         elapsed = round(Date().timeIntervalSinceReferenceDate - startTime)*100/10000
//        elapsed = round(Date().timeIntervalSinceReferenceDate - startTime)*100/100
//        print ("elapsed",elapsed)
        if (elapsed > maximum){
            maximum = elapsed
        }
        max.text = String(maximum)
        print(maximum)
        height.text = String(elapsed)
        timer?.invalidate()
        isTimerRunning = true
        elapsed = 0
        startTime = 0
        
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        isTimerRunning = false
        stop()
        
//
//        elapsed = (Date().timeIntervalSinceReferenceDate - startTime)*1000
//        print (elapsed)
//
//        height.text = String(elapsed)
//        timer?.invalidate()
        status = false
    }
    
    
    @IBOutlet weak var height: UILabel!
    
    @IBOutlet weak var max: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager = CMMotionManager()
        
        var total : Double = 0
        if let manager = motionManager{
            print("we have motion manager")
            if manager.isDeviceMotionAvailable {
                print("we can detect motion")
                
                let myQ = OperationQueue()
          
                manager.deviceMotionUpdateInterval = 0.1
                manager.startDeviceMotionUpdates(to: myQ, withHandler: { (data: CMDeviceMotion?, error: Error? ) in
                    if let mydata = data {
//
//                        print ("x gravity:", mydata.gravity.x)
//                          print ("y gravity:", mydata.gravity.y)
//                          print ("z gravity:", mydata.gravity.z)
//                        total = (abs(mydata.gravity.x) + abs(mydata.gravity.y) + abs(mydata.gravity.z))
                        total = mydata.gravity.x + mydata.gravity.y + mydata.gravity.z
                           print ("total: ",total)
                        if (total > -1.1){
                            print("IN AIR")
                            self.start()
                            self.status = true
                            self.isTimerRunning = true
                           
                        }
                        else if (self.status == true){
                            self.stop()
                            self.status = false
                            print("stopping line 114")
                            
                        }
                        
                    }
                    if let myerror = error {
                        print("errors",myerror)
                        manager.stopDeviceMotionUpdates()
                    }
                })
                }
                else {
                print("cannot detect motion")
                }
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


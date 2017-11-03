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
    var maximum: Int = 0
    weak var timer: Timer?
    var startTime: Double = 0
    var elapsed: Double = 0
    var status: Bool = false
    var dummyTimer = Timer()
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        start()
        print ("start button pressed")
        
    }
    
    
    
    func start(){
       
        print("start function initiated")
        elapsed = 0
        self.time = 0
        startTime = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){
        timer in
        
        self.time += 1
        self.height.text = String(self.time)
        print(self.time)
            
        }
    }
    func stop(){
//        elapsed = Date().timeIntervalSinceReferenceDate - startTime
//        elapsed = round(Date().timeIntervalSinceReferenceDate - startTime)*100/100
        
        print ("elapsed",self.time)
        if (self.time > maximum){
            maximum = self.time
        }
        max.text = String(maximum)
        print(maximum)
//        height.text = String(elapsed)
        timer?.invalidate()
        
       
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
//        isTimerRunning = false
        stop()

        
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
                        total = abs(mydata.gravity.x + mydata.gravity.y + mydata.gravity.z)
                           print ("total: ",total)
                        if (total > 0.6){
                            self.status = false
                        }
                        else{
                            self.status = true
                        }
                        if(self.status == false){
                            print("status",self.status)
                            
                            self.status = true
                             print("status",self.status)
                            
                            self.start()

                        }
                        if (self.status == true){
                            
                            self.status = false
                            
                            self.stop()
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


//
//  File.swift
//  
//
//  Created by Farid Azhari on 06/04/23.
//

import Foundation
import CoreMotion
import UIKit

class tilt:ObservableObject{
    @Published var angle:Int
    var motionManager: CMMotionManager = CMMotionManager()
    
    init(){
        angle = 0
    }
    
    func listenAngle(){
        motionManager.gyroUpdateInterval = 0.5
        motionManager.startGyroUpdates(to: OperationQueue.current!){
            (data, error) in
            print(data as Any)
//            if let trueData = data{
//                self.view
//                
//            }
        }
    }
    
    func getAngle(){
        
        if(motionManager.isGyroAvailable){
            motionManager.startGyroUpdates(
                to: OperationQueue.current!,
                withHandler: { (gyroData: CMGyroData?, errorOC: Error?) in
                                   self.outputGyroData(gyro: gyroData!)
                }
            )
        }
    }
    
    func outputGyroData(gyro: CMGyroData){
            print("Gyro rotation: \(gyro.rotationRate)")
        }

}

//
//  SwiftUIView.swift
//  
//
//  Created by Farid Azhari on 06/04/23.
//

import SwiftUI
import CoreMotion

struct TrackView: View {
    @State var buttonText: String = "Start"
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var mseconds: Int = 0
    @State var timer: Timer? = nil
    @State var gyroTymer: Timer? = nil
    @State var x:Double = 0
    @State var leastAngle:Double = 0
    @State var greatestAngle:Double = 0
    @State var waktuMulai:Date = Date()
    @State var waktuSelesai:Date = Date()
    @State var cornerData:historyData? = nil
    @State var cornerDetail:[historyDetail] = []
    @State var cornerLeastAngle:Double = 0
    @State var cornerGreatestAngle:Double = 0
    @State var dataAvailable:Bool = false
    @State var motoDegree: Double = 0
    
    let motion = CMMotionManager()
    
    var body: some View {
        NavigationView{
            Text("")
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            // .background(Color.black)
                .background(Color(red: 0.145, green: 0.145, blue: 0.145))
                .overlay(
                    VStack{
                        Spacer()
                        Text("\(hours):\(minutes):\(seconds):\(mseconds*100)")
                            .font(.system(size: 64))
                            .foregroundColor(Color.orange)
                        
                        Text("\(x)"+" degree")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                        Circle().fill(buttonText == "Start" ? Color.blue : Color.orange)
                            .frame(width: 320, height: 320)
                            .overlay(
                                VStack{
                                    Text(buttonText == "Start" ? "Tap to start" : "Long press to stop")
                                        .font(.system(size: 36))
                                    
                                    
                                    buttonText == "Start" ? Text("\r\nMake sure the Apple logo is facing your front")
                                        .multilineTextAlignment(.center) : nil
                                    
                                    buttonText == "Start" ? nil : Image("motor").resizable()
                                        .rotationEffect(.degrees(motoDegree),anchor: UnitPoint(x: 0.5, y: 1))
                                        .frame(width: 80, height: 80)
                                    
                                }.foregroundColor(Color.white)
                            ).onTapGesture {
                                
                                if(buttonText == "Start"){
                                    buttonText = "Stop"
                                    self.startGyro()
                                    self.startTimer()
                                    self.dataAvailable = false
                                    self.x = 0
                                    self.cornerGreatestAngle = 0
                                    self.cornerLeastAngle = 0
                                    waktuMulai = Date()
                                    cornerDetail = []
                                }
                            }
                            .onLongPressGesture{
                                if(buttonText == "Stop"){
                                    buttonText = "Start"
                                    self.stopTimer()
                                    self.stopGyros()
                                    
                                    waktuSelesai = Date()
                                    
                                    let formatter = DateFormatter()
                                    //formatter.dateStyle = .short
                                    formatter.dateFormat = "dd-MM-yyyy HH:mm:ss.SSSS"
                                    
                                    self.cornerData = historyData(waktuMulai, waktuSelesai, formatter.string(from: waktuMulai), formatter.string(from: waktuSelesai), cornerDetail.count,
                                                                  self.cornerLeastAngle,
                                                                  self.cornerGreatestAngle,                          cornerDetail)
                                    self.dataAvailable = true
                                    self.x = 0
                                    self.restartTimer()
                                }
                            }
                        Spacer()
                         NavigationLink(destination: DetailView(cornerData: self.cornerData ?? historyData())) {
                            RoundedRectangle(cornerRadius: 50)
                                .strokeBorder(Color.blue, lineWidth: 1)
                                .background(RoundedRectangle(cornerRadius: 50).fill(Color.white)).opacity(0.9)
                            // .fill(Color.white)
                            
                            //.background(Color.white)
                                .frame(width: 180,height: 50)
                                .overlay(Text("View Result")
                                    .foregroundColor(Color.blue)
                                    .font(.system(size: 22))
                                )
                        }
                        .opacity(dataAvailable ? 1 : 0)
                        
                        
                        Spacer()
                        Spacer()
                    })
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
    }
    
    func startTimer(){
        //timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1/10, repeats: true){ tempTimer in
            if self.mseconds == 9 {
                self.mseconds = 0
                if self.seconds == 59 {
                    self.seconds = 0
                    if self.minutes == 59 {
                        self.minutes = 0
                        self.hours = self.hours + 1
                    } else {
                        self.minutes = self.minutes + 1
                    }
                    
                } else {
                    self.seconds = self.seconds + 1
                }
            } else {
                self.mseconds = self.mseconds + 1
            }
        }
    }
    
    func stopTimer(){
        // timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    func restartTimer(){
        hours = 0
        minutes = 0
        seconds = 0
        mseconds = 0
    }
    
    func startGyro(){
        
        if motion.isAccelerometerAvailable {
            
            self.motion.accelerometerUpdateInterval = 1.0 / 10.0
            self.motion.startAccelerometerUpdates()
            
            self.gyroTymer = Timer(fire: Date(), interval: (1.0 / 10.0),
                                   repeats: true, block: { (timer) in
                
                if let data = self.motion.accelerometerData {
                    
                    
                    let x = self.roundDouble(value:data.acceleration.x)
                    
                    self.x = x > 80  || x < -80 || (x > -11 && x < 11) ? 0 : x
                    
                    self.motoDegree = self.x
                    if self.x > self.cornerGreatestAngle {
                        self.cornerGreatestAngle = self.x
                    } else if self.x < self.cornerLeastAngle {
                        self.cornerLeastAngle = self.x
                    }
                    
                    
                    
                    if self.x > self.greatestAngle {
                        self.greatestAngle = self.x
                    } else if self.x < self.leastAngle {
                        self.leastAngle = self.x
                        
                    } else if self.x == 0 {
                        var valToSave:Double = 0
                        var needToSave:Bool = false
                        if self.leastAngle < 0 {
                            valToSave = self.leastAngle
                            needToSave = true
                        } else if self.greatestAngle > 0 {
                            valToSave = self.greatestAngle
                            needToSave = true
                        }
                        
                        if needToSave {
                            self.cornerDetail.append(historyDetail(Date(), valToSave))
                            
                            
                            
                            self.greatestAngle = 0.0
                            self.leastAngle = 0.0
                        }
                    }
                }
                
                
            })
            
            RunLoop.current.add(self.gyroTymer!, forMode: .default)
        }
    }
    
    func stopGyros() {
        if self.gyroTymer != nil {
            self.gyroTymer?.invalidate()
            self.gyroTymer = nil
            
            self.motion.stopAccelerometerUpdates()
        }
    }
    
    private func roundDouble(value: Double) -> Double {
        return round(9000 * value).rounded()/100
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView()
    }
}

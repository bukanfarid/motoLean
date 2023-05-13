import CoreMotion
import UIKit
import SwiftUI

struct ContentView: View {
    @State private var currentTab = 0
    @State var timer: Timer? = nil
    @State var motoDegree: Double = 0
    @State var isPlus:Bool = true
    var body: some View {
        NavigationView{
            TabView(selection: $currentTab){
               firstTab()
                    .tag(0)
                secondTab()
                    .tag(1)
                thirdTab()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
            .background(Color.blue)
            .gesture(DragGesture())
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }.navigationViewStyle(StackNavigationViewStyle())
            .onAppear{
                startTimer()
            }
        
        
        // TabView(content: {
        //TrackView()
        //            .tabItem{
        //                Label("Record   ", systemImage: "record.circle")
        //            }
        
        //            HistoryView().tabItem{
        //                Label("History", systemImage: "book")
        //            }
        // })
    }
    
    func firstTab() -> some View{
        VStack{
            Spacer()
            Image("motor")
                .resizable()
                .rotationEffect(.degrees(motoDegree),anchor: UnitPoint(x: 0.5, y: 1))
                .frame(width: 80, height: 80)
            Text("MotoLean\r\n")
                .font(.system(.largeTitle))
            Text("Are you a sportbike rider?\r\n")
            Text("Do you know how tilted your bike is in every corner?")
            Spacer()
           // Text("Motorcycle PNG Designed By Pugazh Productions from \r\n https:/pngtree.com/freepng/luxurious-superbike-motorcycle-front-view-vector-design_5679834.html?sol=downref&id=bef").font(.caption)
            Spacer()
        }.padding()
            .multilineTextAlignment(.center)
            .foregroundColor(Color.white)
    }
    
    func secondTab() -> some View{
        VStack{
            Spacer()
            Text("We never knows\r\n")
                .font(.system(.title))
            Text("Because we focused on riding.\r\n")
            Text("Except we record it in video,")
            Text("And measure it manually.")
            Spacer()
        }
        .multilineTextAlignment(.center)
            .foregroundColor(Color.white)
    }
    
    func thirdTab() -> some View{
        VStack{
            Spacer()
            Text("So here we are\r\n")
                .font(.system(.title))
            //Text("We record your corners")
            Text("We record the maximum incline of your bike")
            Text("In every corners\r\n\r\n")
            
            NavigationLink(destination: TabbedView()) {
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color.white, lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue)).opacity(0.9)
                   // .fill(Color.white)
                
                    //.background(Color.white)
                    .frame(width: 180,height: 50)
                    .overlay(Text("Let's Start")
                        .foregroundColor(Color.white)
                        .font(.system(size: 22))
) 
                   
            }
            Spacer()
        }
            .foregroundColor(Color.white)
    }
    
    func startTimer(){
        //timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1/10, repeats: true){ tempTimer in
            if self.isPlus {
                if self.motoDegree < 32 {
                    self.motoDegree = self.motoDegree + 3
                } else {
                    isPlus = false
                }
                 
            } else {
                if self.motoDegree > -32 {
                    self.motoDegree = self.motoDegree - 3
                } else {
                    isPlus = true
                }
            }
        }
    }
    
}

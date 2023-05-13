//
//  SwiftUIView.swift
//  
//
//  Created by Farid Azhari on 06/04/23.
//

import SwiftUI

struct DetailView: View {
    var cornerData:historyData
    //let formatter = DateFormatter()
    //formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    var body: some View {
        Text("")
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        // .background(Color.black)
            .background(Color(red: 0.145, green: 0.145, blue: 0.145))
            .overlay(VStack(alignment:.leading){
                
                //VStack(alignment: .leading){
                
                Text("Start Time : \(getTime(waktu: cornerData.waktuMulai))")
                    .foregroundColor(Color.white)
                Text("End Time : \(getTime(waktu:cornerData.waktuSelesai))")
                    .foregroundColor(Color.white)
                Text("Trip Length : \(tripLength(waktuAwal:cornerData.waktuMulai, waktuAkhir: cornerData.waktuSelesai))")
                    .foregroundColor(Color.white)
                Text("Corner count : \(cornerData.cornerCount)")
                    .foregroundColor(Color.white)
                Text("Best Left Angle : \(abs(cornerData.leastAngle), specifier: "%.2f")" ).foregroundColor(Color.white)+Text("o").baselineOffset(6.0)
                    .foregroundColor(Color.white)
                Text("Best Right Angle : \(cornerData.greatestAngle, specifier:  "%.2f")" )
                    .foregroundColor(Color.white)+Text("o").baselineOffset(6.0)
                    .foregroundColor(Color.white)
                
                
                //  }
                Text("Corner History").frame(maxWidth: .infinity).padding().background(Color.black)
                    .foregroundColor(Color.white)
                
                ScrollView{
                    VStack(alignment: .leading){
                        ForEach(cornerData.history, id: \.waktu){ pHistory in
                            historyCard(data: pHistory, bestAngle: cornerData.greatestAngle, leastAngle: cornerData.leastAngle)
                            Divider()
                            
                        }
                    }
                }
            }
                .padding([.leading, .trailing, .bottom])
            )
    }
    
    func getTime(waktu:Date) -> String{
      //  var x:String = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        return formatter.string(from: waktu)
         
    }
    
    func tripLength(waktuAwal:Date, waktuAkhir:Date) -> String{
        var strBedaWaktu:String = ""
        let bedaWaktu = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: waktuAwal, to: waktuAkhir)
        
        strBedaWaktu = "\(bedaWaktu.hour != nil ? String(bedaWaktu.hour!)+" Hours, " : "") \(bedaWaktu.minute != nil ? String(bedaWaktu.minute!)+" Minutes, " : "") \(bedaWaktu.second != nil ? String(bedaWaktu.second!)+" Seconds" : "")"
        
        return strBedaWaktu
        
    }
    
    func historyCard(data:historyDetail,bestAngle:Double, leastAngle:Double)-> some View{
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        timeFormatter.dateFormat = "HH:mm:ss"
        
        return HStack{
            VStack(alignment: .leading){
                Text(dateFormatter.string(from: data.waktu))
                    .multilineTextAlignment(.center)
                    
                Text(timeFormatter.string(from: data.waktu))
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            Image(systemName: data.angle<0 ?  "arrow.turn.up.left" : "arrow.turn.up.right").foregroundColor(data.angle == bestAngle || data.angle == leastAngle ? Color.green : Color.white)
            Text(String(abs(data.angle)))+Text("o").baselineOffset(6.0)
 
            
        } 
            .foregroundColor(data.angle == bestAngle || data.angle == leastAngle ? Color.green : Color.white)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let cornerData:historyData = historyData()
        DetailView(cornerData: cornerData)
    }
}

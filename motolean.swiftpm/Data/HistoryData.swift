//
//  File.swift
//  
//
//  Created by Farid Azhari on 10/04/23.
//

import Foundation

class historyList: ObservableObject{
    @Published var listHistory:[historyData] = []
    
    
    init(){
        self.addData("01-01-2023 07:15:15", "01-01-2023 09:30:22",5)
        
        self.addData("02-01-2023 07:15:15", "02-01-2023 13:30:22",52)
    }
    
    func addData(_ waktuMulai:String, _ waktuSelesai:String, _ tikungan:Int){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let waktuAwal = formatter.date(from: waktuMulai) ?? Date()
        let waktuAkhir = formatter.date(from: waktuSelesai) ?? Date()
        
        listHistory.append(historyData(waktuAwal, waktuAkhir, waktuMulai, waktuSelesai, tikungan, 0.0, 0.0, []))
    }
    
    
    
    
}

struct historyData{
    var waktuMulai:Date
    var waktuSelesai:Date
    var stringMulai:String
    var stringSelesai:String
    var cornerCount:Int
    var leastAngle:Double
    var greatestAngle:Double
    var history:[historyDetail]
   
    init(_ waktuMulai: Date = Date(), _ waktuSelesai: Date = Date(), _ stringMulai: String = "", _ stringSelesai: String = "", _ cornerCount: Int = 0, _ leastAngle:Double = 0.0, _ greatestAngle:Double = 0.0, _ history: [historyDetail] = []) {
        self.waktuMulai = waktuMulai
        self.waktuSelesai = waktuSelesai
        self.stringMulai = stringMulai
        self.stringSelesai = stringSelesai
        self.cornerCount = cornerCount
        self.leastAngle = leastAngle
        self.greatestAngle = greatestAngle
        self.history = history
    }
}


struct historyDetail{
//    var hour:Int
//    var minute:Int
//    var second:Int
//    var msecond:Int
    var waktu:Date
    var angle:Double
    
//    init (_ jam:Int = 0, _ menit:Int = 0, _ detik:Int = 0, _ msecond:Int = 0, _ sudut:Double = 0){
//        self.hour = 0
//        self.minute = 0
//        self.second = 0
//        self.msecond = 0
//        self.angle = 0.0
//    }
    init (_ waktu:Date = Date(), _ sudut:Double = 0){
        self.waktu = waktu
        self.angle = sudut
    }
    
}

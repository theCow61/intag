//
//  intagApp.swift
//  intag
//
//  Created by Z Salti on 11/12/22.
//

import SwiftUI
import SwiftSoup

let FILENAME = "sample-result-2021-2042.output.txt"

struct IqamaTimes {
    
//    var fajrTime: Date
//    var duhrTime: Date
//    var asrTime: Date
//    var maghribTime: Date
//    var ishaTime: Date
    var times: [DateComponents]
//    private var currentDay: Date
    
    
    /**
                This works and ONLY WORKS for Ames, IA Darul Arqum Iqama times and might not always be correct.
                    Uses the auto generated sample result of predicted iqama times, should not be depended on
     */
    
    
//    private init(_ fajrTime: Date, _ duhrTime: Date, _ asrTime: Date, _ maghribTime: Date, _ ishaTime: Date) {
//        self.fajrTime = fajrTime
//        self.duhrTime = duhrTime
//        self.asrTime = asrTime
//        self.maghribTime = maghribTime
//        self.ishaTime = ishaTime
//        currentDay = Date()
//        times = [DateComponents()]
//    }
//
//    init() {
//
//        let date = Date()
//        currentDay = date
//        let calendar = Calendar.current
//        let month = calendar.component(.month, from: date)
//        let day = calendar.component(.day, from: date)
//        let year = calendar.component(.year, from: date)
//
//        let pattern = String(month) + "-" + String(day) + "-" + String(year).suffix(2)
//
//
//
//        var foundLine: String = ""
//
//        if let path = Bundle.main.path(forResource: FILENAME, ofType: nil) {
//            do {
//                let contents = try String(contentsOfFile: path);
//                let lines = contents.split(separator: "\n")
//                for line in lines {
//                    if line.contains(pattern) {
//                        foundLine += line
//                    }
//                }
//            } catch {
//                print("cant read")
//            }
//        }
//
//        // Fajr
//        var index1 = foundLine.index(foundLine.startIndex, offsetBy: 22)
//        var index2 = foundLine.index(foundLine.startIndex, offsetBy: 26)
//        let fajrIqama = foundLine[index1...index2]
//        let fajrComp = DateComponents(hour: Int(fajrIqama.prefix(2)), minute: Int(fajrIqama.suffix(2)))
//
//        // Duhr
//        index1 = foundLine.index(foundLine.startIndex, offsetBy: 50)
//        index2 = foundLine.index(foundLine.startIndex, offsetBy: 54)
//        let duhrIqama = foundLine[index1...index2]
//
//        var duhrHour = Int(duhrIqama.prefix(2)).unsafelyUnwrapped
//        if duhrHour < 12 {
//            duhrHour += 12
//        }
//
//        let duhrComp = DateComponents(hour: duhrHour, minute: Int(fajrIqama.suffix(2)))
//
//        // Asr
//        index1 = foundLine.index(foundLine.startIndex, offsetBy: 69)
//        index2 = foundLine.index(foundLine.startIndex, offsetBy: 73)
//        let asrIqama = foundLine[index1...index2]
//        let asrComp = DateComponents(hour: Int(asrIqama.prefix(2)).unsafelyUnwrapped + 12, minute: Int(fajrIqama.suffix(2)))
//
//        // Maghrib
//        index1 = foundLine.index(foundLine.startIndex, offsetBy: 88)
//        index2 = foundLine.index(foundLine.startIndex, offsetBy: 92)
//        let maghribIqama = foundLine[index1...index2]
//        let maghribComp = DateComponents(hour: Int(maghribIqama.prefix(2)).unsafelyUnwrapped + 12, minute: Int(fajrIqama.suffix(2)))
//
//        // Isha
//        index1 = foundLine.index(foundLine.startIndex, offsetBy: 107)
//        index2 = foundLine.index(foundLine.startIndex, offsetBy: 111)
//        let ishaIqama = foundLine[index1...index2]
//        let ishaComp = DateComponents(hour: Int(ishaIqama.prefix(2)).unsafelyUnwrapped + 12, minute: Int(fajrIqama.suffix(2)))
//
//
//        fajrTime = calendar.date(from: fajrComp).unsafelyUnwrapped
//        duhrTime = calendar.date(from: duhrComp).unsafelyUnwrapped
//        asrTime = calendar.date(from: asrComp).unsafelyUnwrapped
//        maghribTime = calendar.date(from: maghribComp).unsafelyUnwrapped
//        ishaTime = calendar.date(from: ishaComp)!
//
//
//
//
//
//    }
    
    
    init() {
        
        
        var prayerIqama: [DateComponents] = [DateComponents]()
        
        do {
            
            let content: String = try String(contentsOf: URL(string: "https://arqum.org/")!, encoding: String.Encoding.ascii)
            
            
            
            let doc: Document = try SwiftSoup.parse(content)
            let table = try doc.select("table")
            
            for tabl in table.array() { // Isn't necessary because there is only one table in all html but you don't know in future what may happen
                if try tabl.className() == "table table-striped prayerHomeTable" {
                    
                    //                            let innerDoc: Document = try SwiftSoup.parse(try tabl.html())
                    //                            let innerDoc = try SwiftSoup.parseBodyFragment(try tabl.html())
                    //                            print(innerDoc)
                    
                    
                    var prayerBlocks: [Element] = try tabl.select("tr").array()
                    prayerBlocks.removeFirst() // Remove "SALAH ADHAN IQAMA" header
                    prayerBlocks.remove(at: 1) // Remove "SUNRISE" we might want that later; remember that when you remove the index changes
                    prayerBlocks.removeLast() // Remove "Download"
                    
                    //                            var prayerIqama: [DateComponents] = [DateComponents]()
                    
                    for block in prayerBlocks {
                        
                        var sTime: String = try block.select("td").last()!.text()
                        
                        var hour: Int = Int(sTime.prefix(2))!
                        
                        if sTime.suffix(2) == "PM" && hour != 12 {
                            hour += 12
                        }
                        
                        sTime.removeLast(3)
                        let minute: Int = Int(sTime.suffix(2))!
                        print(String(hour) + " " + String(minute))
                        
                        // hour minute should be correct now
                        
                        let comp: DateComponents = DateComponents(hour: hour, minute: minute)
                        prayerIqama.append(comp)
                        
                    }
                    
                    //                            self.times = prayerIqama
                    
                }
                
                
            }
        } catch {}
        
        let task = URLSession.shared.dataTask(with: URL(string: "https://arqum.org/")!) {
            (data, response, error) -> Void in
            
            if error == nil {
                //                content = (NSString(data: data!, encoding: String.Encoding.ascii.rawValue) as NSString?)!
                let content = String(data: data!, encoding: String.Encoding.ascii)!
                
                do {
                    
                    
                    
                    let doc: Document = try SwiftSoup.parse(content)
                    let table = try doc.select("table")
                    
                    for tabl in table.array() { // Isn't necessary because there is only one table in all html but you don't know in future what may happen
                        if try tabl.className() == "table table-striped prayerHomeTable" {
                            
                            //                            let innerDoc: Document = try SwiftSoup.parse(try tabl.html())
                            //                            let innerDoc = try SwiftSoup.parseBodyFragment(try tabl.html())
                            //                            print(innerDoc)
                            
                            
                            var prayerBlocks: [Element] = try tabl.select("tr").array()
                            prayerBlocks.removeFirst() // Remove "SALAH ADHAN IQAMA" header
                            prayerBlocks.remove(at: 1) // Remove "SUNRISE" we might want that later; remember that when you remove the index changes
                            prayerBlocks.removeLast() // Remove "Download"
                            
                            //                            var prayerIqama: [DateComponents] = [DateComponents]()
                            
                            for block in prayerBlocks {
                                
                                var sTime: String = try block.select("td").last()!.text()
                                
                                var hour: Int = Int(sTime.prefix(2))!
                                
                                if sTime.suffix(2) == "PM" && hour != 12 {
                                    hour += 12
                                }
                                
                                sTime.removeLast(3)
                                let minute: Int = Int(sTime.suffix(2))!
                                print(String(hour) + " " + String(minute))
                                
                                // hour minute should be correct now
                                
                                let comp: DateComponents = DateComponents(hour: hour, minute: minute)
                                prayerIqama.append(comp)
                                
                            }
                            
                            //                            self.times = prayerIqama
                            
                        }
                    }
                    
                    
                    
                    
                    
                } catch Exception.Error(type: let type, Message: let message ){
                    
                } catch {
                }
                
                
            }
        }
        
//        task.resume()
//
//        while !task.progress.isFinished {
//            print("wait")
//        }
        
        print("ran")
        times = prayerIqama
        
//        self.init(Date(), Date(), Date(), Date(), Date())
    }
    
        
        
        
}

@main
struct intagApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

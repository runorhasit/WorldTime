//
//  TimeViewModel.swift
//  WorldTime
//
//  Created by Runor Jiroma on 26/12/2025.
//

import Foundation
import Combine

final class TimeViewModel: ObservableObject {
    
    @Published var now: Date = Date()
    
    /// The time the user is scrubbing to (this drives the UI)
    @Published var scrubbedDate: Date = Date()
    
    /// True while a drag gesture is actively controlling the dial
    @Published private(set) var isScrubbing: Bool = false
    
    
    private var timer: AnyCancellable?
    
    init() {
        
        self.scrubbedDate = Date()   // start at "now"
        
            timer = Timer
                .publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    guard let self else {return}
                        self.now = Date()
                    
                // keep scrubbedDate live while nobody is actively dragging
                    if !self.isScrubbing {
                        self.scrubbedDate = self.now
                    }
                }
        }
    
    
    deinit {
        timer?.cancel()
    }
    
    
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    
    func timeString(for timeZone: TimeZone) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: scrubbedDate)
    }
    
    func dayNote(for timeZone: TimeZone) -> String {
        
        //User's base Calendar
        var localCalendar = Calendar.current
            localCalendar.timeZone = .current
    
        //remote calendar
        var remoteCalendar = Calendar.current
        remoteCalendar.timeZone = timeZone
        
        //compare full calendar dates, not just the day-of-month number
        let localComponents = localCalendar.dateComponents([.year, .month, .day], from: scrubbedDate)
        let remoteComponents = remoteCalendar.dateComponents([.year, .month, .day], from: scrubbedDate)
        
        let offset: Int
        if let localDate = localCalendar.date(from: localComponents),
           let remoteDate = localCalendar.date(from: remoteComponents) {
            offset = localCalendar.dateComponents([.day], from: localDate, to: remoteDate).day ?? 0
        } else {
            offset = 0
        }
        
        let dayText: String
        switch offset {
        case -1: dayText = "Yesterday"
        case 0: dayText = "Today"
        case 1: dayText = "Tomorrow"
        default: dayText = offset > 1 ? "Future" : "Past"
        }
        
        //GMT offset also uses scrubbedDate
        let seconds = timeZone.secondsFromGMT(for: scrubbedDate)
        
        let sign = seconds >= 0 ? "+" : "-"
        let absSeconds = abs(seconds)
        
        let hours = absSeconds / 3600
        let minutes = (absSeconds % 3600) / 60
        
        let gmtText = minutes == 0
            ? "GMT\(sign)\(abs(hours))"
            : "GMT\(sign)\(abs(hours)):\(String(format: "%02d", minutes))"
        
        return "\(dayText) \(gmtText)"
        
    }
    
    
    func beginScrubbing() {
        isScrubbing = true
    }
    
    func endScrubbing() {
        isScrubbing = false
        // sync immediately so there is no gap before the next timer tick
        scrubbedDate = now
    }
    
    func scrub(to degrees: Double) {
        let minutes = Int((degrees/360) * 1440)
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        scrubbedDate =
        Calendar.current.date(byAdding: .minute,
            value: minutes, to: startOfDay) ?? now
    }
    
    func scrub(byDegrees degrees: Double) {
        let minutesDelta = degrees / 360 * 1440
        scrubbedDate = scrubbedDate.addingTimeInterval(minutesDelta * 60)
    }
    

}




    

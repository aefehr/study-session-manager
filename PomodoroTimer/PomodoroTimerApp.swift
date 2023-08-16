//
//  PomodoroTimerApp.swift
//  PomodoroTimer
//
//  Created by Allie Fehr on 7/2/23.
//

import SwiftUI

@main
struct PomodoroTimerApp: App {
    // Initiliazing background fetching
    @StateObject var pomodoroModel: PomodoroModel = .init()
    // Scene Phase
    @Environment(\.scenePhase) var phase
    // Storing last time stamp
    @State var lastActiveTimeStamp: Date = Date()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pomodoroModel)
        }
        .onChange(of: phase) { newValue in
            if pomodoroModel.isStarted{
                if newValue == .background{
                    lastActiveTimeStamp = Date()
                }
                
                if newValue == .active{
                    // Finding difference
                    let currentTimeStampDiff = Date().timeIntervalSince(lastActiveTimeStamp)
                    if pomodoroModel.totalSeconds - Int(currentTimeStampDiff) <= 0{
                        pomodoroModel.isStarted = false
                        pomodoroModel.totalSeconds = 0
                        pomodoroModel.updateTimer()
                    }else{
                        pomodoroModel.totalSeconds -= Int(currentTimeStampDiff)
                    }
                }
            }
        }
    }
}

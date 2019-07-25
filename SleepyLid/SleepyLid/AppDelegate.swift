//
//  AppDelegate.swift
//  SleepyLid
//
//  Created by Henri Prudhomme on 6/16/19.
//  Copyright © 2019 Henri. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let menu = NSMenu()
    
    func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
    
    @objc func EnableSleep(sender: NSStatusBar) {
        shell("sudo", "pmset -a disablesleep 1")
    }
    
    @objc func DisableSleep(sender: NSStatusBar) {
       shell("sudo", "pmset -a disablesleep 0")
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let icon = NSImage(named: "star")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        menu.addItem(NSMenuItem(title: "Enable", action: #selector(EnableSleep(sender:)), keyEquivalent: "G"))
        menu.addItem(NSMenuItem(title: "Disable", action: #selector(DisableSleep(sender:)), keyEquivalent: "J"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApp.terminate(_:)), keyEquivalent: "K"))
        statusItem.menu = menu
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}


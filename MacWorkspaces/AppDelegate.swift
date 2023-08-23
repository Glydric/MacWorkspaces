//
//  AppDelegate.swift
//  MacWorkspaces
//
//  Created by Leonardo Migliorelli on 23/08/23.
//


import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
	
	func applicationWillFinishLaunching(_ notification: Notification) {
		NSApp.setActivationPolicy(.accessory)
	}
}


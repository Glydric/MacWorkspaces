//
//  MacWorkspacesApp.swift
//  MacWorkspaces
//
//  Created by Leonardo Migliorelli on 23/08/23.
//

import SwiftUI

@main
struct MacWorkspacesApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
		MenuApp()
    }
}

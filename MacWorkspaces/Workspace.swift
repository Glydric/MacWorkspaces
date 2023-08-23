//
//  Window.swift
//  MacWorkspaces
//
//  Created by Leonardo Migliorelli on 23/08/23.
//

import AppKit


struct Workspace: Hashable {
	var id: Int = 0
	var title: String? = nil
	var windows: [NSWindow] = [NSWindow]()
	var description: String {
		let actualTitle: String = self.title != nil ? self.title! : "Default \(self.id)"
		return "\(actualTitle) (\(self.windows.count) screens)"
	}
}

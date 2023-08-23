//
//  Window.swift
//  MacWorkspaces
//
//  Created by Leonardo Migliorelli on 23/08/23.
//

import AppKit


struct Workspace: Hashable {
	var id: Int = 0
	var title: String = "Default"
	var windows: [NSWindow] = [NSWindow]()
}

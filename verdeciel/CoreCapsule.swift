//
//  CapsuleNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreCapsule: SCNNode
{
	var hull:Float = 100
	var shield:Float = 100
	var oxygen:Float = 100
	
	var at:CGPoint = CGPoint(x:-1,y:-4) // CGPoint(x:-1,y:-4)
	var travel:Float = 0
	
	var direction:CGFloat! = 1
	var sector:sectors = sectors.normal
	var instance:Event!
	
	var dock:Location!
	
	override init()
	{
		super.init()
		
		self.direction = 0
		
		nodeSetup()

		capsuleSetup()
		panelSetup()
		
		capsuleMesh()
	}
	
	override func start()
	{
		connectDefaultPorts()
		dockbay.start()
	}
	
	func dock(newDock:Location)
	{
		dock = newDock
		custom.dock(dock)
		thruster.enable()
		dockbay.update()
	}
	
	func undock()
	{
		dock = nil
		custom.undock()
		thruster.disable()
	}
	
	func connectDefaultPorts()
	{
		battery.outCell1.connect(battery.inOxygen)
		battery.outCell2.connect(battery.inThruster)
		battery.outCell3.connect(battery.inShield)
		radar.output.connect(pilot.input)		
		cargo.output.connect(console.input)
	}
	
	func nodeSetup()
	{
		var scale:Float = 0.25
		var height:Float = -3.35
		floorNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 0.3
		height = -3.5
		lowMidNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 1
		height = -2.4
		lowGapNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 1
		height = -1.5
		lowNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 1
		height = 1.5
		highNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 1
		height = 2.4
		highGapNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 0.5
		height = 4
		highMidNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 0.25
		height = 3.9
		ceilingNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale), SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
	}
	
	override func fixedUpdate()
	{		
		service()
		systems()
	}
	
	func systems()
	{
		if battery.inOxygen.origin != nil {
			if battery.inOxygen.origin.event.type == eventTypes.cell && capsule.oxygen < 100 { capsule.oxygen += 0.5 }
		}
		if battery.inShield.origin != nil {
			if battery.inShield.origin.event.type == eventTypes.cell && capsule.shield < 100 { capsule.shield += 0.5 }
		}
	}
	
	func service()
	{
		if dock == nil { return }
		if dock.service == services.electricity && battery.value < 100 { battery.recharge() }
		if dock.service == services.hull && capsule.hull < 100 { capsule.hull += 0.5 }
	}
	
	func panelSetup()
	{
		let northPanels = SCNNode()
		custom = PanelQuest()
		dockbay = PanelDock()
		northPanels.addChildNode(custom)
		northPanels.addChildNode(dockbay)
		northPanels.addChildNode(PanelHandle(destination: SCNVector3(0,0,1.5)))
		
		let northEastPanels = SCNNode()
		cargo = PanelCargo()
		northEastPanels.addChildNode(cargo)
		
		let northWestPanels = SCNNode()
		thruster = PanelThruster()
		northWestPanels.addChildNode(thruster)
		
		let eastPanels = SCNNode()
		console = PanelConsole()
		eastPanels.addChildNode(console)
		eastPanels.addChildNode(PanelHandle(destination: SCNVector3(-1.5,0,0)))
		
		let southEastPanels = SCNNode()
		beacon = PanelHatch()
		southEastPanels.addChildNode(beacon)
		
		let southWestPanels = SCNNode()
		pilot = PanelPilot()
		southWestPanels.addChildNode(pilot)
		
		let southPanels = SCNNode()
		battery = PanelBattery()
		radiation = PanelRadiation()
		radio = PanelRadio()
		southPanels.addChildNode(battery)
		southPanels.addChildNode(radio)
		southPanels.addChildNode(radiation)
		southPanels.addChildNode(PanelHandle(destination: SCNVector3(0,0,-1.5)))
		
		let westPanels = SCNNode()
		radar = PanelRadar()
		translator = PanelTranslator()
		targetter = PanelTargetter()
		westPanels.addChildNode(radar)
		westPanels.addChildNode(translator)
		westPanels.addChildNode(targetter)
		westPanels.addChildNode(PanelHandle(destination: SCNVector3(1.5,0,0)))
		
		northPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2))
		northEastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1.5))
		northWestPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 3.5))
		eastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1))
		southEastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0.5))
		southWestPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2.5))
		southPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0))
		westPanels.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 1))
		
		window = PanelWindow()
		
		self.addChildNode(northPanels)
		self.addChildNode(northEastPanels)
		self.addChildNode(northWestPanels)
		self.addChildNode(eastPanels)
		self.addChildNode(southEastPanels)
		self.addChildNode(southWestPanels)
		self.addChildNode(southPanels)
		self.addChildNode(westPanels)
		
		self.addChildNode(window)
		
		monitor = PanelMonitor()
		self.addChildNode(monitor)
	}
	
	func capsuleSetup()
	{		
		// Connect floors
		var i = 0
		while i < floorNode.count
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: floorNode[i],nodeB: lowMidNode[i],color:white))
			scene.rootNode.addChildNode(SCNLine(nodeA: lowMidNode[i],nodeB: lowGapNode[i],color:white))
			scene.rootNode.addChildNode(SCNLine(nodeA: lowGapNode[i],nodeB: highGapNode[i],color:white))
			scene.rootNode.addChildNode(SCNLine(nodeA: highGapNode[i],nodeB: highMidNode[i],color:white))
			scene.rootNode.addChildNode(SCNLine(nodeA: highMidNode[i],nodeB: ceilingNode[i],color:white))
			i += 1
		}
		
		// Connect Floor
		i = 0
		while i < floorNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: floorNode[i],nodeB: floorNode[i+1],color:white))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: floorNode[7],nodeB: floorNode[0],color:white))
		
		// Connect Window Low
		i = 0
		while i < lowMidNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: lowMidNode[i],nodeB: lowMidNode[i+1],color:white))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: lowMidNode[7],nodeB: lowMidNode[0],color:white))
		
		// Connect Low Gap
		i = 0
		while i < lowGapNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: lowGapNode[i],nodeB: lowGapNode[i+1],color:grey))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: lowGapNode[7],nodeB: lowGapNode[0],color:grey))
		
		// Connect Low
		i = 0
		while i < lowNode.count - 1
		{
			if i != 1 {
				scene.rootNode.addChildNode(SCNLine(nodeA: lowNode[i],nodeB: lowNode[i+1],color:white))
			}
			
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: lowNode[7],nodeB: lowNode[0],color:white))
		
		// Connect High
		i = 0
		while i < highNode.count - 1
		{
			if i != 1 {
				scene.rootNode.addChildNode(SCNLine(nodeA: highNode[i],nodeB: highNode[i+1],color:white))
			}
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: highNode[7],nodeB: highNode[0],color:white))
		
		// Connect High Gap
		i = 0
		while i < highGapNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: highGapNode[i],nodeB: highGapNode[i+1],color:grey))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: highGapNode[7],nodeB: highGapNode[0],color:grey))
		
		// Connect Window High
		i = 0
		while i < highMidNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: highMidNode[i],nodeB: highMidNode[i+1],color:white))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: highMidNode[7],nodeB: highMidNode[0],color:white))
		
		// Connect Ceiling
		i = 0
		while i < ceilingNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: ceilingNode[i],nodeB: ceilingNode[i+1],color:white))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: ceilingNode[7],nodeB: ceilingNode[0],color:white))
	}
	
	func capsuleMesh()
	{
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
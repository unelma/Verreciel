import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationStation : Location
{
	var requirement:Item!
	var installation:() -> Void
	var installationName:String!
	var port:SCNPortSlot!
	var button:SCNButton!
	
	init(name:String, system:Systems, at: CGPoint = CGPoint(), requirement:Item! = nil, installation:() -> Void, installationName:String, mapRequirement:Item! = nil)
	{
		self.installation = installation
		self.requirement = requirement
		self.installationName = installationName
		
		super.init(name:name,system:system, at:at)
		
		self.mapRequirement = mapRequirement
		self.note = ""
		structure = StructureStation()
		icon = IconStation()
		self.isComplete = false
	}
	
	var tradeLabel:SCNLabel!
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		let requirementLabel = SCNLabel(text:"Exchange \(requirement.name!)$install the \(installationName).")
		requirementLabel.position = SCNVector3(templates.leftMargin,templates.topMargin-0.3,0)
		newPanel.addChildNode(requirementLabel)
		
		button = SCNButton(host: self, text: "install", operation:1)
		button.position = SCNVector3(0,-1,0)
		newPanel.addChildNode(button)
		
		port = SCNPortSlot(host: self)
		port.position = SCNVector3(0,-0.2,0)
		newPanel.addChildNode(port)
		
		tradeLabel = SCNLabel(text:"trade", color:grey, align:alignment.right)
		tradeLabel.position = SCNVector3(-0.3,0,0)
		port.addChildNode(tradeLabel)
		
		button.disable("install")
		port.enable()
		
		return newPanel
	}
	
	override func onUploadComplete()
	{
		if port.hasEvent() == false { tradeLabel.update(grey) ; return }
		
		let trade = port.event as! Item
		if trade.name == self.requirement.name && trade.type == self.requirement.type { button.enable("install") ; tradeLabel.update(cyan) }
		else{ tradeLabel.update(red) }
	}
	
	override func touch(id: Int)
	{
		super.touch(id)
		if id == 1 { self.installation() ; self.complete()  }
	}
	
	override func complete()
	{
		super.complete()
		
		structure.onComplete()
		intercom.complete()
	}
	
	override func details() -> String
	{
		return "\(installationName)"
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconStation : Icon
{
	override init()
	{
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
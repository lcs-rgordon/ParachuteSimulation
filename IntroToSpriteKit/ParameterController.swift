//
//  ParameterController.swift
//  IntroToSpriteKit
//
//  Created by William Chan on 2020-06-05.
//  Copyright © 2020 Russell Gordon. All rights reserved.
//
import Cocoa
import SpriteKit
import GameplayKit

class ParameterController: NSViewController {
    
    // MARK: Properties & Outlets
    @IBOutlet weak var labelHeight: NSTextField!
    @IBOutlet weak var sliderHeight: NSSlider!
    @IBOutlet weak var labelParachuteHeight: NSTextField!
    @IBOutlet weak var sliderParachuteHeight: NSSlider!
    @IBOutlet weak var labelMass: NSTextField!
    @IBOutlet weak var sliderMass: NSSlider!
    
    
    // MARK: Methods
    
    
    // This method runs once when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // All the customization happens below...
        labelHeight.stringValue = String(sliderHeight.stringValue)
        labelParachuteHeight.stringValue = String(sliderParachuteHeight.stringValue)
        labelMass.stringValue = String(sliderMass.stringValue)
        
    }
    
    // Method is called right before the segue happen
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        
        // When the next window is the animation, pass certain pieces of information forward
        if let nextWindowController = segue.destinationController as? ViewController {
            
            // Pass the simulation parameters onward
            nextWindowController.height = labelHeight.doubleValue
            nextWindowController.parachuteOpensAtHeight = labelParachuteHeight.doubleValue
            nextWindowController.mass = labelMass.doubleValue
            
        }
        
        
    }
    
    // This function gets invoked when the slider's value changes
    @IBAction func sliderHeightValueChanged(_ sender: NSSlider) {
        
        // DEBUG: What value was selected?
        print(sender.integerValue)
        
        // Update the label to show what height has been selected
        labelHeight.stringValue = String(sender.integerValue)
        
        // The maximum parachute height should never be higher than the initial height
//        print("Initial height is \(sender.integerValue)")
//        print("Parachute height is \(sliderParachuteHeight.integerValue)")
        sliderParachuteHeight.maxValue = sender.doubleValue
        labelParachuteHeight.stringValue = String(sender.integerValue)
        
        
    }
    
    @IBAction func sliderParachuteHeightValueChanged(_ sender: NSSlider) {
        
        // DEBUG: What value was selected?
        print(sender.integerValue)
        
        // Update the label to show what height has been selected
        labelParachuteHeight.stringValue = String(sender.integerValue)
    }
    @IBAction func sliderMassValueChanged(_ sender: NSSlider) {
        
        // DEBUG: What value was selected?
        print(sender.integerValue)
        
        // Update the label to show what height has been selected
        labelMass.stringValue = String(sender.integerValue)
    }
    
    
    
}

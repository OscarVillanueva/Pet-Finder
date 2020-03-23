//
//  Theme.swift
//  Pet-Finder
//
//  Created by Oscar Villanueva on 21/03/20.
//  Copyright © 2020 Oscar Villanueva. All rights reserved.
//

// Cambiar temas del usuario
import UIKit

enum Theme: Int {
    // Temas que utilizaremos en la app
    case `default`, dark, graphical

    // Creamos la llave el thema seleccionado
    private enum Keys {
        static let selectedTheme = "SelectedTheme"
    }

    // Recuperamos el valor seleccionado el userDefaults
    static var current: Theme {
        let storedTheme = UserDefaults.standard.integer(forKey: Keys.selectedTheme)
        return Theme(rawValue: storedTheme) ?? .default
    }

    //  Generamos el color
    var mainColor: UIColor {
        
        switch self {
            
            case .default:
                return UIColor(red: 85.0/255.0, green: 190.0/255.0, blue: 98.0/255, alpha: 1.0)
                
            case .dark:
                return UIColor(red: 255.0/255.0, green: 115.0/255.0, blue: 50.0/255, alpha: 1.0)
                
            case .graphical:
                return UIColor(red: 14.0/255.0, green: 14.0/255.0, blue: 14.0/255, alpha: 1.0)
            
        }
        
    }
    
    var barStyle: UIBarStyle {
        
        switch self {
            
            case .default, .graphical:
                return .default
                
            case .dark:
                return .black
            
        }
        
    }
    
    var navigationBackgroundImage: UIImage? {
        
        return (self == .graphical) ? UIImage(named: "navBackground") : nil
        
    }
    
    var tabBarBackgroundImage : UIImage? {
        
        return (self == .graphical) ? UIImage(named: "tabBarBackground") : nil
        
    }
    
    var backgorundCellColor: UIColor {
        
        switch self {
            
            case .default, .graphical:
                return UIColor.white
                
            case .dark:
                return UIColor(white: 0.4, alpha: 1.0)
            
        }

    }
    
    var textCellColor: UIColor {
        
        switch self {
            
            case .default, .graphical:
                return UIColor.black
                
            case .dark:
                return UIColor.white
            
        }
        
    }
    
    // Guardamos y aplicamos los cambios a la vista
    func apply(){
        
        // Configuración global
        UserDefaults.standard.set(rawValue, forKey: Keys.selectedTheme)
        UserDefaults.standard.synchronize()
        
        UIApplication.shared.delegate?.window??.tintColor = mainColor
        UINavigationBar.appearance().tintColor = mainColor
        UIButton.appearance().tintColor = mainColor
                
        // UINavigationBar
        UINavigationBar.appearance().barStyle = barStyle
        UINavigationBar.appearance().setBackgroundImage(navigationBackgroundImage, for: .default)
        
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
        
        // UITabBar
        UITabBar.appearance().barStyle = barStyle
        UITabBar.appearance().backgroundImage = tabBarBackgroundImage
        UITabBar.appearance().tintColor = mainColor
        
        let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.withRenderingMode(.alwaysTemplate)
        let tabResizableIndicator = tabIndicator?.resizableImage(withCapInsets:
            UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
        UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator
        
        // UISegmentedControl
        //let controlBackground = UIImage(named: "controlBackground")?
            //.withRenderingMode(.alwaysTemplate)
            //.resizableImage(withCapInsets: UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0))
        
       // let selectedControlBackground = UIImage(named: "controlSelectedBackground")?
            //.withRenderingMode(.alwaysTemplate)
            //.resizableImage(withCapInsets: UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0))
        
        //UISegmentedControl.appearance().setBackgroundImage(controlBackground, for: .normal, barMetrics: .default)
        //UISegmentedControl.appearance().setBackgroundImage(selectedControlBackground, for: .selected, barMetrics: .default)
        
        // UIStepper
        // UIStepper.appearance().setBackgroundImage(controlBackgroundcontrol, for: .normal)
        // UIStepper.appearance().setBackgroundImage(controlBackgroundcontrol, for: .disabled)
        // UIStepper.appearance().setBackgroundImage(controlBackgroundcontrol, for: .highlighted)
        
        UIStepper.appearance().setDecrementImage(UIImage(named: "fewerPaws"), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(named: "morePaws"), for: .normal)
        
        // UISlider
        UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
        
        UISlider.appearance().setMinimumTrackImage(
            UIImage(named: "minimumTrack")?
                .withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 0.0, left: 6.0, bottom: 0, right: 0)),
                                                   for: .normal)
        
        UISlider.appearance().setMaximumTrackImage(UIImage(named: "maximumTrack")?
            .resizableImage(withCapInsets: UIEdgeInsets(top: 0.0, left: 0, bottom: 0, right: 6.0)),
                                                   for: .normal)
        
        // UISwith
        UISwitch.appearance().onTintColor = mainColor.withAlphaComponent(0.4)
        UISwitch.appearance().thumbTintColor = mainColor
        
        // UITableViewCell
        UITableViewCell.appearance().backgroundColor = backgorundCellColor
        UITableView.appearance().backgroundColor = backgorundCellColor
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = textCellColor
    }
}

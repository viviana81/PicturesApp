//
//  UISearchBar.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 19/01/21.
//

import UIKit

extension UISearchBar {

      var textColor: UIColor? {
          get {
              if let textField = self.value(forKey: "searchField") as?
  UITextField {
                  return textField.textColor
              } else {
                  return nil
              }
          }

          set (newValue) {
              if let textField = self.value(forKey: "searchField") as?
  UITextField {
                  textField.textColor = newValue
              }
          }
      }
  }

//
//  PickerView+Picker.swift
//  AmadaMachines
//
//  Created by IT Support on 11/5/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension PickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return models.count
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 250
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedModel = self.models[row]
        self.field.text = selectedModel.description
        self.selectedModel = selectedModel

        guard let delegate = delegate else { return }
        let pickerViewModel = models[row]
        delegate.pickerViewRowSelected(pickerView, row: row, inComponent: component, pickerViewModel: pickerViewModel)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return models[row].description
    }

    func initPicker() {
        self.picker.delegate = self
        self.picker.dataSource = self
    }
}

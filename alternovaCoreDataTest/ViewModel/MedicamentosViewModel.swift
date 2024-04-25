//
//  MedicamentosViewModel.swift
//  alternovaCoreDataTest
//
//  Created by Sergio Luis Noriega Pita on 24/04/24.
//

import Foundation
import CoreData
import SwiftUI
import Combine

//Por medicamento se muestra el nombre, la dosis y los horarios en los que el usuario
//debería tomarlos

class MedicamentosViewModel: ObservableObject {
    @Published var nombre: String = ""
//    @Published var dosis: Int = 0
    @Published var dosis: String = ""
    @Published var horario = Date()
//    @Published var horario : String = ""
    @Published var show = false
    @Published var updateItem : Medicamentos! // Optional Binding
    
    
    //CoreData
    
    func saveData(context: NSManagedObjectContext){
        let newMedicamento = Medicamentos(context: context)
        newMedicamento.nombreMedicamento = nombre
        //newMedicamento.dosis = Int16(dosis)
        newMedicamento.dosis = dosis
        newMedicamento.fecha = horario
        
        do {
            try context.save()
            debugPrint("Guardo Exitosamente ")
            show.toggle()
        } catch let error as NSError {
            // Alert para informar
            debugPrint("No se Guardo el medicamnento, \(error.localizedDescription)")
        }
        
    }
    
    func deleteMedicamento(item:Medicamentos, context: NSManagedObjectContext){
        context.delete(item)
//        try! context.save()
        do {
            try context.save()
            debugPrint("Elimino Exitosamente")
        }  catch let error as NSError {
            debugPrint("No se Elimino el medicamnento, \(error.localizedDescription)")
        }
    }
    
    func sendData(item:Medicamentos){
        updateItem = item
        nombre = item.nombreMedicamento ?? ""
        //dosis = Int(item.dosis ?? 0)
        dosis = item.dosis ?? ""
        horario = item.fecha ?? Date()
        show.toggle()
    }
    
    func editMedicamento(context: NSManagedObjectContext) {
        updateItem.fecha = horario
        updateItem.nombreMedicamento = nombre
        updateItem.dosis = dosis
        do {
            debugPrint("Edito Exitosamente")
            show.toggle()
        } catch let error as NSError {
            debugPrint("No se Edito el medicamnento, \(error.localizedDescription)")
        }
    }
    
    func reset() {
        // Aquí reinicias el estado del modelo, por ejemplo:
        nombre = ""
        dosis = ""
        horario = Date()
    }
    
}

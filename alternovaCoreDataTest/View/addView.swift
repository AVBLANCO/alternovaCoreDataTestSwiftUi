//
//  addView.swift
//  alternovaCoreDataTest
//
//  Created by Sergio Luis Noriega Pita on 24/04/24.
//

import SwiftUI



struct addView: View {
    @ObservedObject var model : MedicamentosViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            Text(model.updateItem != nil ? "Editar Medicamento" : "Agregar Medicamento")
                .font(.largeTitle)
                .bold()
            Spacer()
            TextEditor(text: $model.nombre)
            Divider()
            TextEditor(text: $model.dosis)
            Divider()
            DatePicker("Seleccionar Fecha", selection: $model.horario)
            Spacer()
            Button(action: {
                // Save en core Data
                if model.updateItem != nil {
                    model.editMedicamento(context: context)
                } else {
                    //model.reset()
                    model.saveData(context: context)
                }
            }){
                Label(
                    title: { Text("Guardar").foregroundColor(.white).bold() },
                    icon: { Image(systemName: "plus").foregroundColor(.white) }
                )
            }.padding()
                .frame(width: UIScreen.main.bounds.width - 30)
//                .background(Color.blue)
                .background(model.nombre == "" ? Color.gray : Color.blue)
                .cornerRadius(8)
                .disabled(model.nombre == "" ? true : false)
        }.padding()
    }
}


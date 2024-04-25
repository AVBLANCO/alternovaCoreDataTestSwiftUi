//
//  Home.swift
//  alternovaCoreDataTest
//
//  Created by Sergio Luis Noriega Pita on 24/04/24.
//

import SwiftUI

struct Home: View {
    @StateObject var model = MedicamentosViewModel()
    var titleView: String = "Medicamentos"
    @FetchRequest(entity: Medicamentos.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring()) var results : FetchedResults<Medicamentos>
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        NavigationView{
            // Title View
            List{
                //
                ForEach(results){ item in
                    VStack(alignment: .leading){
                        Text(item.nombreMedicamento ?? "Sin Medicamentos")
                            .font(.title)
                            .bold()
                        Text(item.dosis ?? "0")
                            .font(.title3)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }.contextMenu(ContextMenu(menuItems: {
                        // Acccion para Editar
                        Button(action: {
                            debugPrint("Editar")
                            model.sendData(item: item)
                        }){ Label(title:{
                            Text("Editar")
                        }, icon: {
                            Image(systemName: "pencil")
                        })
                        }
                        // Acccion para Eliminar
                        Button(action: {
                            debugPrint("Eliminar")
                            model.deleteMedicamento(item: item, context: context)
                        }){ Label(title:{
                            Text("Eliminar")
                        }, icon: {
                            Image(systemName: "trash")
                        })
                        }
                    }))
                }
            }.navigationBarTitle(titleView)
                .navigationBarItems(trailing:
                                        Button(action: {
                    if model.updateItem == nil {
                        model.reset()
                    }
                    model.show.toggle()
                }){
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                ).sheet(isPresented: $model.show , content: {
                    addView(model: model)
                })
        }
    }
}


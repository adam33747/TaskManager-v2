//
//  DetailView.swift
//  TaskManager
//
//  Created by Adam Hu on 2/2/20.
//  Copyright © 2020 Adam Hu. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
   @State private var showingEditScreen = false
    @State private var showingLoadingScreen = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    //@FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.urgency, ascending: true), NSSortDescriptor(keyPath: \Task.due, ascending: true)]) var tasks: FetchedResults<Task>
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.urgency, ascending: true), NSSortDescriptor(keyPath: \Task.due, ascending: true)]) var tasks: FetchedResults<Task>
@State private var showingAlert = false
    @ObservedObject var task: Task
    var body: some View {
        
        List {
            Text("\(self.task.title ?? "")").font(.system(size: 36, design: .rounded))
                .fontWeight(.bold)
            if self.task.urgency == "   Very important   " {
                   Text("  Very Important  ")
                    .fontWeight(.bold)
                        .padding(1.5)
                    .background(Color.red)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                }
                
            if self.task.urgency == "  Important  " {
                   Text("  Important  ")
                    .fontWeight(.bold)
                        .padding(1.5)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                    //.font(.caption)
                }
            if self.task.urgency == " Not important " {
                    Text("  Not Important  ")
                    .fontWeight(.bold)
                        .padding(1.5)
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                }
            if self.task.urgency == "Optional" {
                    Text("  Optional  ")
                    .fontWeight(.bold)
                        .padding(1.5)
                    .background(Color.green)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                    //.font(.caption)
                }
            if self.task.desc == "" {
                Text("No description")
            } else {
                Text("\(self.task.desc ?? "")")
            }
            Text("\(self.task.due ?? Date())")
            Section {
           Button(action: {self.showingEditScreen.toggle()}) {
            Text(" Edit ").font(.system(size: 17, design: .rounded))
            .bold()
            
           }.buttonStyle(EditStyle())
            .sheet(isPresented: $showingEditScreen) {
                EditTaskView(task: self.task).environment(\.managedObjectContext, self.moc)
                }
                Button(action:{
                self.showingAlert = true
            }){
                Text("Delete task").foregroundColor(.red).font(.system(size: 17, design: .rounded))
                .bold()
                .alert(isPresented:self.$showingAlert) {
                Alert(title: Text("Are you sure you want to delete this task?"), message: Text("You cannnot undo this action"), primaryButton: .destructive(Text("Delete")) {
                    self.moc.delete(self.task)
                    self.presentationMode.wrappedValue.dismiss()
                        do{
                            try self.moc.save()
                        }catch{
                            print(error)
                        }
                }, secondaryButton: .cancel())
                }
            }
        }
            
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let task = Task(context: moc)
        task.title = "Test title"
        task.desc  = "Test Desc"
        task.urgency = "Optional"
        return NavigationView {
            DetailView(task: task)
        }
    }

}
}

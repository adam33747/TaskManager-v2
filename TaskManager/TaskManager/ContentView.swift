//
//  ContentView.swift
//  TaskManager
//
//  Created by Adam Hu on 1/8/20.
//  Copyright © 2020 Adam Hu. All rights reserved.
//

import SwiftUI
import UIKit

struct GradientBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(2)
            .padding(.horizontal, 10)
            .foregroundColor(.white)
            .font(.headline)
            .font(.system(size: 17, design: .rounded))
        
            .background(LinearGradient(gradient: Gradient(colors: [.blue, .blue]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
        .scaleEffect(configuration.isPressed ? 0.7 : 1.0)
    }
}
struct EditStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(2)
            .padding(.horizontal, 20)
            .foregroundColor(.white)
            .font(.headline)
            .font(.system(size: 17, design: .rounded))
        
            .background(LinearGradient(gradient: Gradient(colors: [.blue, .blue]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
        .scaleEffect(configuration.isPressed ? 0.7 : 1.0)
    }
}
struct SaveButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .font(.system(size: 17, design: .rounded))
      
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [.blue, .blue]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 15)
        .scaleEffect(configuration.isPressed ? 0.7 : 1.0)
    }
}
struct ContentView: View {
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    @Environment(\.managedObjectContext) var moc
   
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.urgency, ascending: true), NSSortDescriptor(keyPath: \Task.due, ascending: true)]) var tasks: FetchedResults<Task>
    @State var isEditing = false
    @State private var showingAlert = false
    @State private var showingAddScreen = false
   // var i = 0
    @State var timeRemaining = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
     @State private var showDetails = false
     var body: some View {
        //VStack {
            /*if showDetails == false {
                ZStack {
                    //LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom)
                    
        Loading2()
        .frame(width: 300, height: 300)
            .onReceive(self.timer) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
                if self.timeRemaining == 0 {
                    self.showDetails.toggle()
                }
            }
                    
                }
                .edgesIgnoringSafeArea(.all)
            }*/
        //if showDetails {
            NavigationView{
                
                List {
                   //Section(header: Text("  ")) {
                    
                    Section {
                          ForEach(tasks, id: \.self) { task in
                            NavigationLink(destination: DetailView(task: task)){
                                TaskView(title: task.title ?? "Unknown Title", urgency: "\(task.urgency ?? "Optional" )", due: task.due ?? Date(), index: task.index )
                            }
                          }.onDelete {indexSet in
                            let deleteItem = self.tasks[indexSet.first!]
                                self.moc.delete(deleteItem)
                                do{
                                    try self.moc.save()
                                }catch{
                                    print(error)
                                }
                            }
                    }
                }
                .navigationBarTitle(Text("Tasks").font(.system(size: 36, design: .rounded)))//.font(.system(design: .rounded))
                    .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                .navigationBarItems(leading: Button(action: { self.isEditing.toggle() }){
                    Text(isEditing ? " Done " : " Edit ")
                        .font(.system(size: 17, design: .rounded)).bold()
                }.buttonStyle(GradientBackgroundStyle()),
                        trailing: Button(action: {self.showingAddScreen.toggle()}) {
                            Text(" Add ").font(.system(size: 17, design: .rounded)).bold()}.buttonStyle(GradientBackgroundStyle()))
                      .sheet(isPresented: $showingAddScreen) {
                          AddTaskView().environment(\.managedObjectContext, self.moc)
            }
               
        }.navigationViewStyle(StackNavigationViewStyle())
        }
        
   // }
  //  }
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

}

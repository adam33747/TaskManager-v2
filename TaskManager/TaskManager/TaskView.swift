//
//  TaskView.swift
//  TaskManager
//
//  Created by Adam Hu on 1/8/20.
//  Copyright © 2020 Adam Hu. All rights reserved.
//

import SwiftUI

struct TaskView: View {
    var title:String = ""
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    var urgency:String = ""
    var due:Date = Date()
    var index:Int16 = 0
    @State private var showingAlert = false
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                .foregroundColor(.primary)
                .accessibility(addTraits: .isHeader)
                  Text("\(due, formatter: TaskView.taskDateFormat)")
                   // .font(.body)
                    .foregroundColor(.secondary)
                    .font(.caption)
                    
                    .fixedSize(horizontal: false, vertical: true)
                    
                
                }
                //Text("\(index)")
                if self.urgency == "   Very important   " {
                   Text("  Very Important  ")
                    .fontWeight(.semibold)
                        .padding(1.5)
                    .background(Color.red)
                    .cornerRadius(10)
                    .foregroundColor(Color("white"))
                    .font(.system(size: 13, design: .rounded))
                }
                
                if self.urgency == "  Important  " {
                   Text("  Important  ")
                    .fontWeight(.semibold)
                        .padding(1.5)
                    .background(Color.orange)
                    
                    .cornerRadius(10)
                    .foregroundColor(Color("white"))
                    .font(.system(size: 13, design: .rounded))
                }
                if self.urgency == " Not important " {
                    Text("  Not Important  ")
                    .fontWeight(.semibold)
                        
                        .padding(1.5)
                    .background(Color.yellow)
                    .cornerRadius(10)
                        .foregroundColor(Color("white"))
                        .font(.system(size: 13, design: .rounded))
                }
            
                if self.urgency == "Optional" {
                    Text("  Optional  ")
                    .fontWeight(.semibold)
                        .padding(1.5)
                    .background(Color.green)
                    .cornerRadius(10)
                    .foregroundColor(Color("white"))
                    .font(.system(size: 13, design: .rounded))
                }
                //Text("\(due, formatter: TaskView.taskDateFormat)").fontWeight(.light)
                
                
                
            }
        }
        
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}

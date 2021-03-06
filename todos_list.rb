require "date"

class Todo
    def initialize(text, due_date, completed)
      @text = text
      @due_date = due_date
      @completed = completed
        
    end    

    def overdue?
      Date.today > @due_date
    end

    def due_today?
      Date.today == @due_date
    end

    def due_later?
      Date.today < @due_date
    end

    def to_displayable_string   
      if @completed==false
        puts ('[ ]' + '  ' + @text.to_s + '  ' + @due_date.to_s)
      else
        puts ('[X]' + '  ' + @text.to_s + '  ' + @due_date.to_s) 
      end
    end
end

class TodosList
    def initialize(todos)
      @todos = todos
    end

    def overdue
      TodosList.new(@todos.filter { |todo| todo.overdue? })
    end 

    def due_later
      TodosList.new(@todos.filter { |todo| todo.due_later? })
    end

    def due_today
      TodosList.new(@todos.filter { |todo| todo.due_today? })
    end

    def to_displayable_list
      #TodosList.new(@todos.map { |todo| todo.to_displayable_string})
      @todos.map { |todo| todo.to_displayable_string}
    end
   

end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
  { text: "Service vehicle.", due_date: date, completed: false },
]

todos = todos.map { |todo|
    Todo.new(todo[:text], todo[:due_date], todo[:completed])
}
todos_list = TodosList.new(todos)

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
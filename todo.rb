require 'csv'
require 'byebug'

class Todolist
    attr_accessor :list, :task

    def initialize(file)
        @list = []
        CSV.foreach(file) do |row|
            unless row[0] == "id"
                @list << Task.new(row)
            end
        end
    end

    def list_task
        # list1 = CSV.read('todolists.csv')
        @list.each do |task|
            puts "1." + task.task
        end
    end

    def add(new_task)
        add_array = []
        add_array << new_task
        @list << Task.new(add_array)
        save
    end

    def save
        CSV.open('todo.csv', "w+") do |csv|
        @list.each do |task|
         csv << task.task
        end
       end
    end

    def delete(id)
        @list.each_with_index do |row, index|
        
            if index+1 == id
              @list.delete_at(index)
            end
            save
        end
    end

    def update(completed)

        if @task == completed
           print "@{task} -------1"
        else
           print "@{task} -------0"
        end
    end
end

class Task
    attr_accessor :task
    def initialize(task)
        @task = task
    end
end

todo = Todolist.new('todo.csv')


input = ARGV[0]

input2 = ARGV[1..-1].join(" ")

case input
when 'list'
todo.list_task
when 'add'
todo.add(input2)
todo.list
when 'delete'
todo.delete(input2.to_i)
todo.list
when 'update'
todo.update(input2)
todo.list

else
puts "Sorry, this is doesn't on the lists"
end
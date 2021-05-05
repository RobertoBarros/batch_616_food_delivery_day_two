class OrdersView
  def ask_index
    puts 'Enter your selection:'
    gets.chomp.to_i - 1
  end

  def display_employee(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username}"
    end
  end

  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - Meal: #{order.meal.name} - Customer: #{order.customer.name} - Delivered by #{order.employee.username}"
    end
  end

end

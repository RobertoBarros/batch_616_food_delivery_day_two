require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository

    @view = OrdersView.new
  end

  def add
    # 1. Listar os meals
    meals = @meal_repository.all
    MealsView.new.display(meals)

    # 2. Pegar o meal escolhido pelo manager
    index = @view.ask_index
    meal = @meal_repository.all[index]

    # 3. Listar os customers
    customers = @customer_repository.all
    CustomersView.new.display(customers)

    # 4. Pegar o customer escolhido pelo manager
    index = @view.ask_index
    customer = @customer_repository.all[index]


    # 5. Listar todos os employee do tipo rider
    riders = @employee_repository.all_riders
    @view.display_employee(riders)

    # 6. pegar o employee escolhido pelo manager
    index = @view.ask_index
    employee = @employee_repository.all_riders[index]

    # 7. Instanciar a order
    order = Order.new(meal: meal, customer: customer, employee: employee)

    # 8. Adicionar a order ao repository
    @order_repository.create(order)
  end

  def list_undelivered_orders
    undelivereds = @order_repository.undelivered_orders
    @view.display(undelivereds)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee.id == employee.id }
    @view.display(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee.id == employee.id }
    @view.display(orders)

    index = @view.ask_index

    order = orders[index]

    order.deliver!

    @order_repository.save_csv
  end
end

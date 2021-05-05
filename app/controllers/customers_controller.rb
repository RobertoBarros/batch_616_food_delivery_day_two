require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomersView.new
  end

  def add
    # 1. Perguntar o nome do customer para o usuario
    name = @view.ask_name
    # 2. Perguntar o endereco do customer para o usuario
    address = @view.ask_address

    # 3. Criar uma instancia de customer
    customer = Customer.new(name: name, address: address)

    # 4. Adicionar a instancia de customer ao repositorio
    @customer_repository.create(customer)
  end


  def list
    # 1. recuperar todos os customers
    customers = @customer_repository.all
    # 2. exibir os customers para o usuario
    @view.display(customers)
  end
end

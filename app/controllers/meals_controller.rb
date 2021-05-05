require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealsView.new
  end

  def add
    # 1. Perguntar o nome do meal para o usuario
    name = @view.ask_name
    # 2. Perguntar o preco do meal para o usuario
    price = @view.ask_price

    # 3. Criar uma instancia de meal
    meal = Meal.new(name: name, price: price)

    # 4. Adicionar a instancia de meal ao repositorio
    @meal_repository.create(meal)
  end


  def list
    # 1. recuperar todos os meals
    meals = @meal_repository.all
    # 2. exibir os meals para o usuario
    @view.display(meals)
  end
end

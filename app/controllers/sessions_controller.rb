require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  # Retorna o employee logado
  def login
    username = @view.ask_username
    password = @view.ask_password

    employee = @employee_repository.find_by_username(username)

    if employee && employee.password == password
      # employee existe e o password está correto
      @view.welcome
      return employee
    else
      # employee com username não existe ou password incorreto
      @view.wrong_credentials
      login
    end
  end
end

require_relative '../models/employee'

class EmployeeRepository
  CSV_OPTIONS = { headers: :first_row, header_converters: :symbol }

  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    load_csv if File.exist?(@csv_file)
  end

  def all
    @employees
  end

  def find(id)
    @employees.select { |employee| employee.id == id }.first
  end

  def find_by_username(username)
    @employees.select { |employee| employee.username == username }.first
  end

  def all_riders
    @employees.select { |employee| employee.rider? }
  end

  private

  def load_csv
    CSV.foreach(@csv_file, CSV_OPTIONS) do |row|
      id = row[:id].to_i
      username = row[:username]
      password = row[:password]
      role = row[:role]

      employee = Employee.new(id: id, username: username, password: password, role: role)

      @employees << employee
    end
  end

end

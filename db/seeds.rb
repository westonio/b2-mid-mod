# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
EmployeeTicket.destroy_all
Employee.destroy_all
Ticket.destroy_all
Department.destroy_all

  @cx = Department.create!(name: 'CX', floor: "Third" )
  @michael = @cx.employees.create!(name: 'Michael', level: 2)
  @emily = @cx.employees.create!(name: 'Emily', level: 5)

  @ticket1 = Ticket.create!(subject: 'Update profile bug', age: 28)
  @ticket2 = Ticket.create!(subject: 'Infinitie Loop', age: 21)
  @ticket3 = Ticket.create!(subject: 'Page not loading', age: 14)
  @ticket4 = Ticket.create!(subject: 'view on mobile broken', age: 19)

  @employee_ticket1 = EmployeeTicket.create!(employee_id: @michael.id, ticket_id: @ticket1.id)
  @employee_ticket2 = EmployeeTicket.create!(employee_id: @michael.id, ticket_id: @ticket2.id)
  @employee_ticket3 = EmployeeTicket.create!(employee_id: @michael.id, ticket_id: @ticket3.id)
  @employee_ticket4 = EmployeeTicket.create!(employee_id: @emily.id, ticket_id: @ticket3.id) # shares ticket with michael
  @employee_ticket5 = EmployeeTicket.create!(employee_id: @emily.id, ticket_id: @ticket4.id)
    
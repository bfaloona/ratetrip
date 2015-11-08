driver = Driver.new(
    name: 'Wade Hudson',
    permit_number: 'ABC1',
)
if driver.valid?
  driver.save
else
  driver.errors.full_messages.each { |m| puts "   - #{m}" }
  raise 'Error creating driver'
end

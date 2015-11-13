Ratetrip::App.controllers :driver do

  get :show, map: '/driver/:permit_number' do
    driver = Driver.where(permit_number: params[:permit_number])[0] rescue( halt 500, "Error! Could not look up driver for permit_number #{params[:permit_number]}" )
    @title = "Rate This Ride"
    @driver = driver

    render 'driver/show', layout: :application
  end

end

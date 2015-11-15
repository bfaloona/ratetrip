Rateride::App.controllers :rating do

  get :index do
    all_ratings = Rating.all.order('quality DESC, created_at DESC')
    @ratings = all_ratings.take(5)
    @result_summary = "#{@ratings.count} ratings"
    @title = 'Recent Ratings'
    render 'rating/index'
  end

  get :new, map: '/:permit_number' do
    driver = Driver.where(permit_number: params[:permit_number])[0] rescue( halt 500, "Error! Could not look up driver for permit_number #{params[:permit_number]}" )
    if driver.nil?
      render 'errors/400'
    else
      @title = "Rate This Ride"
      @permit_number = driver.permit_number
      @driver = driver
      render 'rating/new', layout: :application
    end
  end

  post :create, csrf_protection: false   do
    driver = Driver.where(permit_number: params[:permit_number])[0]
    @rating = Rating.new( {
      driver_id: driver.id,
      quality: params[:quality],
      comments: params[:comments],
      status_id: 1
    })

    if @rating.valid?
      @rating.save
    else
      @rating.errors.full_messages.each { |m| puts "   - #{m}" }
      raise 'Error creating rating'
    end

    deliver( :rating, :notify, driver, @rating.quality, @rating.comments)
    @rating.delivered = true
    @rating.save

    @title = 'Rating Complete!'

    render 'rating/thanks', layout: :application
  end



end

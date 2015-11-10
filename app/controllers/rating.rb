Ratetrip::App.controllers :rating do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
  get :index do
    all_ratings = Rating.all.order('created_at DESC')
    @ratings = all_ratings.take(50)
    @result_summary = "#{@ratings.count} of #{all_ratings.count} ratings"
    @title = 'RateTrip ratings'
    render 'rating/index'
  end

  get :new, map: '/:permit_number' do
    driver = Driver.where(permit_number: params[:permit_number])[0] rescue( halt 500, "Error" )
    @title = "Rate This Trip"
    @permit_number = params[:permit_number]
    render 'rating/new', layout: :application
  end

  post :create  do
    driver = Driver.where(permit_number: params[:permit_number])[0] rescue( halt 500, "Error" )
    @rating = Rating.new( {
      driver_id: driver.id,
      quality: params[:quality],
      comments: params[:comments],
      suggestions: params[:suggestions]
    })

    if @rating.valid?
      @rating.save
    else
      @rating.errors.full_messages.each { |m| puts "   - #{m}" }
      raise 'Error creating rating'
    end

    deliver( :rating, :notify, driver.name, @rating.quality, @rating.comments, @rating.suggestions)
    @rating.delivered = true
    @rating.save

    redirect '/rating'
  end



end

Ratetrip::Admin.controllers :drivers do
  get :index do
    @title = "Drivers"
    @drivers = Driver.all
    render 'drivers/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'driver')
    @driver = Driver.new
    render 'drivers/new'
  end

  post :create do
    @driver = Driver.new(params[:driver])
    if @driver.save
      @title = pat(:create_title, :model => "driver #{@driver.id}")
      flash[:success] = pat(:create_success, :model => 'Driver')
      params[:save_and_continue] ? redirect(url(:drivers, :index)) : redirect(url(:drivers, :edit, :id => @driver.id))
    else
      @title = pat(:create_title, :model => 'driver')
      flash.now[:error] = pat(:create_error, :model => 'driver')
      render 'drivers/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "driver #{params[:id]}")
    @driver = Driver.find(params[:id])
    if @driver
      render 'drivers/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'driver', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "driver #{params[:id]}")
    @driver = Driver.find(params[:id])
    if @driver
      if @driver.update_attributes(params[:driver])
        flash[:success] = pat(:update_success, :model => 'Driver', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:drivers, :index)) :
          redirect(url(:drivers, :edit, :id => @driver.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'driver')
        render 'drivers/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'driver', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Drivers"
    driver = Driver.find(params[:id])
    if driver
      if driver.destroy
        flash[:success] = pat(:delete_success, :model => 'Driver', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'driver')
      end
      redirect url(:drivers, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'driver', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Drivers"
    unless params[:driver_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'driver')
      redirect(url(:drivers, :index))
    end
    ids = params[:driver_ids].split(',').map(&:strip)
    drivers = Driver.find(ids)
    
    if Driver.destroy drivers
    
      flash[:success] = pat(:destroy_many_success, :model => 'Drivers', :ids => "#{ids.to_sentence}")
    end
    redirect url(:drivers, :index)
  end
end

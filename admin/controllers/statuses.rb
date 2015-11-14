Rateride::Admin.controllers :statuses do
  get :index do
    @title = "Statuses"
    @statuses = Status.all
    render 'statuses/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'status')
    @status = Status.new
    render 'statuses/new'
  end

  post :create do
    @status = Status.new(params[:status])
    if @status.save
      @title = pat(:create_title, :model => "status #{@status.id}")
      flash[:success] = pat(:create_success, :model => 'Status')
      params[:save_and_continue] ? redirect(url(:statuses, :index)) : redirect(url(:statuses, :edit, :id => @status.id))
    else
      @title = pat(:create_title, :model => 'status')
      flash.now[:error] = pat(:create_error, :model => 'status')
      render 'statuses/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "status #{params[:id]}")
    @status = Status.find(params[:id])
    if @status
      render 'statuses/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'status', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "status #{params[:id]}")
    @status = Status.find(params[:id])
    if @status
      if @status.update_attributes(params[:status])
        flash[:success] = pat(:update_success, :model => 'Status', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:statuses, :index)) :
          redirect(url(:statuses, :edit, :id => @status.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'status')
        render 'statuses/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'status', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Statuses"
    status = Status.find(params[:id])
    if status
      if status.destroy
        flash[:success] = pat(:delete_success, :model => 'Status', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'status')
      end
      redirect url(:statuses, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'status', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Statuses"
    unless params[:status_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'status')
      redirect(url(:statuses, :index))
    end
    ids = params[:status_ids].split(',').map(&:strip)
    statuses = Status.find(ids)
    
    if Status.destroy statuses
    
      flash[:success] = pat(:destroy_many_success, :model => 'Statuses', :ids => "#{ids.to_sentence}")
    end
    redirect url(:statuses, :index)
  end
end

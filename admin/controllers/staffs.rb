Econaider::Admin.controllers :staffs do
  get :index do
    @title = "Staffs"
    @staffs = Staff.all
    render 'staffs/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'staff')
    @lines = Line.all.map{|cat| [cat.name, cat.id]}
    @staff = Staff.new
    render 'staffs/new'
  end

  post :create do
    @staff = Staff.new(params[:staff])
    if @staff.save
      @title = pat(:create_title, :model => "staff #{@staff.id}")
      flash[:success] = pat(:create_success, :model => 'Staff')
      params[:save_and_continue] ? redirect(url(:staffs, :index)) : redirect(url(:staffs, :edit, :id => @staff.id))
    else
      @title = pat(:create_title, :model => 'staff')
      flash.now[:error] = pat(:create_error, :model => 'staff')
      render 'staffs/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "staff #{params[:id]}")
    @lines = Line.all.map{|cat| [cat.name, cat.id]}
    @staff = Staff.find(params[:id])
    if @staff
      render 'staffs/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'staff', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "staff #{params[:id]}")
    @staff = Staff.find(params[:id])
    if @staff
      if @staff.update_attributes(params[:staff])
        flash[:success] = pat(:update_success, :model => 'Staff', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:staffs, :index)) :
          redirect(url(:staffs, :edit, :id => @staff.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'staff')
        render 'staffs/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'staff', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Staffs"
    staff = Staff.find(params[:id])
    if staff
      if staff.destroy
        flash[:success] = pat(:delete_success, :model => 'Staff', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'staff')
      end
      redirect url(:staffs, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'staff', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Staffs"
    unless params[:staff_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'staff')
      redirect(url(:staffs, :index))
    end
    ids = params[:staff_ids].split(',').map(&:strip)
    staffs = Staff.find(ids)
    
    if Staff.destroy staffs
    
      flash[:success] = pat(:destroy_many_success, :model => 'Staffs', :ids => "#{ids.join(', ')}")
    end
    redirect url(:staffs, :index)
  end
end

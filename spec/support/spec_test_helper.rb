# module SpecTestHelper   
#   def login_admin
#     login(:admin)
#   end

#   def login(user)
#     user = User.where(:login => user.to_s).first if user.is_a?(Symbol)
#     request.session[:user_id] = user.id
#   end

#   def current_user
#     User.find(request.session[:user_id])
#   end
# end


module ControllerHelpers
  def sign_in(user = double('user'))
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {scope: :user})
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
end
